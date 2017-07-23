%% @author author <jon@deathray.tv>
%% @copyright jon

%% @doc Callbacks for the deathray application.

-module(deathray_app).
-author('author <author@example.com>').

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for deathray.
start(_Type, _StartArgs) ->
    deathray_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for deathray.
stop(_State) ->
    ok.
