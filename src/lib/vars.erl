-module(vars).
-compile(export_all).

%% add environment = production to your heroku app env vars
debug_mode() ->  
  case os:getenv("environment") of
    production -> false;
    _ -> true
  end.

