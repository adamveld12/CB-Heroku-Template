-module(logger, [Name]).
-export([info/1, info/2, error/1, error/2, warn/1, warn/2]).

% conditionally logs to the console if debug mode = true

info(Message) -> log(info, Message, []).
info(Message, Args) when is_list(Args) -> log(info, Message, Args).

warn(Message) -> log(warn, Message, []).
warn(Message, Args) when is_list(Args) -> log(warn, Message, Args).

error(Message) -> log(error, Message, []).
error(Message, Args) when is_list(Args) -> log(error, Message, Args).

log(warn, FormatString, Args) -> logMessage("[warn] : " ++ FormatString, Args);
log(info, FormatString, Args) -> logMessage("[info] : " ++ FormatString, Args);
log(error, FormatString, Args) -> logMessage("[error] : " ++ FormatString, Args).

logMessage(FormatString, Args) -> logMessage(ok, FormatString, [ case is_binary(X) of true -> binary_to_list(X); _ -> X end || X <- Args]).
logMessage(ok, FormatString, Args) -> 
  case vars:debug_mode() of
    true -> 
      {Date, Time} = calendar:now_to_universal_time(erlang:now()),
      {Yr, Mth, Day} = Date, 
      {Hr, Min, Sec} = Time,
      io:format("[ ~p/~p/~p ~p:~p:~p ] ~p | ", [Yr,Mth,Day,Hr,Min,Sec,Name]),
      io:format(FormatString, Args),
      io:format("~n");
    _ -> undefined
  end.
