import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swiftdine_mobile/services/profile_service.dart';
import '../models/user_profile.dart';
import '../themes/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  final String token;
  const ProfileScreen({super.key, required this.token});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? user;
  bool loading = true;
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final profile = await fetchUserProfile(widget.token);
    setState(() {
      user = profile;
      _nameController.text = profile?.name ?? '';
      _emailController.text = profile?.email ?? '';
      loading = false;
    });
  }

    void _toggleEdit() async {
    if (_isEditing) {
      if (_formKey.currentState?.validate() ?? false) {
        setState(() => loading = true);

        try {
          final response = await http.put(
            Uri.parse('http://10.0.2.2:8000/api/update-profile'),
            headers: {
              'Authorization': 'Bearer ${widget.token}',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'name': _nameController.text,
              'email': _emailController.text,
            }),
          );

          if (response.statusCode == 200) {
            // Successfully updated
            setState(() {
              _isEditing = false;
              loading = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Profile updated successfully 🎉"),
                backgroundColor: Colors.green,
              ),
            );
          } else {
            setState(() => loading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Failed to update profile. Please try again."),
                backgroundColor: Colors.red,
              ),
            );
          }
        } catch (e) {
          setState(() => loading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error: $e"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else {
      setState(() => _isEditing = true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: user?.profilePhoto != null
                            ? NetworkImage(
                                "http://10.0.2.2:8000/storage/${user!.profilePhoto}")
                            : const AssetImage('assets/images/default_profile.png')
                                as ImageProvider,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _isEditing
                                  ? TextFormField(
                                      controller: _nameController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Name',
                                      ),
                                      validator: (v) => (v == null || v.isEmpty)
                                          ? 'Name cannot be empty'
                                          : null,
                                    )
                                  : Text(_nameController.text,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              _isEditing
                                  ? TextFormField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Email',
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return 'Email cannot be empty';
                                        }
                                        final emailRegex =
                                            RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                        if (!emailRegex.hasMatch(v)) {
                                          return 'Enter valid email';
                                        }
                                        return null;
                                      },
                                    )
                                  : Text(_emailController.text,
                                      style: const TextStyle(
                                          color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(_isEditing ? Icons.check : Icons.edit,
                            color: AppTheme.primaryColor),
                        onPressed: _toggleEdit,
                      )
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView(
                    children: [
                      _buildListTile(Icons.fastfood, "My Orders",
                          onTap: () => Navigator.pushNamed(context, '/orders')),
                      _buildListTile(Icons.favorite, "Favorites",
                          onTap: () =>
                              Navigator.pushNamed(context, '/favorites')),
                      _buildListTile(Icons.credit_card, "Payment Methods",
                          onTap: () =>
                              Navigator.pushNamed(context, '/payments')),
                      _buildListTile(Icons.home, "My Addresses",
                          onTap: () =>
                              Navigator.pushNamed(context, '/addresses')),
                      _buildListTile(Icons.settings, "Settings",
                          onTap: () =>
                              Navigator.pushNamed(context, '/settings')),
                      _buildListTile(Icons.help_outline, "Help & Support",
                          onTap: () =>
                              Navigator.pushNamed(context, '/support')),
                      _buildListTile(Icons.logout, "Log out",
                          iconColor: Colors.red, onTap: _logout),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildListTile(IconData icon, String title,
          {Color? iconColor, VoidCallback? onTap}) =>
      ListTile(
        leading: Icon(icon, color: iconColor ?? AppTheme.primaryColor),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      );

  void _logout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Log out", style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}
