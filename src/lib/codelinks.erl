-module(codelinks).
-compile(export_all).

build_url(File) ->
    "https://github.com/ChicagoBoss/chicagoboss.org/blob/master/" ++ File.

controller(Controller, Action) ->
    StrAction = atom_to_list(Action),
    StrController = atom_to_list(Controller),

    %% Action names are <appname>_<controllername>_controller, but we know that
    %% the app is chicagoboss_org, so let's just parse out the controller name.
    case re:run(StrController, "^chicagoboss_org_(\\w+)_controller$", [{capture, all_but_first, list}]) of
        {match, [JustController]} ->
            [
             %% The source code for the controller
             "src/controller/" ++ StrController ++ ".erl",

             %% The source code for the view
             "src/view/" ++ JustController ++ "/" ++ StrAction ++ ".html",

             %% The base view (which the different controllers and actions inherit)
             "src/view/base.html"
            ]
    end.
