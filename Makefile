.DEFAULT_GOAL := help

all: format clean docs install-deps init help requirements validate test test-debug

.PHONY: help all

help: ## generate make help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

format: ## sort imports and paint it black
	# Limit to these directories so that if there is a virtualenv
	# in the current directory it does not get black formatted
	isort -rc .
	black .

install-deps: ## install python requirements
	# Install the dev requirements
	pip install -r deps/dev-requirements.txt

	# Ensure only the dev requirements are installed
	pip-sync deps/dev-requirements.txt

	# For local package use: pip install -e .[dev]	

init: install-deps ## initialize project with dependencies and pre-commit hooks
	pre-commit install -t pre-push

requirements: ## create the requirement files
	pip-compile -o deps/requirements.txt deps/requirements.in
	pip-compile -o deps/dev-requirements.txt deps/requirements.txt deps/dev-requirements.in

validate:  ## run pre-commit validation
	pre-commit run --all-files
