-module(chicagoboss_org_trans_controller, [Req]).
-compile(export_all).
-default_action(trans).

%% ChicagoBoss uses the {% trans %} and {% blocktrans %} tags in your ErlyDTL
%% templates. 
%%
%% In order for ChicagoBoss to actually *do* the translation, it has to have
%% the translation *files*.  The easiest way to do this is to add your tags to
%% your view, then add cb_admin to your project and use the language module in
%% cb_admin.  Or you can manually edit these files.  They are all found in your
%% applications /priv/lang directory and have one file per language.  The file
%% names must be strings.LANG.po, where LANG is your language of choice, and
%% each file consists of pairs of msgid and msgstr lines. You can see an
%% example of what one of these files look like in the Wiki:
%% https://github.com/ChicagoBoss/ChicagoBoss/wiki/Internationalization
%%
%% The "msgid" will correspond with the text in a {% trans %} tag or a set of
%% {% blocktrans %} {% endblocktrans %} tags.  For example, if you have a `{%
%% trans "hello" %}` tag in your view, you must also have a `msgid "hello"`
%% line along with a `msgstr "hallo"` line in your strings.de.po.
%%
%% One way to do translations with ChicagoBoss is to use the lang_ filter:
%%
%% Any requests to /trans/filter/LANG will translate the page into the
%% specified lang but using a `lang_` filter.  lang_ must return either the
%% text of the desired language or the atom 'auto' which just means it will use
%% it's autofiltering mechanism.  As you can see lang_/2 accepts the current
%% Action as a string as well as a Context variable, which is a proplist of
%% various items. One of these proplist items in our list is `tokens`, which is
%% the list of stuff after /CONTROLLER/ACTION (tokenized on forward slash (/)
%% ).  So In our case, a request to /trans/filter/de will yield a `tokens`
%% value of ["de"]

lang_(_Action, _Context) -> auto;
lang_("filter", Context) ->
	case proplists:get_value(tokens, Context) of
		[] -> "en";
		[Lang] -> Lang
	end.

%% Another common way to do translations with ChicagoBoss is to specify the
%% "Content-language" header in your action's return.  In our case here, it
%% will work the same as our filter example above, except you must simply
%% specify a different action.  So a request to /trans/header/de will translate
%% the page into German.
%%
%% NOTE: That the "Content-Language" header will override all other means of
%% translation. Meaning that if you specify the "Content-Language" header for
%% translation, then no filters will apply, nor will ChicagoBoss's autolanguage
%% chooser based on the client's Accept-Language header.

header('GET',[Lang]) ->
	{ok, [], [{"Content-Language", Lang}]}.

%% This is simply our filter action, which doesn't do anything except tell
%% ChicagoBoss we want to use the ErlyDTL view.
filter('GET',_) ->
	ok.


%% ChicagoBoss and ErlyDTL can also work together to translate variables passed
%% into the templates.  In this case, having a {% trans my_prase %} tag in
%% yoiur template will result in the variable first being replaced by the
%% contents of MyPhrase, and then translated according to its contents.
variable('GET', [MyPhrase]) ->
	{ok, [{my_phrase, MyPhrase}], [{"Content-Language", "de"}}.
