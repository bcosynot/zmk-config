KEYMAP_DRAWER ?= uvx --from keymap-drawer keymap
KEYMAP_DRAWER_CONFIG := keymap_drawer.config.yaml
KEYMAP := config/corne.keymap
KEYMAP_OUTPUT_DIR := keymap-drawer

.PHONY: draw
draw:
	mkdir -p $(KEYMAP_OUTPUT_DIR)
	$(KEYMAP_DRAWER) -c $(KEYMAP_DRAWER_CONFIG) parse -z $(KEYMAP) > $(KEYMAP_OUTPUT_DIR)/corne.yaml
	$(KEYMAP_DRAWER) -c $(KEYMAP_DRAWER_CONFIG) draw $(KEYMAP_OUTPUT_DIR)/corne.yaml -z corne > $(KEYMAP_OUTPUT_DIR)/corne.svg
