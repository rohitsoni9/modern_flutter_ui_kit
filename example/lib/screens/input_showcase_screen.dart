import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modern_flutter_ui_kit/modern_flutter_ui_kit.dart';

class InputShowcaseScreen extends StatefulWidget {
  const InputShowcaseScreen({super.key});

  @override
  State<InputShowcaseScreen> createState() => _InputShowcaseScreenState();
}

class _InputShowcaseScreenState extends State<InputShowcaseScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _multilineController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _phoneController.dispose();
    _multilineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Basic Text Fields',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Text Field',
            hint: 'Enter text here',
            controller: _textController,
            prefixIcon: const Icon(Icons.text_fields),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            label: 'Password Field',
            hint: 'Enter password',
            controller: _passwordController,
            obscureText: true,
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: const Icon(Icons.visibility),
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            label: 'Email Field',
            hint: 'Enter email address',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Email is required';
              if (!value!.contains('@')) return 'Please enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Number Inputs',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Number Field',
            hint: 'Enter number',
            controller: _numberController,
            keyboardType: TextInputType.number,
            prefixIcon: const Icon(Icons.numbers),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 8),
          CustomTextField(
            label: 'Phone Number',
            hint: 'Enter phone number',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            prefixIcon: const Icon(Icons.phone),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 24),
          const Text(
            'Advanced Inputs',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Multiline Text',
            hint: 'Enter multiple lines of text',
            controller: _multilineController,
            maxLines: 3,
            minLines: 2,
            prefixIcon: const Icon(Icons.text_snippet),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            label: 'Disabled Field',
            hint: 'This field is disabled',
            enabled: false,
            prefixIcon: const Icon(Icons.lock_outline),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            label: 'Read-only Field',
            hint: 'This field is read-only',
            readOnly: true,
            controller: TextEditingController(text: 'Read-only value'),
            prefixIcon: const Icon(Icons.read_more),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            label: 'Custom Styled Field',
            hint: 'Enter text here',
            fillColor: Colors.grey[100],
            filled: true,
            prefixIcon: const Icon(Icons.style),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ],
      ),
    );
  }
}
