.PHONY: help update full-update

help:
	@echo AVAILABLE COMMANDS
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-23s\033[0m%s\n", $$1, $$2}'

update: ## Update catalog and app images in docker-compose.yml to specified version
ifndef VERSION
	$(error VERSION is not set)
endif

	@sed -Ei -e 's/(image: matatika\/(catalog|app)).*/\1:$(VERSION)/g' docker-compose.yml

full-update: update ## Update, commit changes and tag
	@git commit -m 'Update image tags to `$(VERSION)`' docker-compose.yml
	@git tag '$(VERSION)'
