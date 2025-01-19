import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/dialogs/waiting_dialog.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'package:rxseek_v1/src/screens/auth/login.screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String route = "/changepass";
  static const String name = "Change Password Screen";
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController username,
      password,
      password2,
      email,
      name,
      lastName;
  late FocusNode usernameFn,
      passwordFn,
      password2Fn,
      emailfn,
      nameFn,
      lastNameFn;

  bool obfuscate = true;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    username = TextEditingController();
    usernameFn = FocusNode();
    password = TextEditingController();
    passwordFn = FocusNode();
    password2 = TextEditingController();
    password2Fn = FocusNode();
    email = TextEditingController();
    emailfn = FocusNode();
    name = TextEditingController();
    nameFn = FocusNode();
    lastName = TextEditingController();
    lastNameFn = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    usernameFn.dispose();
    password.dispose();
    passwordFn.dispose();
    password2.dispose();
    password2Fn.dispose();
    email.dispose();
    emailfn.dispose();
    name.dispose();
    nameFn.dispose();
    lastName.dispose();
    lastNameFn.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/images/tictacBG.png',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/signup screen.png"),
                      fit: BoxFit.cover)),
              padding: const EdgeInsets.only(top: 220, left: 16, right: 16),
              alignment: Alignment.center,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: TextFormField(
                        decoration: decoration.copyWith(
                            labelText: "First Name",
                            prefixIcon: const Icon(Icons.person)),
                        focusNode: nameFn,
                        controller: name,
                        onEditingComplete: () {
                          passwordFn.requestFocus();
                        },
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'Please fill out the Name'),
                          MaxLengthValidator(32,
                              errorText: "Name cannot exceed 32 characters"),
                        ]).call,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Flexible(
                      child: TextFormField(
                        decoration: decoration.copyWith(
                            labelText: "Last Name",
                            prefixIcon: const Icon(Icons.person)),
                        focusNode: lastNameFn,
                        controller: lastName,
                        onEditingComplete: () {
                          passwordFn.requestFocus();
                        },
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'Please fill out the Last name'),
                          MaxLengthValidator(32,
                              errorText:
                                  "Last name cannot exceed 32 characters"),
                        ]).call,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Flexible(
                      child: TextFormField(
                        decoration: decoration.copyWith(
                            labelText: "User name",
                            prefixIcon: const Icon(Icons.person)),
                        focusNode: usernameFn,
                        controller: username,
                        onEditingComplete: () {
                          passwordFn.requestFocus();
                        },
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'Please fill out the username'),
                          MaxLengthValidator(32,
                              errorText:
                                  "Username cannot exceed 32 characters"),
                        ]).call,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Flexible(
                      child: TextFormField(
                        decoration: decoration.copyWith(
                            labelText: "Email",
                            prefixIcon: const Icon(Icons.person)),
                        focusNode: emailfn,
                        controller: email,
                        onEditingComplete: () {
                          passwordFn.requestFocus();
                        },
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'Please fill out the email'),
                          MaxLengthValidator(32,
                              errorText: "Email cannot exceed 32 characters"),
                          EmailValidator(
                              errorText: "Please select a valid email"),
                        ]).call,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Flexible(
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obfuscate,
                        decoration: decoration.copyWith(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obfuscate = !obfuscate;
                                  });
                                },
                                icon: Icon(obfuscate
                                    ? Icons.remove_red_eye_rounded
                                    : CupertinoIcons.eye_slash))),
                        focusNode: passwordFn,
                        controller: password,
                        onEditingComplete: () {
                          password2Fn.requestFocus();

                          ///call submit maybe?
                        },
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Password is required"),
                          MinLengthValidator(12,
                              errorText:
                                  "Password must be at least 12 characters long"),
                          MaxLengthValidator(128,
                              errorText:
                                  "Password cannot exceed 72 characters"),
                          PatternValidator(
                              r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+?\-=[\]{};':,.<>]).*$",
                              errorText:
                                  'Password must contain at least one symbol, one uppercase letter, one lowercase letter, and one number.')
                        ]).call,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Flexible(
                      child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obfuscate,
                          decoration: decoration.copyWith(
                              labelText: "Confirm Password",
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obfuscate = !obfuscate;
                                    });
                                  },
                                  icon: Icon(obfuscate
                                      ? Icons.remove_red_eye_rounded
                                      : CupertinoIcons.eye_slash))),
                          focusNode: password2Fn,
                          controller: password2,
                          onEditingComplete: () {
                            password2Fn.unfocus();
                          },
                          validator: (v) {
                            String? doesMatchPasswords =
                                password.text == password2.text
                                    ? null
                                    : "Passwords doesn't match";
                            if (doesMatchPasswords != null) {
                              return doesMatchPasswords;
                            } else {
                              return MultiValidator([
                                RequiredValidator(
                                    errorText: "Password is required"),
                                MinLengthValidator(12,
                                    errorText:
                                        "Password must be at least 12 characters long"),
                                MaxLengthValidator(128,
                                    errorText:
                                        "Password cannot exceed 72 characters"),
                                PatternValidator(
                                    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+?\-=[\]{};':,.<>]).*$",
                                    errorText:
                                        'Password must contain at least one symbol, one uppercase letter, one lowercase letter, and one number.'),
                              ]).call(v);
                            }
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 45),
                      height: 62,
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          print("registerDebug");
                          onSubmit();
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              const Color.fromARGB(255, 33, 243, 121)),
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 190),
                      height: 62,
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          GlobalRouter.I.router.go(LoginScreen.route);
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              const Color.fromARGB(255, 231, 238, 239)),
                        ),
                        child: const Text(
                          "Back To Login Page",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      print("registering");
      WaitingDialog.show(context,
          future: AuthController.I.register(
              email.text.trim(),
              password.text.trim(),
              name.text.trim(),
              lastName.text.trim(),
              username.text.trim()));
    }
  }

  final OutlineInputBorder _baseBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );

  InputDecoration get decoration => InputDecoration(
      // prefixIconColor: AppColors.primary.shade700,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      filled: true,
      fillColor: Colors.white,
      errorMaxLines: 3,
      disabledBorder: _baseBorder,
      enabledBorder: _baseBorder.copyWith(
        borderSide: const BorderSide(color: Colors.black87, width: 1),
      ),
      focusedBorder: _baseBorder.copyWith(
        borderSide: const BorderSide(color: Colors.blueAccent, width: 1),
      ),
      errorBorder: _baseBorder.copyWith(
        borderSide: const BorderSide(color: Colors.deepOrangeAccent, width: 1),
      ));
}
