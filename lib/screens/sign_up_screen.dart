import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/model/ContactModel.dart';
import 'package:mobile/screens/screen_skeleton.dart';
import 'package:mobile/screens/sign_in_screen.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../model/UserModel.dart';
import '../util/app_constants.dart';
import '../widgets/loading_animation.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/sign-up';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenSkeleton(SignUpForm());
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpFormState();
  }
}

class _SignUpFormState extends State<SignUpForm>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);
  late final FormGroup _form;
  bool _isEmailChecking = false;
  bool _isObscure = true;

  _SignUpFormState() {
    _form = FormGroup({
      'email': FormControl<String>(
          value: 'test1@gmail.com',
          validators: [Validators.required, Validators.email],
          asyncValidators: [_uniqueEmail]),
      'password': FormControl<String>(value: 'As258199!', validators: [
        Validators.required,
        Validators.pattern(RegExp(AppConstants.passwordPattern)),
      ]),
      'userType': FormControl<String>(validators: [Validators.required]),
      'name': FormControl<String>(
          value: 'Organization Name', validators: [Validators.required]),
      'city': FormControl<String>(validators: [Validators.required]),
      'phoneNumber': FormControl<String>(
          value: '111111111', validators: [Validators.required]),
      'isAgreed': FormControl<bool>()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        // child:
        child: ReactiveForm(
            formGroup: _form,
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    ReactiveTextField(
                      formControlName: 'email',
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          suffixIcon:
                              _isEmailChecking ? LoadingAnimation() : null,
                          label: const Text('Email'),
                          border: const OutlineInputBorder()),
                      validationMessages: {
                        'required': (error) => 'Email is required',
                        'email': (error) => 'Invalid email',
                        'unique': (error) => 'Email is already in use',
                        'server': (error) =>
                            'Server is not available, please try later'
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    ReactiveTextField(
                      formControlName: 'password',
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {
                                _setIsObscureState(!_isObscure);
                              },
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          label: const Text('Password'),
                          border: const OutlineInputBorder()),
                      validationMessages: {
                        'required': (error) => 'Password is required',
                        'pattern': (error) => 'Invalid password'
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _form.control('email').markAsTouched();
                          _form.control('password').markAsTouched();

                          if (_form.control('email').valid &&
                              _form.control('password').valid) {
                            _tabController.index = _tabController.index + 1;
                          }
                        },
                        child: const Text('Next'))
                  ]),
                  SingleChildScrollView(
                      child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    ReactiveDropdownField(
                      formControlName: 'userType',
                      decoration: const InputDecoration(
                          label: Text('User Type'),
                          border: OutlineInputBorder()),
                      validationMessages: {
                        'required': (error) => 'User type is required'
                      },
                      items: const [
                        DropdownMenuItem(
                            value: 'ORGANIZATION', child: Text('Organization')),
                        DropdownMenuItem(
                            value: 'DOCTOR', child: Text('Doctor')),
                        DropdownMenuItem(
                            value: 'PATIENT', child: Text('Patient'))
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    ReactiveTextField(
                      formControlName: 'name',
                      decoration: const InputDecoration(
                          label: Text('Name'), border: OutlineInputBorder()),
                      validationMessages: {
                        'required': (error) => 'Name is required'
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 20)),
                    ReactiveDropdownField(
                      formControlName: 'city',
                      decoration: const InputDecoration(
                          label: Text('City'), border: OutlineInputBorder()),
                      validationMessages: {
                        'required': (error) => 'City is required'
                      },
                      items: const [
                        DropdownMenuItem(
                            value: 'ASTANA', child: Text('Astana')),
                        DropdownMenuItem(
                            value: 'ALMATY', child: Text('Almaty')),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    ReactiveTextField(
                      keyboardType: TextInputType.number,
                      formControlName: 'phoneNumber',
                      decoration: const InputDecoration(
                          label: Text('Phone Number'),
                          border: OutlineInputBorder()),
                      validationMessages: {
                        'required': (error) => 'Phone number is required'
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () => _tabController.index =
                                  _tabController.index - 1,
                              child: const Text('Back')),
                          ElevatedButton(
                              onPressed: () {
                                _form.control('userType').markAsTouched();
                                _form.control('name').markAsTouched();
                                _form.control('city').markAsTouched();
                                _form.control('phoneNumber').markAsTouched();

                                if (_form.control('userType').valid &&
                                    _form.control('name').valid &&
                                    _form.control('city').valid &&
                                    _form.control('phoneNumber').valid) {
                                  _tabController.index =
                                      _tabController.index + 1;
                                }
                              },
                              child: const Text('Next'))
                        ])
                  ])),
                  Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ReactiveCheckbox(formControlName: 'isAgreed'),
                      const Text(
                        'I read and agree',
                        style: TextStyle(fontSize: 18),
                      )
                    ]),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () => _tabController.index =
                                  _tabController.index - 1,
                              child: const Text('Back')),
                          ElevatedButton(
                              onPressed: () {
                                if (_form.control('isAgreed').value != null &&
                                    _form.control('isAgreed').value) {
                                  _createUser();
                                }
                              },
                              child: const Text('Submit'))
                        ])
                  ])
                ])));
  }

  _createUser() async {
    await http
        .post(
            Uri.parse(
                '${AppConstants.userServiceBaseUrl}/api/v1/users/sign-up'),
            headers: AppConstants.requestHeaders,
            body: jsonEncode(<String, Object>{
              'email': _form.control('email').value,
              'password': _form.control('password').value,
              'userType': _form.control('userType').value,
              'name': _form.control('name').value,
              'contact': {
                'city': _form.control('city').value,
                'phoneNumber1': _form.control('phoneNumber').value
              }
            }))
        .then((value) {
      if (value.statusCode == 201) {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('User Registration'),
                  content: const Text('You have successfully registered'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, 'Close'),
                        child: const Text('Close'))
                  ],
                )).then((value) =>
            Navigator.popAndPushNamed(context, SignInScreen.routeName));
      } else if (value.statusCode == 400) {
        var responseMap = jsonDecode(value.body);
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Incorrect User Information'),
                  content: Text(responseMap['message'].toString()),
                  // const Text('Please go back and check user information'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, 'Close'),
                        child: const Text('Close'))
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Server Error'),
                  content: const Text('Server error happened'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, 'Close'),
                        child: const Text('Close'))
                  ],
                ));
      }
    }).onError((error, stackTrace) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Server Error'),
                content: const Text('Server error happened'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, 'Close'),
                      child: const Text('Close'))
                ],
              ));
    });
  }

  Future<Map<String, dynamic>?> _uniqueEmail(
      AbstractControl<dynamic> control) async {
    _setIsEmailChecking(true);
    var res = await http
        .get(
            Uri.parse(
                '${AppConstants.userServiceBaseUrl}/api/v1/users/email?email=${control.value}'),
            headers: AppConstants.requestHeaders)
        .then((value) {
          bool isEmailAvailable = value.body.toLowerCase() == 'true';

          if (!isEmailAvailable) {
            control.markAsTouched();
            return {'unique': false};
            // return true;
          }

          return null;
        })
        .catchError((error) => {'server': false})
        .onError((error, stackTrace) => {'server': false});
    _setIsEmailChecking(false);

    return res;
  }

  void _setIsEmailChecking(bool value) {
    setState(() {
      _isEmailChecking = value;
    });
  }

  void _setIsObscureState(bool value) {
    setState(() {
      _isObscure = value;
    });
  }
}
