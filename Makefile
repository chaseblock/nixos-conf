RESET := $(shell tput sgr0)
BOLD  := $(shell tput bold)
RED   := $(shell tput setaf 1)
GREEN := $(shell tput setaf 2)
BLUE  := $(shell tput setaf 4)

.PHONY: update clean history frame frame-switch frame-test frame-boot
.DEFAULT_GOAL := $(shell hostname -s)

# Utility commands
update:
	@echo "$(BOLD)$(GREEN)===== Updating flake lock =====$(RESET)"
	nix flake update

clean:
	@echo "$(BOLD)$(GREEN)===== Running nix-collect-garbage =====$(RESET)"
	sudo nix-collect-garbage --delete-older-than 7d

history:
	@echo "$(BOLD)$(GREEN)===== Showing system generation history =====$(RESET)"
	nix profile history --profile /nix/var/nix/profiles/system

frame: frame-switch
frame-switch:
	@if [ "$$(uname)" != "Linux" ]; then \
		echo "$(BOLD)$(RED)===== okay an honest mistake =====$(RESET)"; \
		exit 1; \
	fi
	@echo "$(BOLD)$(BLUE)=====> Building frame (Framework 13 AMD 300 Series, NixOS) <=====$(RESET)"
	sudo nixos-rebuild switch --flake .#frame

frame-test:
	@if [ "$$(uname)" != "Linux" ]; then \
		echo "$(BOLD)$(RED)===== come on theo =====$(RESET)"; \
		exit 1; \
	fi
	@echo "$(BOLD)$(BLUE)=====> Testing frame <=====$(RESET)"
	sudo nixos-rebuild test --flake .#frame

frame-boot:
	@if [ "$$(uname)" != "Linux" ]; then \
		echo "$(BOLD)$(RED)===== okay no way i would make this mistake =====$(RESET)"; \
		exit 1; \
	fi
	@echo "$(BOLD)$(BLUE)=====> Staging (next boot) frame <=====$(RESET)"
	sudo nixos-rebuild boot --flake .#frame
