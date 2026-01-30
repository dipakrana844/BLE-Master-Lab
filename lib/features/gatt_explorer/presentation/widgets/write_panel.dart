import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_input_field.dart';
import '../../../../core/widgets/app_sheet.dart';
import '../../../../core/utils/app_spacing.dart';
import '../providers/gatt_explorer_provider.dart';
import '../../domain/entities/gatt_service.dart';

/// Bottom sheet for writing characteristic values
class WritePanel extends ConsumerStatefulWidget {
  final GattCharacteristic characteristic;

  const WritePanel({
    super.key,
    required this.characteristic,
  });

  @override
  ConsumerState<WritePanel> createState() => _WritePanelState();
}

class _WritePanelState extends ConsumerState<WritePanel> {
  final _hexController = TextEditingController();
  final _utf8Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill with example value
    _hexController.text = '0x01A4 FF22 0000';
  }

  @override
  void dispose() {
    _hexController.dispose();
    _utf8Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // Header
            _PanelHeader(
              characteristic: widget.characteristic,
              onClose: () => ref.read(hideWritePanelProvider)(),
            ),
            AppSpacing.verticalGapMd,
            
            // Inputs
            Expanded(
              child: _InputSection(
                hexController: _hexController,
                utf8Controller: _utf8Controller,
              ),
            ),
            
            // Action button
            AppSpacing.verticalGapMd,
            SizedBox(
              width: double.infinity,
              child: AppButton(
                onPressed: _onWritePressed,
                child: const Text('Write Value'),
                icon: Icons.send,
              ),
            ),
            AppSpacing.verticalGapMd,
            
            // Safe area for iOS
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _onWritePressed() {
    // TODO: Implement write characteristic
    // ref.read(gattExplorerProvider.notifier).writeCharacteristic(_hexController.text);
    if (mounted) {
      Navigator.of(context).pop(); // Close sheet
    }
  }
}

/// Header of the write panel
class _PanelHeader extends StatelessWidget {
  final GattCharacteristic characteristic;
  final VoidCallback onClose;

  const _PanelHeader({
    required this.characteristic,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Title and UUID
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Write Value',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'UUID: ${_getShortUuid(characteristic.uuid)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
        
        // Close button
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: theme.brightness == Brightness.dark
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
      ],
    );
  }

  String _getShortUuid(String uuid) {
    if (uuid.length > 8) {
      return uuid.substring(0, 8);
    }
    return uuid;
  }
}

/// Input fields section
class _InputSection extends StatelessWidget {
  final TextEditingController hexController;
  final TextEditingController utf8Controller;

  const _InputSection({
    required this.hexController,
    required this.utf8Controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // HEX Input
        AppInputField(
          label: 'HEX',
          controller: hexController,
          keyboardType: TextInputType.text,
          hintText: 'Enter hexadecimal value',
          suffix: const Text(
            'HEX',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        AppSpacing.verticalGapMd,
        
        // UTF-8 Input
        AppInputField(
          label: 'UTF-8',
          controller: utf8Controller,
          keyboardType: TextInputType.text,
          hintText: 'Enter command...',
          suffix: const Text(
            'UTF-8',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}