import 'package:flutter/material.dart';
import 'package:modern_flutter_ui_kit/modern_flutter_ui_kit.dart';
import 'package:provider/provider.dart';
import '../components/buttons/custom_button.dart';
import '../components/inputs/custom_text_field.dart';
import '../components/cards/custom_card.dart';
import '../components/lists/custom_list_tile.dart';
import '../components/avatars/custom_avatar.dart';
import '../theme/theme_provider.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modern UI Kit'),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              themeProvider.setThemeMode(
                themeProvider.isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Buttons', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  CustomButton(
                    text: 'Primary',
                    onPressed: () {},
                    variant: ButtonVariant.primary,
                  ),
                  CustomButton(
                    text: 'Secondary',
                    onPressed: () {},
                    variant: ButtonVariant.secondary,
                  ),
                  CustomButton(
                    text: 'Outlined',
                    onPressed: () {},
                    variant: ButtonVariant.outlined,
                  ),
                  CustomButton(
                    text: 'Text',
                    onPressed: () {},
                    variant: ButtonVariant.text,
                  ),
                  CustomButton(
                    text: 'Loading',
                    onPressed: () {},
                    isLoading: true,
                  ),
                  CustomButton(
                    text: 'With Icon',
                    onPressed: () {},
                    icon: Icons.add,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text('Cards', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 16),
              CustomCard(
                variant: CardVariant.elevated,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Elevated Card', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      'This is an elevated card with a shadow effect.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CustomCard(
                variant: CardVariant.outlined,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Outlined Card', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      'This is an outlined card with a border.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CustomCard(
                variant: CardVariant.filled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Filled Card', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      'This is a filled card with a background color.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text('List Tiles', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 16),
              CustomListTile(
                leading: const Icon(Icons.person),
                title: const Text('John Doe'),
                subtitle: const Text('Software Engineer'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              CustomListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                subtitle: const Text('john.doe@example.com'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              CustomListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Phone'),
                subtitle: const Text('+1 234 567 890'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              const SizedBox(height: 32),
              Text('Avatars', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  CustomAvatar(text: 'JD', size: AvatarSize.small),
                  CustomAvatar(text: 'JD', size: AvatarSize.medium),
                  CustomAvatar(text: 'JD', size: AvatarSize.large),
                  CustomAvatar(text: 'JD', size: AvatarSize.extraLarge),
                  CustomAvatar(icon: Icons.person, size: AvatarSize.medium),
                  CustomAvatar(
                    imageUrl: 'https://i.pravatar.cc/150?img=1',
                    size: AvatarSize.medium,
                  ),
                  CustomAvatar(
                    text: 'JD',
                    size: AvatarSize.medium,
                    status: AvatarStatus.online,
                  ),
                  CustomAvatar(
                    text: 'JD',
                    size: AvatarSize.medium,
                    status: AvatarStatus.offline,
                  ),
                  CustomAvatar(
                    text: 'JD',
                    size: AvatarSize.medium,
                    status: AvatarStatus.busy,
                  ),
                  CustomAvatar(
                    text: 'JD',
                    size: AvatarSize.medium,
                    status: AvatarStatus.away,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text('Text Fields', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                hint: 'Enter your email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                hint: 'Enter your password',
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Submit',
                onPressed:
                    _isLoading
                        ? null
                        : () {
                          _handleSubmit();
                        },
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
