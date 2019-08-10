-module(webhook_handler).

%% API
-export([
  init/2
]).


init(Req0, State) ->
  {ok, Body, _} = cowboy_req:read_body(Req0),

  Data = jsx:decode(Body, [return_maps]),

  Message = maps:get(<<"message">>, Data),
  Text = cow_uri:urlencode(maps:get(<<"text">>, Message)),
  Chat = maps:get(<<"chat">>, Message),
  ChatId = maps:get(<<"id">>, Chat),

  {ok, Token} = application:get_env(telebot, bot_token),

  SendMessageUrl = "https://api.telegram.org/bot" ++ Token ++ "/sendMessage?chat_id=" ++ integer_to_list(ChatId) ++ "&text=" ++ binary_to_list(Text),

  {ok, Res} = httpc:request(get, {SendMessageUrl, []}, [{timeout, 3000}], []),

  io:format("Request result: ~p~n", [Res]),

  Req = cowboy_req:reply(200, #{}, Req0),

  {ok, Req, State}.
