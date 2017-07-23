%% @author jon <jon@deathray.tv>
%% @copyright jon

%% @doc deathray startup code

-module(deathray).
-author('author <author@example.com>').
-export([start/0, start_link/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.

%% @spec start_link() -> {ok,Pid::pid()}
%% @doc Starts the app for inclusion in a supervisor tree
start_link() ->
    ensure_started(mnesia),
    application:set_env(webmachine, webmachine_logger_module, 
                        webmachine_logger),
    webmachine_util:ensure_all_started(webmachine),
    deathray_sup:start_link().

%% @spec start() -> ok
%% @doc Start the deathray server.
start() ->
    ensure_started(mnesia),
    application:set_env(webmachine, webmachine_logger_module, 
                        webmachine_logger),
    webmachine_util:ensure_all_started(webmachine),
    application:start(deathray).

%% @spec stop() -> ok
%% @doc Stop the deathray server.
stop() ->
    Res = application:stop(deathray),
    application:stop(webmachine),
    application:stop(mochiweb),
    application:stop(mnesia),
    application:stop(crypto),
    Res.
