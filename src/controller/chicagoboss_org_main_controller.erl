-module(chicagoboss_org_main_controller, [Req]).
-compile(export_all).
-default_action(index).


index('GET', _) ->
	{ok, [{codelinks, codelinks:controller(?MODULE, index)}]}.

download('GET', _) ->
	{ok, [{codelinks, codelinks:controller(?MODULE, download)},{version, "0.8.11"}]}.

about('GET', _) ->
	{ok, [{codelinks, codelinks:controller(?MODULE, about)}]}.

community('GET', _) ->
	{ok, [{codelinks, codelinks:controller(?MODULE, community)}]}.

contact('GET', _) ->
	{ok, [{codelinks, codelinks:controller(?MODULE, contact)}]}.

demos('GET', _) ->
	{ok, [{codelinks, codelinks:controller(?MODULE, contact)}]}.
