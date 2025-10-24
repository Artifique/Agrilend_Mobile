import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../auth/providers/auth_provider.dart';
import '../../../services/user_service.dart'; // Assuming UserService exists
import '../../../services/auth_providers.dart'; // Import auth_providers to access userServiceProvider
import '../../../models/user.dart'; // Assuming User model exists

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _companyNameController;
  late TextEditingController _businessTypeController;
  late TextEditingController _businessAddressController;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authProvider).user;
    _fullNameController = TextEditingController(text: user?.fullName ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
    _companyNameController = TextEditingController(text: user?.companyName ?? '');
    _businessTypeController = TextEditingController(text: user?.businessType ?? '');
    _businessAddressController = TextEditingController(text: user?.businessAddress ?? '');
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyNameController.dispose();
    _businessTypeController.dispose();
    _businessAddressController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final authNotifier = ref.read(authProvider.notifier);
      final currentUser = authNotifier.state.user;

      if (currentUser == null) {
        // Handle error: no current user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur: Utilisateur non connecté.')),
        );
        return;
      }

      final nameParts = _fullNameController.text.split(' ');
      final updatedUser = currentUser.copyWith(
        firstName: nameParts.isNotEmpty ? nameParts.first.trim() : '',
        lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ').trim() : '',
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        companyName: _companyNameController.text.trim(),
        businessType: _businessTypeController.text.trim(),
        businessAddress: _businessAddressController.text.trim(),
      );

      try {
        // Assuming userServiceProvider is defined and provides UserService
        final userService = ref.read(userServiceProvider);
        // Add logging here
        print('Attempting to update profile...');
        print('Updated User Object: $updatedUser');
        print('Changes being sent to API: ${updatedUser.toJson()}');

        await userService.updateCurrentUserProfile(updatedUser.toJson()); // Use the new method

        // Update auth state with new user data
        authNotifier.state = authNotifier.state.copyWith(user: updatedUser);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profil mis à jour avec succès!')),
          );
          context.pop(); // Go back to previous screen
        }
      } catch (e, stack) {
        if (context.mounted) {
          print('Error updating profile: $e'); // Log the error
          print('Stack trace: $stack'); // Log the stack trace
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur lors de la mise à jour du profil: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).user;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Modifier le Profil')),
        body: const Center(child: Text('Veuillez vous connecter pour modifier votre profil.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier le Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Nom Complet'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom complet';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Téléphone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre numéro de téléphone';
                  }
                  return null;
                },
              ),
              if (user.userType == 'buyer') ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _companyNameController,
                  decoration: const InputDecoration(labelText: 'Nom de l\'entreprise'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _businessTypeController,
                  decoration: const InputDecoration(labelText: 'Type d\'activité'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _businessAddressController,
                  decoration: const InputDecoration(labelText: 'Adresse de l\'entreprise'),
                ),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Enregistrer les modifications'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
