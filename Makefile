build:
	jbuilder build

doc:
	jbuilder build @odc

clean:
	jbuilder clean

.PHONY: build doc clean

VERSION      := $$(opam query --version)
NAME_VERSION := $$(opam query --name-version)
ARCHIVE      := $$(opam query --archive)

release:
	git tag -a v$(VERSION) -m "Version $(VERSION)."
	git push origin v$(VERSION)
	opam publish prepare $(NAME_VERSION) $(ARCHIVE)
	opam publish submit $(NAME_VERSION)
	rm -rf $(NAME_VERSION)

.PHONY: gh-pages release all-supported-ocaml-versions

all-supported-ocaml-versions:
	jbuilder build @install --workspace jbuild-workspace.dev
