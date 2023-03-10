#!make

help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; \
		{printf "%-14s %s\n", $$1, $$2}' | \
		sort

dependencies: ## Install dependencies
	@./dev/dependencies

code-fmt: ## Format bash files
	@fd . -t f -e sh --absolute-path | xargs shfmt -i 2 -w
	@fd pwrk2 -t f --absolute-path | rg png -v | xargs shfmt -i 2 -w

code-fmt-check: ## Check format of bash files
	@fd . -t f -e sh --absolute-path | xargs shfmt -i 2 -d
	@fd pwrk2 -t f --absolute-path | rg png -v | xargs shfmt -i 2 -d

code-lint: ## Run lint for bash files
	@fd . -t f -e sh --absolute-path | xargs shellcheck -o all

symlink: ## Add symlink to scripts in path
	@./dev/symlink

unsymlink: ## Remove symlink to scripts from path
	@./dev/unsymlink

readme: ## Write README.md
	@./dev/readme
	@./wrk2/dev/readme

typos: ## Check typos
	@typos

typos-fix: ## Fix typos
	@typos -w

.PHONY: help
.PHONY: code-fmt
.PHONY: code-fmt-check
.PHONY: code-lint
.PHONY: dependencies
.PHONY: readme
.PHONY: symlink
.PHONY: typos
.PHONY: typos-fix
.PHONY: unsymlink
