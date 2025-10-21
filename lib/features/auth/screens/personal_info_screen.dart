import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PersonalInfoScreen extends ConsumerStatefulWidget {
  final String userType;
  
  const PersonalInfoScreen({
    super.key,
    required this.userType,
  });

  @override
  ConsumerState<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends ConsumerState<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _professionController = TextEditingController();
  final _mainCropController = TextEditingController();
  
  String _selectedGender = 'M';
  String _selectedCountry = 'Cameroun';
  String _selectedMainCrop = '';
  DateTime? _selectedDateOfBirth;
  int _currentStep = 3;
  int _totalSteps = 6;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _professionController.dispose();
    _mainCropController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.go('/basic-info'),
        ),
        title: const Text('Informations personnelles'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth > 600 ? 32 : 24,
                vertical: 16,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildProgressIndicator(),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    _buildHeader(),
                    SizedBox(height: constraints.maxHeight * 0.04),
                    _buildNameFields(),
                    const SizedBox(height: 16),
                    _buildPhoneField(),
                    const SizedBox(height: 16),
                    _buildGenderField(),
                    const SizedBox(height: 16),
                    _buildDateOfBirthField(),
                    const SizedBox(height: 16),
                    _buildAddressField(),
                    const SizedBox(height: 16),
                    _buildCityCountryFields(),
                    const SizedBox(height: 16),
                    ..._buildUserSpecificFields(),
                    SizedBox(height: constraints.maxHeight * 0.04),
                    _buildNextButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      children: List.generate(_totalSteps, (index) {
        final stepNumber = index + 1;
        final isCompleted = stepNumber < _currentStep;
        final isCurrent = stepNumber == _currentStep;
        
        return Expanded(
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted 
                    ? Colors.green 
                    : isCurrent 
                      ? Colors.green 
                      : Colors.grey.shade300,
                ),
                child: Center(
                  child: isCompleted
                    ? const Icon(Icons.check, color: Colors.white, size: 16)
                    : Text(
                        '$stepNumber',
                        style: TextStyle(
                          color: isCurrent ? Colors.white : Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ),
              ),
              if (index < _totalSteps - 1)
                Expanded(
                  child: Container(
                    height: 2,
                    color: isCompleted ? Colors.green : Colors.grey.shade300,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.person_outline_rounded,
            size: 40,
            color: Colors.blue,
          ),
        ).animate().scale(
          delay: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 600),
        ),
        const SizedBox(height: 16),
        Text(
          'Informations personnelles',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ).animate().slideY(
          delay: const Duration(milliseconds: 400),
          duration: const Duration(milliseconds: 600),
          begin: -1,
          end: 0,
        ),
        const SizedBox(height: 8),
        Text(
          'Complétez vos informations personnelles',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ).animate().slideY(
          delay: const Duration(milliseconds: 600),
          duration: const Duration(milliseconds: 600),
          begin: -1,
          end: 0,
        ),
      ],
    );
  }

  Widget _buildNameFields() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _firstNameController,
            decoration: const InputDecoration(
              labelText: 'Prénom',
              prefixIcon: Icon(Icons.person_rounded),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Requis';
              }
              return null;
            },
          ).animate().slideX(
            delay: const Duration(milliseconds: 800),
            duration: const Duration(milliseconds: 600),
            begin: -1,
            end: 0,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: _lastNameController,
            decoration: const InputDecoration(
              labelText: 'Nom',
              prefixIcon: Icon(Icons.person_outline_rounded),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Requis';
              }
              return null;
            },
          ).animate().slideX(
            delay: const Duration(milliseconds: 1000),
            duration: const Duration(milliseconds: 600),
            begin: 1,
            end: 0,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: 'Téléphone',
        prefixIcon: Icon(Icons.phone_rounded),
        hintText: '+237 6XX XXX XXX',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez saisir votre téléphone';
        }
        return null;
      },
    ).animate().slideX(
      delay: const Duration(milliseconds: 1200),
      duration: const Duration(milliseconds: 600),
      begin: -1,
      end: 0,
    );
  }

  Widget _buildGenderField() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: const InputDecoration(
        labelText: 'Genre',
        prefixIcon: Icon(Icons.person_rounded),
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: 'M', child: Text('Masculin')),
        DropdownMenuItem(value: 'F', child: Text('Féminin')),
      ],
      onChanged: (value) {
        setState(() {
          _selectedGender = value!;
        });
      },
    ).animate().slideX(
      delay: const Duration(milliseconds: 1400),
      duration: const Duration(milliseconds: 600),
      begin: 1,
      end: 0,
    );
  }

  Widget _buildDateOfBirthField() {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController(
        text: _selectedDateOfBirth != null 
          ? '${_selectedDateOfBirth!.day}/${_selectedDateOfBirth!.month}/${_selectedDateOfBirth!.year}'
          : '',
      ),
      decoration: const InputDecoration(
        labelText: 'Date de naissance',
        prefixIcon: Icon(Icons.calendar_today_rounded),
        border: OutlineInputBorder(),
      ),
      onTap: _selectDateOfBirth,
      validator: (value) {
        if (_selectedDateOfBirth == null) {
          return 'Veuillez sélectionner votre date de naissance';
        }
        return null;
      },
    ).animate().slideX(
      delay: const Duration(milliseconds: 1600),
      duration: const Duration(milliseconds: 600),
      begin: -1,
      end: 0,
    );
  }

  Widget _buildAddressField() {
    return TextFormField(
      controller: _addressController,
      decoration: const InputDecoration(
        labelText: 'Adresse',
        prefixIcon: Icon(Icons.location_on_rounded),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez saisir votre adresse';
        }
        return null;
      },
    ).animate().slideX(
      delay: const Duration(milliseconds: 1800),
      duration: const Duration(milliseconds: 600),
      begin: 1,
      end: 0,
    );
  }

  Widget _buildCityCountryFields() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _cityController,
            decoration: const InputDecoration(
              labelText: 'Ville',
              prefixIcon: Icon(Icons.location_city_rounded),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Requis';
              }
              return null;
            },
          ).animate().slideX(
            delay: const Duration(milliseconds: 2000),
            duration: const Duration(milliseconds: 600),
            begin: -1,
            end: 0,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _selectedCountry,
            decoration: const InputDecoration(
              labelText: 'Pays',
              prefixIcon: Icon(Icons.public_rounded),
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'Cameroun', child: Text('Cameroun')),
              DropdownMenuItem(value: 'Nigeria', child: Text('Nigeria')),
              DropdownMenuItem(value: 'Ghana', child: Text('Ghana')),
              DropdownMenuItem(value: 'Côte d\'Ivoire', child: Text('Côte d\'Ivoire')),
              DropdownMenuItem(value: 'Sénégal', child: Text('Sénégal')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedCountry = value!;
              });
            },
          ).animate().slideX(
            delay: const Duration(milliseconds: 2200),
            duration: const Duration(milliseconds: 600),
            begin: 1,
            end: 0,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildUserSpecificFields() {
    List<Widget> fields = [];
    
    if (widget.userType == 'farmer') {
      // Champ Profession pour les agriculteurs
      fields.add(
        TextFormField(
          controller: _professionController,
          decoration: const InputDecoration(
            labelText: 'Profession',
            prefixIcon: Icon(Icons.work_outline_rounded),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez saisir votre profession';
            }
            return null;
          },
        ).animate().slideX(
          delay: const Duration(milliseconds: 2400),
          duration: const Duration(milliseconds: 600),
          begin: -1,
          end: 0,
        ),
      );
      
      fields.add(const SizedBox(height: 16));
      
      // Champ Culture principale pour les agriculteurs
      fields.add(
        DropdownButtonFormField<String>(
          value: _selectedMainCrop.isEmpty ? null : _selectedMainCrop,
          decoration: const InputDecoration(
            labelText: 'Culture principale',
            prefixIcon: Icon(Icons.agriculture_rounded),
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 'Maïs', child: Text('Maïs')),
            DropdownMenuItem(value: 'Riz', child: Text('Riz')),
            DropdownMenuItem(value: 'Cacao', child: Text('Cacao')),
            DropdownMenuItem(value: 'Café', child: Text('Café')),
            DropdownMenuItem(value: 'Banane', child: Text('Banane')),
            DropdownMenuItem(value: 'Tomate', child: Text('Tomate')),
            DropdownMenuItem(value: 'Oignon', child: Text('Oignon')),
            DropdownMenuItem(value: 'Autre', child: Text('Autre')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedMainCrop = value ?? '';
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez sélectionner votre culture principale';
            }
            return null;
          },
        ).animate().slideX(
          delay: const Duration(milliseconds: 2600),
          duration: const Duration(milliseconds: 600),
          begin: 1,
          end: 0,
        ),
      );
    } else if (widget.userType == 'agent') {
      // Champ spécialisé pour les agents
      fields.add(
        TextFormField(
          controller: _professionController,
          decoration: const InputDecoration(
            labelText: 'Zone d\'intervention',
            prefixIcon: Icon(Icons.location_on_rounded),
            hintText: 'Ex: Douala, Yaoundé, etc.',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez saisir votre zone d\'intervention';
            }
            return null;
          },
        ).animate().slideX(
          delay: const Duration(milliseconds: 2400),
          duration: const Duration(milliseconds: 600),
          begin: -1,
          end: 0,
        ),
      );
    } else if (widget.userType == 'buyer') {
      // Champ spécialisé pour les acheteurs
      fields.add(
        TextFormField(
          controller: _professionController,
          decoration: const InputDecoration(
            labelText: 'Entreprise/Organisation',
            prefixIcon: Icon(Icons.business_rounded),
            hintText: 'Nom de votre entreprise',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez saisir le nom de votre entreprise';
            }
            return null;
          },
        ).animate().slideX(
          delay: const Duration(milliseconds: 2400),
          duration: const Duration(milliseconds: 600),
          begin: -1,
          end: 0,
        ),
      );
    }
    
    return fields;
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: _handleNext,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text('Continuer'),
    ).animate().scale(
      delay: const Duration(milliseconds: 2400),
      duration: const Duration(milliseconds: 600),
    );
  }

  Future<void> _selectDateOfBirth() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 16)),
    );
    
    if (picked != null && picked != _selectedDateOfBirth) {
      setState(() {
        _selectedDateOfBirth = picked;
      });
    }
  }

  void _handleNext() {
    if (!_formKey.currentState!.validate()) return;
    
    // Naviguer vers l'écran KYC avec toutes les données
    context.go('/kyc-verification?userType=${widget.userType}', extra: {
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'address': _addressController.text.trim(),
      'city': _cityController.text.trim(),
      'country': _selectedCountry,
      'gender': _selectedGender,
      'dateOfBirth': _selectedDateOfBirth,
      'profession': _professionController.text.trim(),
      'mainCrop': _selectedMainCrop,
      'userType': widget.userType,
    });
  }
}
