import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../lib/features/gatt_explorer/presentation/screens/gatt_explorer_screen.dart';

void main() {
  group('GATT Explorer Screen Tests', () {
    testWidgets('renders correctly with mock data', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: GattExplorerScreen(),
          ),
        ),
      );

      // Verify screen renders
      expect(find.text('Polar H10'), findsOneWidget);
      expect(find.text('GATT Services'), findsOneWidget);
      
      // Verify services are displayed
      expect(find.text('Heart Rate Service'), findsOneWidget);
      expect(find.text('Device Information'), findsOneWidget);
      expect(find.text('Custom Command Service'), findsOneWidget);
      
      // Verify characteristic properties
      expect(find.text('R'), findsWidgets); // Read property
      expect(find.text('W'), findsWidgets); // Write property
      expect(find.text('N'), findsWidgets); // Notify property
      expect(find.text('I'), findsWidgets); // Indicate property
    });

    testWidgets('toggles service expansion', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: GattExplorerScreen(),
          ),
        ),
      );

      // Find and tap the Device Information service (initially collapsed)
      final deviceInfoTile = find.text('Device Information');
      expect(deviceInfoTile, findsOneWidget);
      
      // Tap to expand
      await tester.tap(deviceInfoTile);
      await tester.pumpAndSettle();
      
      // TODO: Add more specific assertions once BLE integration is implemented
    });

    testWidgets('shows write panel for writable characteristics', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: GattExplorerScreen(),
          ),
        ),
      );

      // Find the writable characteristic
      final commandInput = find.text('Command Input');
      expect(commandInput, findsOneWidget);
      
      // Tap to open write panel
      await tester.tap(commandInput);
      await tester.pumpAndSettle();
      
      // Verify write panel is shown
      expect(find.text('Write Value'), findsOneWidget);
      expect(find.text('HEX'), findsOneWidget);
      expect(find.text('UTF-8'), findsOneWidget);
    });
  });
}