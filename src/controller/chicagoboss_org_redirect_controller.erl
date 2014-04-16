-module(chicagoboss_org_redirect_controller, [Req]).
-compile(export_all).

moved_google('GET', _) ->
	{moved, "http://google.com"}.
