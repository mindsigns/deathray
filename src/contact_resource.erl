%% @author jon <jon@deathray.tv>
%% @copyright 2011-2015: jon.
%% @doc contact resource.

-module(contact_resource).

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
    PageTitle = "Contact",
    {ok, Content} = contact_dtl:render([{pagetitle, PageTitle}]),
    {Content, ReqData, Context}.
