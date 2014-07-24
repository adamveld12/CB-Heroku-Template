-module(actionResult).
-export([
  json_error/0, json_error/1, json_error/2, 
  json_success/0, json_success/1, json_success/2,
  json_not_implemented/0]).

%% A small set of json controller action results that make it easy to send json back and forth with chicago boss.
json_error() -> {json, [{result, error}]}.
json_error(Payload) -> {json, [{result, error}, {errors, stringify(Payload)}]}.
json_error(Payload, Headers) -> {json, [{result, error}, {error, stringify(Payload)}], Headers}.

json_success() -> {json, [{result, success}]}.
json_success(Payload) -> {json, [{result, success}, {data, stringify(Payload)}]}.
json_success(Payload, Headers) -> {json, [{result, success}, {data, stringify(Payload)}], Headers}.

stringify(Payload) -> [ case is_binary(X) of true -> binary_to_list(X); _ -> X end || X <- Payload].


json_not_implemented() -> json_error(["API Route Not Implemented."]).
