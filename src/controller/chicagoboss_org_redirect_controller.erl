-module(chicagoboss_org_redirect_controller, [Req]).
-compile(export_all).

index('GET', _) ->
	DemoLinks = demo_links(),
	Variables = [
				 {header, "Redirection Demos"},
				 {subheader, "<a href='/demo'>&larr; Back to Demos</a>"},
				 {codelinks, codelinks:controller(?MODULE, index)},
				 {demos, DemoLinks}
				],
	{ok, Variables}.

demo_links() ->
	[
	 {"/redirect/action_other/my_other_action", "action_other to another action in this controller", ""},
	 {"/redirect/action_other/other_controller", "action_other to a different controller", ""},
	 {"/redirect/moved/string", "301 moved redirect by specifying a URL string", ""},
	 {"/redirect/moved/action", "301 moved redirect by specifying a route proplist", ""},
	 {"/redirect/render_other", "Render a view from a different action", ""},
	 {"/redirect/not_found", "Return a 404 not found", ""}
	].
	
not_found('GET', _) ->
	not_found.

render_other('GET', _) ->
	OtherLocation = [{action, index}],
	Variables = [
				 {header, "This is the index view even though we're in the render_other action. How exciting!"},
				 {subheader, "<a href='/redirect'>&larr; Back to Redirection Demos</a>"},
				 {codelinks, [
								codelinks:controller_only(?MODULE),
								codelinks:view_only(?MODULE, index),
								codelinks:view_only("base.html")
							 ]},
				 {demos, []}
				],
	{render_other, OtherLocation, Variables}.

action_other('GET', ["my_other_action"]) ->
	{action_other, [{action, my_other_action}]};

action_other('GET', ["other_controller"]) ->
	{action_other, [{controller, main}, {action, from_demo}]}.

moved('GET', ["string"]) ->
	{moved, "http://github.com/ChicagoBoss"};

moved('GET', ["action"]) ->
	{moved, [{controller, "redirect"}, {action, "moved_destination"}]}.

my_other_action('GET', _) ->
	{200, "This is another action in the 'redirect' controller. Rejoice! Now <a href='/redirect'>get out of here</a>!"}.

moved_destination('GET', _) ->
	{200, "You've successfully moved destinations. <a href='/redirect'>Go Back</a>"}.

stream('GET', _) ->
	Streamer = fun(start) -> {output, "This will begin transferring one chunk every second for 10 seconds\n<br>", 10};
				  (0) -> done;
				  (Num) -> timer:sleep(1000),
						   {output, [integer_to_list(Num), "<br>\n"], Num-1}
			   end,
	{stream, Streamer, start}.
