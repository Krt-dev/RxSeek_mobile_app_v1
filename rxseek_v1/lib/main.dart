import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxseek_v1/firebase_options.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/controllers/message_controller.dart';
import 'package:rxseek_v1/src/controllers/user_interface_controller.dart';
import 'package:rxseek_v1/src/routing/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  AuthController.initialize();
  GlobalRouter.initialize();
  MessageController.initialize();
  UserInterfaceController.initialize();
  await AuthController.I.loadSession();
  runApp(ChangeNotifierProvider(
      create: (context) => UserInterfaceController(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'RxSeek',
      debugShowCheckedModeBanner: false,
      routerConfig: GlobalRouter.I.router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
