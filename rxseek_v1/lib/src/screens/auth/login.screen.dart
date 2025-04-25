import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/dialogs/waiting_dialog.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'registration.screen.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "/auth";
  static const String name = "Login Screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController username, password;
  late FocusNode usernameFn, passwordFn;

  bool obfuscate = true;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    username = TextEditingController(text: "rhunnan3216@gmail.com");
    password = TextEditingController(text: "#Newpass3216");
    usernameFn = FocusNode();
    passwordFn = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
    usernameFn.dispose();
    passwordFn.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/Login_screen.png"),
                  fit: BoxFit.cover)),
          //padding: const EdgeInsets.only(top: 300, left: 16, right: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Positioned(
                          bottom: 50,
                          child: Image.asset(
                            'assets/gifs/Sequence 01.gif',
                            width: 150,
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextFormField(
                            decoration: decoration.copyWith(
                                labelText: "Username",
                                labelStyle: const TextStyle(
                                  fontFamily:
                                      'Quicksand', // Apply Quicksand font to the label
                                  fontSize: 20, // Adjust font size if needed
                                  fontWeight:
                                      FontWeight.bold, // Use regular weight
                                ),
                                prefixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      30.0), // Adds rounded corners
                                  // borderSide: const BorderSide(
                                  //   width: 1.0, // Sets border width
                                  // ),
                                )),
                            focusNode: usernameFn,
                            controller: username,
                            style: const TextStyle(
                              fontFamily: 'Quicksand', // Set custom font family
                              fontSize: 19, // Adjust font size as desired
                              fontWeight:
                                  FontWeight.normal, // Use regular weight
                            ),
                            onEditingComplete: () {
                              passwordFn.requestFocus();
                            },
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Please fill out the username'),
                              EmailValidator(
                                  errorText: "Please select a valid email"),
                            ]).call,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: obfuscate,
                              decoration: decoration.copyWith(
                                  labelText: "Password",
                                  labelStyle: const TextStyle(
                                    fontFamily:
                                        'Quicksand', // Apply Quicksand font to the label
                                    fontSize: 20, // Adjust font size if needed
                                    fontWeight:
                                        FontWeight.bold, // Use regular weight
                                  ),
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
                              style: const TextStyle(
                                fontFamily:
                                    'Quicksand', // Set custom font family
                                fontSize: 19, // Adjust font size as desired
                                fontWeight:
                                    FontWeight.normal, // Use regular weight
                              ),
                              onEditingComplete: () {
                                passwordFn.unfocus();

                                ///call submit maybe?
                              },
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Password is required"),
                              ]).call,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    GlobalRouter.I.router
                                        .go(RegistrationScreen.route);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[300],
                                  ),
                                  child: Text(
                                    "Register",
                                    style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    onSubmit();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      WaitingDialog.show(context,
          future: AuthController.I
              .login(username.text.trim(), password.text.trim()));
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
