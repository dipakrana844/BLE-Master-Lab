# BLE Master Lab

A comprehensive Bluetooth Low Energy (BLE) testing and exploration application built with Flutter. This app provides a complete suite of tools for discovering, connecting to, and interacting with BLE devices.

## Screenshots

<p align="center">
  <img src="screenshot/Discovery.jpg" alt="Device Discovery Screen" width="800" />
</p>

## Features

- **Device Discovery**: Scan and discover nearby BLE devices with real-time RSSI monitoring
- **Connection Management**: Establish and manage connections to BLE peripherals
- **GATT Explorer**: Browse and interact with GATT services, characteristics, and descriptors
- **Data Operations**: Read, write, and subscribe to characteristic notifications
- **Simulation Mode**: Test BLE functionality without physical hardware using built-in simulation
- **Cross-platform**: Works on Android, iOS, Windows, macOS, Linux, and Web

## Architecture

The app follows a clean architecture pattern with:

- **Core Layer**: Shared utilities, constants, error handling, and BLE simulation interface
- **Features Layer**: Modular feature implementation (device discovery, connection dashboard, GATT explorer, mode selector)
- **Presentation Layer**: UI components, providers, and state management

## Getting Started

### Prerequisites

- Flutter SDK 3.0 or higher
- Dart 2.17 or higher
- Android Studio / Xcode for mobile development
- Physical BLE device or simulator for testing

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/ble_master_lab.git
   cd ble_master_lab
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── app/                 # App configuration and routing
├── core/                # Core utilities and shared components
├── features/            # Feature modules
│   ├── device_discovery/    # BLE device scanning
│   ├── connection_dashboard/ # Device connection management
│   ├── gatt_explorer/       # GATT browsing and operations
│   └── mode_selector/       # App mode selection
└── main.dart           # Entry point
```

## Key Components

### Device Discovery
- Scans for nearby BLE devices
- Displays device information (name, RSSI, MAC address)
- Real-time signal strength monitoring

### Connection Dashboard
- Manage active BLE connections
- Display connection status and statistics
- Handle connection lifecycle events

### GATT Explorer
- Browse GATT services and characteristics
- Read/write characteristic values
- Subscribe to notifications
- View descriptor information

### Simulation Mode
- Test BLE functionality without hardware
- Simulated devices and services
- Ideal for development and demonstration

## Dependencies

Key packages used in this project:

- `flutter_blue_plus`: BLE functionality for mobile platforms
- `permission_handler`: Handle device permissions
- `riverpod`: State management
- `go_router`: Navigation and routing

## Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Windows
- ✅ macOS
- ✅ Linux
- ✅ Web (limited BLE support)

## Development

### Running Tests

```bash
flutter test
```

### Code Generation

This project uses code generation for certain components. Run:

```bash
flutter pub run build_runner build
```

### Debugging

Enable detailed logging by setting the log level in `AppLogger`:

```dart
AppLogger().level = Level.verbose;
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter Blue Plus for BLE functionality
- The Flutter community for excellent packages and resources
