import 'package:flutter/material.dart';
import 'package:modern_flutter_ui_kit/src/components/dialogs/custom_dialog.dart';

class DialogExampleScreen extends StatelessWidget {
  const DialogExampleScreen({super.key});

  void _showDialog(BuildContext context, DialogType type) {
    showDialog(
      context: context,
      builder:
          (context) => CustomDialog(
            title: _getTitle(type),
            content: _getContent(type),
            type: type,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  String _getTitle(DialogType type) {
    switch (type) {
      case DialogType.info:
        return 'Information';
      case DialogType.success:
        return 'Success!';
      case DialogType.warning:
        return 'Warning';
      case DialogType.error:
        return 'Error';
      case DialogType.custom:
        return 'Custom Dialog';
    }
  }

  String _getContent(DialogType type) {
    switch (type) {
      case DialogType.info:
        return 'This is an information dialog. It provides important details about the current context.';
      case DialogType.success:
        return 'Your action was completed successfully! Everything is working as expected.';
      case DialogType.warning:
        return 'Please be careful! This action cannot be undone. Are you sure you want to proceed?';
      case DialogType.error:
        return 'Something went wrong. Please try again later or contact support if the problem persists.';
      case DialogType.custom:
        return 'This is a custom dialog with your own styling and behavior.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Dialog Examples')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDialogButton(
            context,
            'Info Dialog',
            DialogType.info,
            colorScheme.primary,
          ),
          const SizedBox(height: 12),
          _buildDialogButton(
            context,
            'Success Dialog',
            DialogType.success,
            Colors.green,
          ),
          const SizedBox(height: 12),
          _buildDialogButton(
            context,
            'Warning Dialog',
            DialogType.warning,
            Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildDialogButton(
            context,
            'Error Dialog',
            DialogType.error,
            colorScheme.error,
          ),
          const SizedBox(height: 12),
          _buildDialogButton(
            context,
            'Custom Dialog',
            DialogType.custom,
            colorScheme.secondary,
          ),
          const SizedBox(height: 24),
          _buildCustomizedDialogButton(context),
        ],
      ),
    );
  }

  Widget _buildDialogButton(
    BuildContext context,
    String label,
    DialogType type,
    Color color,
  ) {
    return ElevatedButton(
      onPressed: () => _showDialog(context, type),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(label),
    );
  }

  Widget _buildCustomizedDialogButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder:
              (context) => CustomDialog(
                title: 'Custom Styled Dialog',
                content: 'This dialog has custom styling and animations.',
                type: DialogType.custom,
                icon: Icons.star,
                iconColor: Colors.amber,
                backgroundColor: Colors.grey[900],
                elevation: 16,
                borderRadius: BorderRadius.circular(24),
                contentPadding: const EdgeInsets.all(32),
                titleStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                contentStyle: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
                animationDuration: const Duration(milliseconds: 500),
                animationCurve: Curves.bounceOut,
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                ],
              ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const Text('Show Customized Dialog'),
    );
  }
}
