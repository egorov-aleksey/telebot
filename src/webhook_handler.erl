-module(webhook_handler).

%% API
-export([
  init/2
]).


init(Req0, State) ->
  {ok, Body, _} = cowboy_req:read_body(Req0),
  io:format("Request body: ~p~n", [Body]),
  io:format("Request body is JSON: ~p~n", [jsx:is_json(Body)]),

  Data = jsx:decode(Body, [return_maps]),

  Message = maps:get(<<"message">>, Data),

  Text = maps:get(<<"text">>, Message),

  io:format("Text: ~w~n", [Text]),

  Req = cowboy_req:reply(200, #{}, Req0),

  {ok, Req, State}.
