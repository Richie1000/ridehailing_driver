// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:ridehailing_driver/auth/auth_result.dart';
// import 'package:ridehailing_driver/auth/login_screen.dart';
// import 'package:ridehailing_driver/providers/user_provider.dart';
// import 'package:ridehailing_driver/theme/contants.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     UserProvider authProvider = Provider.of<UserProvider>(context);

//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(defaultPadding),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Logo
//                 Center(
//                   child: Image.asset(
//                     'assets/images/Illustration.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(height: defaultPadding / 4),

//                 // Full Name Input
//                 TextField(
//                   controller: authProvider.name,
//                   decoration: InputDecoration(
//                     hintText: 'Full Name',
//                     prefixIcon: Icon(Icons.person, color: primaryColor),
//                   ),
//                 ),
//                 const SizedBox(height: defaultPadding),

//                 // Email Input
//                 TextField(
//                   controller: authProvider.email,
//                   decoration: InputDecoration(
//                     hintText: 'Email',
//                     prefixIcon: Icon(Icons.email, color: primaryColor),
//                   ),
//                 ),
//                 const SizedBox(height: defaultPadding),

//                 // Phone Input
//                 TextField(
//                   controller: authProvider.phone,
//                   decoration: InputDecoration(
//                     hintText: 'Phone',
//                     prefixIcon: Icon(Icons.phone, color: primaryColor),
//                   ),
//                 ),
//                 const SizedBox(height: defaultPadding),

//                 // Password Input
//                 TextField(
//                   controller: authProvider.password,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     hintText: 'Password',
//                     prefixIcon: Icon(Icons.lock, color: primaryColor),
//                   ),
//                 ),
//                 const SizedBox(height: defaultPadding),

//                 // Confirm Password Input
//                 TextField(
//                   controller: authProvider.Confirmedpassword,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     hintText: 'Confirm Password',
//                     prefixIcon: Icon(Icons.lock, color: primaryColor),
//                   ),
//                 ),
//                 const SizedBox(height: defaultPadding),

//                 // Sign Up Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed:
//                         _isLoading
//                             ? null
//                             : () async {
//                               if (authProvider.password.text !=
//                                   authProvider.Confirmedpassword.text) {
//                                 showSnackBar(
//                                   context,
//                                   "Passwords do not match!",
//                                 );
//                                 return;
//                               }

//                               setState(() {
//                                 _isLoading = true;
//                               });

//                               // Calling the signUp method
//                               AuthResult result = await authProvider.signUp(
//                                 authProvider.email.text.trim(),
//                                 authProvider.password.text.trim(),
//                                 authProvider.name.text.trim(),
//                                 authProvider.phone.text.trim(),
//                                 authProvider.vehicleModel.text.trim(),
//                                 authProvider.vehicleColor.text.trim(),
//                                 authProvider.vehicleRegistrationNumber.text
//                                     .trim(),
//                               );

//                               if (!mounted) return;

//                               setState(() {
//                                 _isLoading = false;
//                               });

//                               if (result is AuthSuccess) {
//                                 if (context.mounted) {
//                                   showSnackBar(
//                                     context,
//                                     "Account created successfully!",
//                                   );
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) {
//                                         return const LoginScreen();
//                                       },
//                                     ),
//                                   );
//                                 }
//                               } else if (result is AuthFailure) {
//                                 if (context.mounted) {
//                                   showSnackBar(context, result.message);
//                                 }
//                               }
//                             },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: primaryColor,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child:
//                         _isLoading
//                             ? const CircularProgressIndicator(
//                               color: primaryColor,
//                             )
//                             : const Text(
//                               'Sign Up',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                               ),
//                             ),
//                   ),
//                 ),
//                 const SizedBox(height: defaultPadding),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Already have an account?"),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) {
//                               return const LoginScreen();
//                             },
//                           ),
//                         );
//                       },
//                       child: const Text('Login here'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:ridehailing_driver/auth/auth_result.dart';
// import 'package:ridehailing_driver/auth/login_screen.dart';
// import 'package:ridehailing_driver/providers/user_provider.dart';
// import 'package:ridehailing_driver/theme/contants.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   late final PageController _pageController;
//   int _currentStep = 0;
//   bool _isLoading = false;
//   bool _isTermsAccepted = false;

//   final List<String> _stepImages = [
//     'assets/images/Illustration.png',
//     'assets/images/sign-up2.jpg',
//     'assets/images/sign-up.jpg',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }

//   void _nextStep() {
//     if (_currentStep == 0 && !_isTermsAccepted) {
//       showSnackBar(context, "Please accept the terms to continue.");
//       return;
//     }

//     if (_currentStep < 2) {
//       setState(() => _currentStep++);
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   void _previousStep() {
//     if (_currentStep > 0) {
//       setState(() => _currentStep--);
//       _pageController.previousPage(
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   Future<void> _submit(UserProvider provider) async {
//     if (provider.password.text != provider.Confirmedpassword.text) {
//       showSnackBar(context, "Passwords do not match!");
//       return;
//     }

//     setState(() => _isLoading = true);

//     final result = await provider.signUp(
//       provider.email.text.trim(),
//       provider.password.text.trim(),
//       provider.name.text.trim(),
//       provider.phone.text.trim(),
//       provider.vehicleModel.text.trim(),
//       provider.vehicleColor.text.trim(),
//       provider.vehicleRegistrationNumber.text.trim(),
//     );

//     if (!mounted) return;

//     setState(() => _isLoading = false);

//     if (result is AuthSuccess) {
//       showSnackBar(context, "Account created successfully!");
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const LoginScreen()),
//       );
//     } else if (result is AuthFailure) {
//       showSnackBar(context, result.message);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<UserProvider>(context, listen: false);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign Up'),
//         leading:
//             _currentStep > 0
//                 ? IconButton(
//                   icon: const Icon(Icons.arrow_back),
//                   onPressed: _previousStep,
//                 )
//                 : null,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: PageView(
//                 controller: _pageController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: [
//                   _buildStep(
//                     image: _stepImages[0],
//                     content: _buildPersonalInfoStep(authProvider),
//                   ),
//                   _buildStep(
//                     image: _stepImages[1],
//                     content: _buildAccountInfoStep(authProvider),
//                   ),
//                   _buildStep(
//                     image: _stepImages[2],
//                     content: _buildVehicleInfoStep(authProvider),
//                   ),
//                 ],
//               ),
//             ),
//             _buildBottomControls(authProvider),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStep({required String image, required Widget content}) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(defaultPadding),
//       child: Column(
//         children: [
//           Center(child: Image.asset(image, fit: BoxFit.cover)),
//           const SizedBox(height: defaultPadding),
//           content,
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomControls(UserProvider authProvider) {
//     return Padding(
//       padding: const EdgeInsets.all(defaultPadding),
//       child: Row(
//         children: [
//           const Spacer(),
//           if (_currentStep < 2)
//             SizedBox(
//               width: 120, // or whatever width suits your design
//               child: ElevatedButton(
//                 onPressed: _nextStep,
//                 child: const Text('Continue'),
//               ),
//             )
//           else
//             SizedBox(
//               width: 120,
//               child: ElevatedButton(
//                 onPressed: _isLoading ? null : () => _submit(authProvider),
//                 child:
//                     _isLoading
//                         ? const SizedBox(
//                           height: 16,
//                           width: 16,
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2,
//                           ),
//                         )
//                         : const Text('Submit'),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildPersonalInfoStep(UserProvider p) => Column(
//   //   crossAxisAlignment: CrossAxisAlignment.start,
//   //   children: [
//   //     _customTextField(p.name, 'Full Name', Icons.person),
//   //     const SizedBox(height: defaultPadding),
//   //     _customTextField(p.phone, 'Phone', Icons.phone),
//   //   ],
//   // );

//   Widget _buildPersonalInfoStep(UserProvider p) => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       _customTextField(p.name, 'Full Name', Icons.person),
//       const SizedBox(height: defaultPadding),
//       _customTextField(p.phone, 'Phone', Icons.phone),
//       const SizedBox(height: defaultPadding),
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Checkbox(
//             value: _isTermsAccepted,
//             onChanged: (value) {
//               setState(() {
//                 _isTermsAccepted = value ?? false;
//               });
//             },
//           ),
//           Expanded(
//             child: RichText(
//               text: TextSpan(
//                 style: Theme.of(context).textTheme.bodyMedium,
//                 children: [
//                   const TextSpan(text: 'By registering, you agree to our '),
//                   TextSpan(
//                     text: 'Terms of Service',
//                     style: const TextStyle(color: primaryColor),
//                   ),
//                   const TextSpan(text: ' and '),
//                   TextSpan(
//                     text: 'Privacy policy',
//                     style: const TextStyle(color: primaryColor),
//                   ),
//                   const TextSpan(
//                     text:
//                         ', and commit to comply with applicable laws in Ghana. You also agree to provide only legal services and content on the taxi platform.',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(height: 8),
//       const Text(
//         'Once you’ve become a driver, we will occasionally send you offers and promotions related to our services. You can always unsubscribe by changing your communication preferences.',
//         style: TextStyle(fontSize: 12, color: Colors.grey),
//       ),
//     ],
//   );

//   Widget _buildAccountInfoStep(UserProvider p) => Column(
//     children: [
//       _customTextField(p.email, 'Email', Icons.email),
//       const SizedBox(height: defaultPadding),
//       _customTextField(p.password, 'Password', Icons.lock, obscure: true),
//       const SizedBox(height: defaultPadding),
//       _customTextField(
//         p.Confirmedpassword,
//         'Confirm Password',
//         Icons.lock,
//         obscure: true,
//       ),
//     ],
//   );

//   Widget _buildVehicleInfoStep(UserProvider p) => Column(
//     children: [
//       _customTextField(p.vehicleModel, 'Vehicle Model', Icons.directions_car),
//       const SizedBox(height: defaultPadding),
//       _customTextField(p.vehicleColor, 'Vehicle Color', Icons.palette),
//       const SizedBox(height: defaultPadding),
//       _customTextField(
//         p.vehicleRegistrationNumber,
//         'Vehicle Reg. Number',
//         Icons.confirmation_number,
//       ),
//     ],
//   );

//   Widget _customTextField(
//     TextEditingController controller,
//     String hint,
//     IconData icon, {
//     bool obscure = false,
//   }) {
//     return TextField(
//       controller: controller,
//       obscureText: obscure,
//       decoration: InputDecoration(
//         hintText: hint,
//         prefixIcon: Icon(icon, color: primaryColor),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ridehailing_driver/auth/auth_result.dart';
import 'package:ridehailing_driver/auth/login_screen.dart';
import 'package:ridehailing_driver/auth/signup/document_upload_step.dart';
import 'package:ridehailing_driver/auth/signup/step_account_info.dart';
import 'package:ridehailing_driver/auth/signup/step_personal_info.dart';
import 'package:ridehailing_driver/auth/signup/step_vehicleinfo.dart';
import 'package:ridehailing_driver/providers/user_provider.dart';
import 'package:ridehailing_driver/theme/contants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final PageController _pageController;
  int _currentStep = 0;
  bool _isLoading = false;
  bool _isTermsAccepted = false;

  // Track selected document files
  File? _ghanaCardFile;
  File? _insuranceFile;
  File? _roadworthinessFile;
  File? _vitFile;

  final List<String> _stepImages = [
    'assets/images/Illustration.png',
    'assets/images/sign-up2.jpg',
    'assets/images/sign-up.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _nextStep() {
    if (_currentStep == 0 && !_isTermsAccepted) {
      showSnackBar(context, 'Please accept the terms to continue.');
      return;
    }

    if (_currentStep < 3) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _submit(UserProvider provider) async {
    if (provider.password.text != provider.Confirmedpassword.text) {
      showSnackBar(context, "Passwords do not match!");
      return;
    }

    // Ensure all document files are selected
    if (_ghanaCardFile == null ||
        _insuranceFile == null ||
        _roadworthinessFile == null ||
        _vitFile == null) {
      showSnackBar(context, "Please upload all required documents.");
      return;
    }

    setState(() => _isLoading = true);
    try {
      // Upload documents and get URLs
      final userId = provider.email.text
          .trim()
          .replaceAll('@', '_')
          .replaceAll('.', '_');
      final ghanaCardUrl = await _uploadDocument(
        _ghanaCardFile!,
        userId,
        'ghana_card',
      );
      final insuranceUrl = await _uploadDocument(
        _insuranceFile!,
        userId,
        'insurance',
      );
      final roadworthinessUrl = await _uploadDocument(
        _roadworthinessFile!,
        userId,
        'roadworthiness',
      );
      final vitUrl = await _uploadDocument(_vitFile!, userId, 'vit');

      final result = await provider.signUp(
        provider.email.text.trim(),
        provider.password.text.trim(),
        provider.name.text.trim(),
        provider.phone.text.trim(),
        provider.vehicleModel.text.trim(),
        provider.vehicleColor.text.trim(),
        provider.vehicleRegistrationNumber.text.trim(),
        ghanaCardUrl,
        insuranceUrl,
        roadworthinessUrl,
        vitUrl,
      );

      if (!mounted) return;

      setState(() => _isLoading = false);

      if (result is AuthSuccess) {
        showSnackBar(context, "Account created successfully!");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else if (result is AuthFailure) {
        showSnackBar(context, result.message);
      }
    } catch (e) {
      showSnackBar(context, "Error: ${e.toString()}");
    }
  }

  Future<String> _uploadDocument(
    File file,
    String userId,
    String docType,
  ) async {
    final ref = FirebaseStorage.instance.ref().child(
      'documents/$userId/$docType.jpg',
    );
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> _pickDocument(Function(File) onPicked) async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) onPicked(File(result.path));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        leading:
            _currentStep > 0
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _previousStep,
                )
                : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildStep(
                    image: _stepImages[0],
                    content: StepPersonalInfo(
                      provider: authProvider,
                      isTermsAccepted: _isTermsAccepted,
                      onTermsChanged:
                          (val) =>
                              setState(() => _isTermsAccepted = val ?? false),
                    ),
                  ),
                  _buildStep(
                    image: _stepImages[1],
                    content: StepAccountInfo(provider: authProvider),
                  ),
                  _buildStep(
                    image: null,
                    content: DocumentUploadStep(
                      // <-- NEW DOCUMENT STEP ADDED
                      onUploadGhanaCard:
                          () => _pickDocument(
                            (f) => setState(() => _ghanaCardFile = f),
                          ),
                      onUploadInsurance:
                          () => _pickDocument(
                            (f) => setState(() => _insuranceFile = f),
                          ),
                      onUploadRoadworthiness:
                          () => _pickDocument(
                            (f) => setState(() => _roadworthinessFile = f),
                          ),
                      onUploadVIT:
                          () => _pickDocument(
                            (f) => setState(() => _vitFile = f),
                          ),
                    ),
                  ),
                  _buildStep(
                    image: _stepImages[2],
                    content: StepVehicleInfo(provider: authProvider),
                  ),
                ],
              ),
            ),
            _buildBottomControls(authProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildStep({required String? image, required Widget content}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (image != null)
            Center(child: Image.asset(image, fit: BoxFit.cover)),
          if (image != null) const SizedBox(height: 16.0),
          content,
        ],
      ),
    );
  }

  Widget _buildBottomControls(UserProvider authProvider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Spacer(),
          if (_currentStep < 3)
            SizedBox(
              width: 120,
              child: ElevatedButton(
                onPressed: _nextStep,
                child: const Text('Continue'),
              ),
            )
          else
            SizedBox(
              width: 120,
              child: ElevatedButton(
                onPressed: _isLoading ? null : () => _submit(authProvider),
                child:
                    _isLoading
                        ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            color: whiteColor,
                            strokeWidth: 2,
                          ),
                        )
                        : const Text('Submit'),
              ),
            ),
        ],
      ),
    );
  }
}
