%% @author jon <jon@deathray.tv>
%% @copyright 2011-2015 : jon.
%% @doc Main page resource.

-module(page_resource).

-export([
        init/1,
        content_types_provided/2,
        resource_exists/2,
        to_html/2
        ]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) -> {ok, undefined}.

content_types_provided(ReqData, Context) ->
    {[{"text/html", to_html},{"text/plain",to_text}], ReqData, Context}.

resource_exists(ReqData, Context) ->
    N = wrq:disp_path(ReqData),
    Y = deathray_utils:str_to_int(N),
    {Pages, _} = pagination:posts(Y),
    case Y =< Pages of
        true  -> {true, ReqData, Context};
        false -> {false, ReqData, Context}
    end.

to_html(ReqData, Context) ->
    N = wrq:disp_path(ReqData),
    Y = deathray_utils:str_to_int(N),
    {Pages, Ids} = pagination:posts(Y),
    List = [db_tools:read(X) || X <- Ids],
    Nentry = lists:flatten(List),
    Entries = lists:map(fun deathray_utils:format/1, Nentry),
    PageTitle = "Channel " ++ N,
    {ok, Content} = page_dtl:render([{entries, Entries}, {pagetitle, PageTitle}, {channel, Y}, {pages, Pages}]),
    {Content, ReqData, Context}.
