-module(myapp_landing_controller, [Req, SessionId]).
-compile(export_all).

-default_action(index).

index('GET', []) -> {ok, []}.

sayhello('GET', []) -> 
  Name = Req:query_param("name"),
  Log = logger:new(landing_controller),
  Log:info("~p", [Name]),
  actionResult:json_success([{response, ("Hello " ++ Name) ++ [$!]}]).
