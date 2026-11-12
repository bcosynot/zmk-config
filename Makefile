KEYMAP_DRAWER ?= uvx --from keymap-drawer keymap
KEYMAP_DRAWER_CONFIG := keymap_drawer.config.yaml
KEYMAP := config/corne.keymap
KEYMAP_OUTPUT_DIR := keymap-drawer

# Fail the recipe if `keymap parse` fails, not just the awk at the end of the pipe.
SHELL := /bin/bash
.SHELLFLAGS := -o pipefail -c

.PHONY: draw
draw:
	mkdir -p $(KEYMAP_OUTPUT_DIR)
	$(KEYMAP_DRAWER) -c $(KEYMAP_DRAWER_CONFIG) parse -z $(KEYMAP) \
		| awk '/^- p: /{sub(/^- /, "- l: [Base]\n  ")} 1' > $(KEYMAP_OUTPUT_DIR)/corne.yaml
	$(KEYMAP_DRAWER) -c $(KEYMAP_DRAWER_CONFIG) draw $(KEYMAP_OUTPUT_DIR)/corne.yaml -z corne > $(KEYMAP_OUTPUT_DIR)/corne.svg
