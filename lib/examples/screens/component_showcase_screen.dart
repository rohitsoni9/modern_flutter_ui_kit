import 'package:flutter/material.dart';
import 'package:modern_flutter_ui_kit/src/components/buttons/custom_button.dart';
import 'package:modern_flutter_ui_kit/src/components/inputs/custom_text_field.dart';
import 'package:modern_flutter_ui_kit/src/components/cards/custom_card.dart';
import 'package:modern_flutter_ui_kit/src/components/lists/custom_list_tile.dart';
import 'package:modern_flutter_ui_kit/src/components/avatars/custom_avatar.dart';
import 'package:modern_flutter_ui_kit/src/components/navigation/custom_bottom_nav_bar.dart';
import 'package:modern_flutter_ui_kit/src/components/navigation/custom_tab_bar.dart';

import '../../modern_flutter_ui_kit.dart';

class ComponentShowcaseScreen extends StatefulWidget {
  const ComponentShowcaseScreen({super.key});

  @override
  State<ComponentShowcaseScreen> createState() =>
      _ComponentShowcaseScreenState();
}

class _ComponentShowcaseScreenState extends State<ComponentShowcaseScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Component Showcase'),
        bottom: CustomTabBar(
          currentIndex: _tabController.index,
          tabs: const ['Buttons', 'Inputs', 'Cards'],
          onTap: (index) {
            setState(() {
              _tabController.animateTo(index);
            });
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildButtonsTab(), _buildInputsTab(), _buildCardsTab()],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        items: const [
          CustomBottomNavBarItem(icon: Icons.home, label: 'Home'),
          CustomBottomNavBarItem(icon: Icons.search, label: 'Search'),
          CustomBottomNavBarItem(icon: Icons.person, label: 'Profile'),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  Widget _buildButtonsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomButton(
            text: 'Primary Button',
            onPressed: () {},
            variant: ButtonVariant.primary,
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Secondary Button',
            onPressed: () {},
            variant: ButtonVariant.secondary,
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Outlined Button',
            onPressed: () {},
            variant: ButtonVariant.outlined,
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Text Button',
            onPressed: () {},
            variant: ButtonVariant.text,
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Button with Icon',
            onPressed: () {},
            icon: Icons.add,
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Loading Button',
            onPressed: () {},
            isLoading: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInputsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            label: 'Text Field',
            hint: 'Enter text here',
            controller: _textController,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Password Field',
            hint: 'Enter password',
            obscureText: true,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Email Field',
            hint: 'Enter email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Number Field',
            hint: 'Enter number',
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildCardsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Elevated Card',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('This is an elevated card with some content.'),
                const SizedBox(height: 16),
                CustomButton(text: 'Action Button', onPressed: () {}),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CustomCard(
            variant: CardVariant.outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Outlined Card',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('This is an outlined card with some content.'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CustomCard(
            variant: CardVariant.filled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filled Card',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('This is a filled card with some content.'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CustomListTile(
            leading: const CustomAvatar(text: 'JD', size: AvatarSize.medium),
            title: const Text('John Doe'),
            subtitle: const Text('Software Engineer'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
