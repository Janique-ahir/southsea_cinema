import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:southsea_cinema/models/user_settings.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

const String prefName = 'cinema_user_name';
const String prefEmail = 'cinema_user_email';
const String prefPhone = 'cinema_user_phone';
const String prefNewsletter = 'cinema_user_newsletter';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  bool _receiveNewsletter = false;
  String _confirmationMessage = '';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _loadSettings();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final prefs = SharedPreferencesAsync();
    final name = await prefs.getString(prefName) ?? '';
    final email = await prefs.getString(prefEmail) ?? '';
    final phone = await prefs.getString(prefPhone) ?? '';
    final newsletter = await prefs.getBool(prefNewsletter) ?? false;

    if (!mounted) return;
    setState(() {
      _nameController.text = name;
      _emailController.text = email;
      _phoneController.text = phone;
      _receiveNewsletter = newsletter;
    });
  }

  Future<void> _saveSettings() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final prefs = SharedPreferencesAsync();

    await prefs.setString(prefName, name);
    await prefs.setString(prefEmail, email);
    await prefs.setString(prefPhone, phone);
    await prefs.setBool(prefNewsletter, _receiveNewsletter);

    final settings = UserSettings(
      name: name,
      email: email,
      phone: phone,
      receiveNewsletter: _receiveNewsletter,
    );
    if (!mounted) return;
    setState(() {
      _confirmationMessage = 'Settings saved for ${settings.name}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Settings')),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer Profile',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email address'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone number'),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Receive cinema news'),
              value: _receiveNewsletter,
              onChanged: (value) {
                setState(() {
                  _receiveNewsletter = value;
                });
              },
            ),
            const SizedBox(height: 20),
            PrimaryButton(label: 'Save Settings', onPressed: _saveSettings),
            const SizedBox(height: 12),
            Text(_confirmationMessage),
          ],
        ),
      ),
    );
  }
}
