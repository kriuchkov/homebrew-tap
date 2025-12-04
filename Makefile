.PHONY: update help

# Update a cask
# Usage: make update CASK=linkswitch VERSION=1.1.0
CASK ?= 
VERSION ?= 

update:
	@if [ -z "$(CASK)" ] || [ -z "$(VERSION)" ]; then \
		echo "Usage: make update CASK=linkswitch VERSION=1.1.0"; \
		exit 1; \
	fi
	./scripts/update-cask.sh $(CASK) $(VERSION) \
		"https://github.com/kriuchkov/$(CASK)/releases/download/v$(VERSION)/LinkSwitch.zip"


help:
	@echo "Homebrew Tap Management"
	@echo ""
	@echo "Commands:"
	@echo "  make update CASK=linkswitch VERSION=1.1.0  - Update cask to new version"
	@echo ""
	@echo "Available casks:"
	@ls -1 Casks/*.rb 2>/dev/null | xargs -I {} basename {} .rb | sed 's/^/  - /'
