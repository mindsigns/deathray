%% @author jon <jon@deathray.tv>
%% @copyright 2011-2015 : jon.
%% @doc show page resource.

-module(show_resource).
-export([
        init/1,
        content_types_provided/2,
        resource_exists/2,
        to_html/2
        ]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) -> {ok, undefined}.

content_types_provided(ReqData, Context) ->
   {[{"text/html",to_html}], ReqData, Context}.

resource_exists(ReqData, Context) ->
    N = wrq:disp_path(ReqData),
    Y = deathray_utils:str_to_int(N),
    case lists:member(Y, deathray_utils:ok_ids()) of
        true  -> {true, ReqData, Context};
        false ->
            io:format("Fuuuuk!\n"),
            {false, ReqData, Context}
    end.

to_html(ReqData, Context) ->
    N = wrq:disp_path(ReqData),
    Y = deathray_utils:str_to_int(N),
    Tentry = db_tools:read(Y),
    Entries = lists:map(fun deathray_utils:format/1, Tentry),
    PageTitle = "Transmit",
    {ok, Content} = show_dtl:render([{entries, Entries}, {pagetitle, PageTitle}]),
    {Content, ReqData, Context}.
