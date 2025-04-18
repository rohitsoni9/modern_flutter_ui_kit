import 'package:flutter/material.dart';
import 'package:modern_flutter_ui_kit/modern_flutter_ui_kit.dart';

class ButtonShowcaseScreen extends StatelessWidget {
  const ButtonShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Primary Buttons',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Primary Button',
            onPressed: () {},
            variant: ButtonVariant.primary,
          ),
          const SizedBox(height: 8),
          CustomButton(
            text: 'Primary Button with Icon',
            onPressed: () {},
            variant: ButtonVariant.primary,
            icon: Icons.add,
          ),
          const SizedBox(height: 8),
          CustomButton(
            text: 'Loading Primary Button',
            onPressed: () {},
            variant: ButtonVariant.primary,
            isLoading: true,
          ),
          const SizedBox(height: 8),
          CustomButton(
            text: 'Full Width Primary Button',
            onPressed: () {},
            variant: ButtonVariant.primary,
            isFullWidth: true,
          ),
          const SizedBox(height: 24),
          const Text(
            'Secondary Buttons',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Secondary Button',
            onPressed: () {},
            variant: ButtonVariant.secondary,
          ),
          const SizedBox(height: 8),
          CustomButton(
            text: 'Secondary Button with Icon',
            onPressed: () {},
            variant: ButtonVariant.secondary,
            icon: Icons.edit,
          ),
          const SizedBox(height: 8),
          CustomButton(
            text: 'Loading Secondary Button',
            onPressed: () {},
            variant: ButtonVariant.secondary,
            isLoading: true,
          ),
          const SizedBox(height: 24),
          const Text(
            'Outlined Buttons',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Outlined Button',
            onPressed: () {},
            variant: ButtonVariant.outlined,
          ),
          const SizedBox(height: 8),
          CustomButton(
            text: 'Outlined Button with Icon',
            onPressed: () {},
            variant: ButtonVariant.outlined,
            icon: Icons.download,
          ),
          const SizedBox(height: 8),
          CustomButton(
            text: 'Loading Outlined Button',
            onPressed: () {},
            variant: ButtonVariant.outlined,
            isLoading: true,
          ),
          const SizedBox(height: 24),
          const Text(
            'Text Buttons',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Text Button',
            onPressed: () {},
            variant: ButtonVariant.text,
          ),
          const SizedBox(height: 8),
          CustomButton(
            text: 'Text Button with Icon',
            onPressed: () {},
            variant: ButtonVariant.text,
            icon: Icons.delete,
          ),
          const SizedBox(height: 8),
          CustomButton(
            text: 'Loading Text Button',
            onPressed: () {},
            variant: ButtonVariant.text,
            isLoading: true,
          ),
          const SizedBox(height: 24),
          const Text(
            'Custom Buttons',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Custom Color Button',
            onPressed: () {},
            customColor: Colors.purple,
          ),
          const SizedBox(height: 8),
          CustomButton(
            text: 'Custom Size Button',
            onPressed: () {},
            width: 200,
            height: 60,
          ),
          const SizedBox(height: 8),
          CustomButton(
            text: 'Custom Icon Button',
            onPressed: () {},
            icon: Icons.favorite,
            customColor: Colors.red,
          ),
        ],
      ),
    );
  }
} 