-module(chicagoboss_org_api_controller, [Req]).
-compile(export_all).
-default_action(api).

api('GET', [View]) ->
	{render_other, [{action, View}]}.
