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
  Chat = maps:get(<<"chat">>, Message),
  ChatId = maps:get(<<"id">>, Chat),

  io:format("ChatId, Text: ~p~p~n", [ChatId, Text]),

  SendMessageUrl = "https://api.telegram.org/bot491597762:AAFt2yvixsHfU0aaMCWEyPNoZupzo3i4E74/sendMessage?chat_id="
    ++ integer_to_list(ChatId) ++ "&text=" ++ binary_to_list(Text),

  httpc:request(get, {SendMessageUrl, []}, [], []),

  Req = cowboy_req:reply(200, #{}, Req0),

  {ok, Req, State}.
