%% @author jon <jon@deathray.tv>
%% @copyright 2011-2015 : jon.
%% @doc archive resource.

-module(archive_resource).

-export([
        init/1,
        to_html/2,
        content_types_provided/2
        ]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) -> {ok, undefined}.

content_types_provided(ReqData, Context) ->
    {[{"text/html", to_html},{"text/plain",to_text}], ReqData, Context}.

to_html(ReqData, Context) ->
    Tentry = db_tools:showall(),
    Nentry = lists:reverse(lists:keysort(2, Tentry)),
    Entries = lists:map(fun deathray_utils:format/1, Nentry),
    PageTitle = "Archive",
    {ok, Content} = archive_dtl:render([{entries, Entries}, {pagetitle, PageTitle}]),
    {Content, ReqData, Context}.
