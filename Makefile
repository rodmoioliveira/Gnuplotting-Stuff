#!make

help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; \
		{printf "%-14s %s\n", $$1, $$2}' | \
		sort

dependencies: ## Install dependencies
	@./dev/dependencies

code-fmt: ## Format bash files
	@./dev/code-fmt

code-fmt-check: ## Check format of bash files
	@./dev/code-fmt-check

code-lint: ## Run lint for bash files
	@./dev/code-lint

symlink: ## Add symlink to scripts in path
	@./dev/symlink

unsymlink: ## Remove symlink to scripts from path
	@./dev/unsymlink

readme: ## Write README.md
	@./dev/readme
	@./wrk2/dev/readme
	@./dstat/dev/readme

tests: ## Run tests
	@./dev/tests

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
.PHONY: tests
.PHONY: typos
.PHONY: typos-fix
.PHONY: unsymlink
