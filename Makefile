.PHONY: get-deps compile docs

all: get-deps docs compile

get-deps:
	./rebar get-deps

docs:
	@echo Copying and formatting docs...
	@(mkdir -p ./src/view/api)
	@(mkdir -p ./priv/static/api)
	@(cp deps/boss/doc-src/*.html ./src/view/api/)
	@(cp deps/boss/doc-src/boss.css ./priv/static/api)
	@(sed -i 's/boss\.css/\/static\/api\/boss.css/g' src/view/api/api.html)
	@(find ./src/view/api/ -name "api-*.html" -exec sed -i 's/api\.html/api\/api.html/1' {} \;)

compile:
	./rebar compile
