-module(authlib).
-export([digest/1,
        hash_password/1,
        session_token/1,
        check_password/2,
        get_login_cookies/2,
        remove_login_cookies/0,
        authenticate_req/2,
        authenticate_user/3]).

-define(TOKEN_KEY, "my%secret%string").

%% this module is meant to do some of the heavy lifting for
%% authentication and session management. Bring in bcrypt
%% and uncomment the bcrypt calls if you want to use that instead.

gen_salt() -> 
  %% {ok, Salt} = bcrypt:gen_salt(), 
  Salt = erlang:md5(erlang:now()),
  Salt.

gen_pw(Password, Salt) -> 
  %% {ok, Hash} = bcrypt:hashpw(Password, Salt), 
  Hash = mochihex:to_hex(Salt ++ Password),
  Hash.

digest(Value) -> mochihex:to_hex(erlang:md5(Value)).

check_password(Hash, Password) ->
  PassHash = gen_pw(Password, Hash),
  Log = logger:new(authlib),
  Log:info("Hash ~p =:= Pass ~p ? ~p", [Hash, PassHash, iolist_to_binary(Hash) =:= iolist_to_binary(PassHash)]),
  iolist_to_binary(Hash) =:= iolist_to_binary(PassHash).

hash_password(Password) -> 
  Salt = gen_salt(),
  Hash = gen_pw(Password, Salt).

session_token(SessionId) -> digest(SessionId ++ digest(?TOKEN_KEY)).

get_login_cookies(User, SessionId) ->
  [
    mochiweb_cookies:cookie("user_id", User:id(), [{path, "/"}]), 
    mochiweb_cookies:cookie("session_id", session_token(SessionId), [{path, "/"}])
  ].

remove_login_cookies() ->
  [
    mochiweb_cookies:cookie("user_id", "", [{path, "/"}]), 
    mochiweb_cookies:cookie("session_id", "", [{path, "/"}])
  ].

authenticate_req(Req, SessionId) ->
  SessionToken = session_token(SessionId),
  ErrorResponse = actionResult:json_error(["User is not authenticated"]),
  case Req:cookie("user_id") of
    undefined -> ErrorResponse;
    Id -> 
      case boss_db:find(Id) of
        undefined -> ErrorResponse;
        User -> 
          case session_token(SessionId) =:= Req:cookie("session_id") of
            false -> ErrorResponse;
            true -> {ok, User}
          end
      end
  end.

user_in_role(User, Roles) ->
  UserRoles = User:get_roles(),
  length([X || X <- UserRoles, Y <- Roles, X =:= Y]) > 0. 

authenticate_user(Username, Password, SessionId) ->
  ErrorResponse = actionResult:json_error(["Username/Password combination was incorrect."]),
  case boss_db:find(userAccount, [{username, Username}], [{limit, 1}]) of
    [User] ->
      case check_password(User:password_hash(), Password) of
        true -> 
          Token = session_token(SessionId), 
          actionResult:json_success([{token, Token}]);
        _ -> ErrorResponse
      end;
    [] -> ErrorResponse
  end.
