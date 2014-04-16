-module(chicagoboss_org_main_controller, [Req]).
-compile(export_all).
-default_action(index).

index('GET', _) ->
	ok.

download('GET', _) ->
	{ok, [{version, "0.8.11"}]}.

about('GET', _) ->
	ok.

community('GET', _) ->
	ok.

contact('GET', _) ->
	ok.
