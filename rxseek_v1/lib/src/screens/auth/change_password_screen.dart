import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/dialogs/waiting_dialog.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'package:rxseek_v1/src/screens/auth/login.screen.dart';
import 'package:rxseek_v1/src/screens/profile/profile_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String route = "/changepass";
  static const String name = "Change Password Screen";
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController currentPassword, newPassword, newPassword2;

  late FocusNode currentPasswordfn, newPasswordfn, newPassword2fn;

  bool obfuscate = true;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();

    currentPassword = TextEditingController();
    currentPasswordfn = FocusNode();
    newPassword = TextEditingController();
    newPasswordfn = FocusNode();
    newPassword2 = TextEditingController();
    newPassword2fn = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    currentPassword.dispose();
    currentPasswordfn.dispose();
    newPassword.dispose();
    newPasswordfn.dispose();
    newPassword2.dispose();
    newPassword2fn.dispose();
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
                      image: AssetImage(
                          "assets/images/change_password_background.png"),
                      fit: BoxFit.cover)),
              padding: const EdgeInsets.only(top: 220, left: 16, right: 16),
              alignment: Alignment.center,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //diir ang current password
                    Flexible(
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obfuscate,
                        decoration: decoration.copyWith(
                            labelText: "Current Password",
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
                        focusNode: currentPasswordfn,
                        controller: currentPassword,
                        onEditingComplete: () {
                          currentPasswordfn.requestFocus();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //new password start diri
                    Flexible(
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obfuscate,
                        decoration: decoration.copyWith(
                            labelText: "New Password",
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
                        focusNode: newPasswordfn,
                        controller: newPassword,
                        onEditingComplete: () {
                          newPasswordfn.requestFocus();

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
                      height: 15,
                    ),
                    Flexible(
                      child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obfuscate,
                          decoration: decoration.copyWith(
                              labelText: "Confirm New Password",
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
                          focusNode: newPassword2fn,
                          controller: newPassword2,
                          onEditingComplete: () {
                            newPassword2fn.unfocus();
                          },
                          validator: (v) {
                            String? doesMatchPasswords =
                                newPassword.text == newPassword2.text
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
                    const Text(
                      "Note: After Changing your password you'll be log out",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 45),
                      height: 62,
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          print("changepassword");
                          onSubmit();
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              const Color.fromARGB(255, 33, 243, 121)),
                        ),
                        child: const Text(
                          "Change Password",
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
                          GlobalRouter.I.router.go(ProfileScreen.route);
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              const Color.fromARGB(255, 231, 238, 239)),
                        ),
                        child: const Text(
                          "Back To Profile Page",
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

  onSubmit() async {
    if (formKey.currentState?.validate() ?? false) {
      print("registering");
      WaitingDialog.show(context,
          future: AuthController.I.changePassword(
              currentPassword.text.trim(), newPassword.text.trim()));
    }
    AuthController.I.logout();
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
