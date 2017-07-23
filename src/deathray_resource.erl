%% @author jon <jon@deathray.tv>
%% @copyright 2011-2015 : jon.
%% @doc Main page resource.

-module(deathray_resource).

-export([
        init/1,
        resource_exists/2,
        to_html/2,
        to_text/2,
        content_types_provided/2
        ]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) -> {ok, undefined}.

content_types_provided(ReqData, Context) ->
    {[{"text/html", to_html},{"text/plain",to_text}], ReqData, Context}.

resource_exists(ReqData, Context) ->
    Path = wrq:path(ReqData),
    case Path of
        [_] -> {true, ReqData, Context};
        _ -> error
    end.

to_text(ReqData, Context) ->
    Path = wrq:disp_path(ReqData),
    Body = io_lib:format("~s Hello from the Deathray.~n", [Path]),
    {Body, ReqData, Context}.

to_html(ReqData, Context) ->
    Tentry = db_tools:showall(),
    Rentry = lists:reverse(lists:keysort(2, Tentry)),
    Centry = lists:sublist(Rentry, 10),
    Entries = lists:map(fun deathray_utils:format/1, Centry),
    PageTitle = "Main",
    {ok, Content} = base_dtl:render([{entries, Entries}, {pagetitle, PageTitle}]),
    {Content, ReqData, Context}.

