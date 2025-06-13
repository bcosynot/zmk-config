# ZMK Firmware Development Guidelines

This document provides guidelines for developing and testing ZMK firmware for the Corne keyboard.

## Build/Configuration Instructions

### Prerequisites

- [ZMK Firmware](https://zmk.dev/docs/development/setup) development environment
- West (Zephyr meta-tool)
- ARM GCC toolchain
- Python 3.x with pip

### Building Firmware

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/zmk-config.git
   cd zmk-config
   ```

2. **Initialize West workspace**:
   ```bash
   west init -l config
   west update
   ```

3. **Build firmware**:
   ```bash
   west build -b nice_nano_v2 -- -DSHIELD=corne_left nice_view_adapter nice_view -DZMK_CONFIG=/path/to/zmk-config/config
   ```

   For the right half:
   ```bash
   west build -b nice_nano_v2 -- -DSHIELD=corne_right nice_view_adapter nice_view -DZMK_CONFIG=/path/to/zmk-config/config
   ```

4. **Flash firmware**:
   - Connect your nice!nano board
   - Put it in bootloader mode (double-tap reset button)
   - Copy the built firmware to the device:
     ```bash
     cp build/zephyr/zmk.uf2 /path/to/mounted/nice_nano
     ```

### GitHub Actions

This project uses GitHub Actions for automated builds. The configuration is in `build.yaml` and includes:
- Building for nice_nano_v2 with Corne left/right shields
- nice_view display support
- studio-rpc-usb-uart snippet for ZMK Studio support

### Configuration Options

Key configuration options in `corne.conf`:

- `CONFIG_ZMK_SLEEP=y` - Enable deep sleep for power saving
- `CONFIG_BT_CTLR_TX_PWR_PLUS_8=y` - Increase Bluetooth range
- `CONFIG_ZMK_KSCAN_DEBOUNCE_PRESS_MS=1` - Eager debouncing for press
- `CONFIG_ZMK_KSCAN_DEBOUNCE_RELEASE_MS=10` - Eager debouncing for release
- `CONFIG_ZMK_STUDIO=y` - Enable ZMK Studio support

### Custom Behaviors

When creating custom behaviors:
1. Define them in separate .dtsi files
2. Include these files in your keymap
3. Test thoroughly before deploying

### Bluetooth Profiles

The default configuration supports 5 Bluetooth profiles. Switch between them using:
- `&bt BT_SEL 0` through `&bt BT_SEL 4` - Select profile
- `&bt BT_CLR` - Clear current profile

### ZMK Studio Integration

This config includes ZMK Studio support for real-time keymap updates:
- `CONFIG_ZMK_STUDIO=y` - Enables ZMK Studio
- `CONFIG_ZMK_STUDIO_LOCKING=n` - Disables locking (allows changes without authentication)

### Useful Resources

- [ZMK Documentation](https://zmk.dev/docs)
- [ZMK User's Guide](https://zmk.dev/docs/user-setup)
- [ZMK Behaviors Reference](https://zmk.dev/docs/behaviors/key-press)
- [ZMK Discord Community](https://zmk.dev/community/discord)
