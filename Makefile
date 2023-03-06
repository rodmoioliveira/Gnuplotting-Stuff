#!make

help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; \
		{printf "%-14s %s\n", $$1, $$2}' | \
		sort

code-fmt: ## Format sh files
	@fd . -t f -e sh --absolute-path | xargs shfmt -i 2 -w

code-lint: ## Run lint for sh files
	@fd . -t f -e sh --absolute-path | xargs shellcheck -o all

typos: ## Check typos
	@typos

typos-fix: ## Fix typos
	@typos -w

.PHONY: code-fmt
.PHONY: code-lint
.PHONY: help
.PHONY: typos
.PHONY: typos-fix
