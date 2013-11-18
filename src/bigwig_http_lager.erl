%%
%% show details on a specific process
%%
-module(bigwig_http_lager).
-behaviour(cowboy_http_handler).
-export([init/3, handle/2, terminate/3]).

init({tcp, http}, Req, _Opts) ->
    {ok, Req, undefined_state}.

handle(Req0, State) ->
    {Path, Req} = cowboy_req:path(Req0),
    {Method, Req1} = cowboy_req:method(Req),
    Path1=lists:delete(<<>>,binary:split(Path,[<<"/">>],[global])),
    handle_path(Method, Path1, Req1, State).

handle_path(<<"GET">>, [<<"lager">>, <<"status">>], Req, State) ->
    not_found(Req, State);
handle_path(<<"GET">>, [<<"lager">>, <<"tracer">>, RoutingKey], Req, State) ->
    not_found(Req, State);
handle_path(<<"PUT">>, [<<"lager">>, <<"tracer">>, Tracer], Req, State) ->
    not_found(Req, State);
handle_path(<<"DELETE">>, [<<"lager">>, <<"tracer">>, Tracer], Req, State) ->
    not_found(Req, State);
handle_path(_, _, Req, State) ->
    not_found(Req, State).

not_found(Req, State) ->
    {ok, Req2} = cowboy_req:reply(404, [], <<"<h1>404</h1>">>, Req),
    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
    ok.
