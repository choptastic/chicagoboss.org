-module(codelinks).
-compile(export_all).

build_url(File) ->
    "https://github.com/ChicagoBoss/chicagoboss.org/blob/master/" ++ File.

controller(Controller, Action) ->
	controller(Controller, Action, []).

controller(Controller, Action, OtherFiles) ->
    %% Action names are <appname>_<controllername>_controller, but we know that
    %% the app is chicagoboss_org, so let's just parse out the controller name.
   	[
		 %% The source code for the controller
		 controller_only(Controller),

		 %% The source code for the view
		 view_only(Controller, Action)

		 %% Other Files worth linking
		 ] ++ OtherFiles ++ [

		 %% The base view (which the different controllers and actions inherit)
		 view_only("base.html")
	].

parse_controller_name(Controller) when is_atom(Controller) ->
    StrController = atom_to_list(Controller),
	parse_controller_name(StrController);
parse_controller_name("chicagoboss_org_" ++ ControllerRest) ->
    case re:run(ControllerRest, "^(\\w+)_controller$", [{capture, all_but_first, list}]) of
		{match, [ControllerName]} ->
			ControllerName;
		nomatch ->
			ControllerRest
	end;
parse_controller_name(StrController) ->
	StrController.

controller_only(Controller) when is_atom(Controller) ->
	controller_only(atom_to_list(Controller));
controller_only(FullController = "chicagoboss_org_" ++ _) ->
	"src/controller/" ++ FullController ++ ".erl";
controller_only(ControllerName) ->
	controller_only("chicagoboss_org_" ++ ControllerName ++ "_controller").

view_only(Controller, Action) when is_atom(Action) ->
	view_only(Controller, atom_to_list(Action));
view_only(Controller, Action) ->
	ControllerName = parse_controller_name(Controller),
	"src/view/" ++ ControllerName ++ "/" ++ Action ++ ".html".

view_only(File) ->
	"src/view/" ++ File.

lib_only(File) ->
	"src/lib/" ++ File.
