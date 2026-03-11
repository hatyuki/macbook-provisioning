LOG_LEVEL ?= debug
NODES_DIR ?= nodes
TARGETS   ?= $(notdir $(basename $(wildcard $(NODES_DIR)/*.yaml)))
RECIPE    ?= recipe.rb
.DEFAULT_GOAL := help


### Help

help: ## print this message
	@echo "Usage: make TARGET"
	@echo ""
	@printf "\033[36m%-30s\033[0m %s\n" "[TARGET]" "[Description]"
	@perl -nle 'printf "\033[36m%-30s\033[0m %-50s %s\n", $$1, $$2 if m!^([-_@/A-z]+):.+##\s+([^#]+)*$$!' $(MAKEFILE_LIST)
.PHONY: help


### Provisioning

$(TARGETS): bin/mitamae ## provisioning
	@bin/mitamae local --node-yaml=$(NODES_DIR)/$@.yaml --log-level=$(LOG_LEVEL) $(RECIPE)
.PHONY: $(TARGETS)


### Install mitamae

bin/mitamae: ## install mitamae
	./scripts/install-mitamae.bash


### Cleanup

clean: ## cleanup
	$(RM) bin/mitamae
.PHONY: clean
