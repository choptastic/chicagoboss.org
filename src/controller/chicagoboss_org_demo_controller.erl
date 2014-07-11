-module(chicagoboss_org_demo_controller, [Req]).
-compile(export_all).

index('GET', _) ->
	DemoLinks = demo_links(),
	Variables = [
				 {codelinks, codelinks:controller(?MODULE, index)},
				 {demos, DemoLinks}
				],
	{ok, Variables}.

demo_links() ->
	[
	 {"/simple", "Simple Controllers", "Very simple controllers and views, incorporating template variables, sessions, and JSON requests"},
	 {"/form", "Simple Forms", "Demonstrating a simple HTML <form> and collecting inputs"},
	 {"/redirect", "Redirection", "Demonstrating action returns which redirect the browser, execute other actions, load views from other controllers/actions"},
	 {"/mail", "Mail Receiver and Messages", "Demonstrating a simple controller which receives mail from SMTP and renders received mails on the browser."},
	 {"/chat", "Chatroom with Websockets", "A simple chatroom with websockets"}
	].
