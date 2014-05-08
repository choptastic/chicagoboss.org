-module(chicagoboss_org_view_lib_tags).

-export([source_dir/0, dependencies/0,
	 translatable_strings/0, render/1, render/2, render/3]).

source_dir() -> "src/view/lib/tag_html".

dependencies() -> [].

translatable_strings() -> [].

render(Tag) -> render(Tag, [], []).

render(Tag, Vars) -> render(Tag, Vars, []).

render(Tag, Vars, Opts) ->
    try chicagoboss_org_view_lib_tags:Tag(Vars, Opts) of
      Val -> {ok, Val}
    catch
      Err -> {error, Err}
    end.
