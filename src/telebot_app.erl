-module(telebot_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
  Dispatch = cowboy_router:compile([
    {'_', [
      {"/wh", webhook_handler, []}
    ]}
  ]),
  {ok, _} = cowboy:start_clear(http, [{ip, {0, 0, 0, 0}}, {port, 5000}],
    #{env => #{dispatch => Dispatch}}),

  telebot_sup:start_link().

stop(_State) ->
  ok.
