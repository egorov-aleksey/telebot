-module(webhook_handler).

%% API
-export([
  init/2
]).


init(Req0, State) ->
  io:format("~nRequest: ~p~n", [Req0]),

  Method = cowboy_req:method(Req0),
  io:format("~nRequest method: ~p~n", [Method]),

  {ok, Body, _} = cowboy_req:read_body(Req0),
  io:format("~nRequest body: ~p~n", [Body]),

%%  Req = cowboy_req:reply(200, #{
%%    <<"content-type">> => <<"text/plain">>
%%  }, <<"Hello World!">>, Req0),
  {ok, Req0, State}.
