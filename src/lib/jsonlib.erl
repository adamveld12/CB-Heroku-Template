-module(jsonlib).
-compile(export_all).

% a simple json helper object because 
% doing it by hand everytime is a pain in the ass
get_json(Req) -> 
  {_, Body} = mochijson2:decode(Req:request_body()),
  fun(Key) when is_atom(Key) -> 
    binary_to_list(proplists:get_value(iolist_to_binary(atom_to_list(Key)), Body));
  (Key) when is_list(Key) -> 
    binary_to_list(proplists:get_value(iolist_to_binary(Key), Body)) 
  end.
