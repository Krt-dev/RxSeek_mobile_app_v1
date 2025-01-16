import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/controllers/message_controller.dart';
import 'package:rxseek_v1/src/controllers/user_interface_controller.dart';
import 'package:rxseek_v1/src/models/thread_model.dart';
import 'package:rxseek_v1/src/widgets/chat_button_history.dart';
import 'package:rxseek_v1/src/widgets/thread_tile.dart';

class FaqScreen extends StatefulWidget {
  static const String route = "/faqScreen";
  static const String name = "FaqScreen";
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I reset my password?',
      'answer':
          'To reset your password, go to the login screen and tap on "Forgot Password". Follow the instructions to reset your password.'
    },
    {
      'question': 'Where can I find my order history?',
      'answer':
          'You can find your order history under the "Orders" section in your profile.'
    },
    {
      'question': 'How do I update my account information?',
      'answer':
          'To update your account information, go to the "Settings" page and select "Account Info".'
    },
    {
      'question': 'What is the return policy?',
      'answer':
          'Our return policy allows you to return items within 30 days of purchase. Please visit the "Returns" section for more details.'
    },
    {
      'question': 'How do I contact customer support?',
      'answer':
          'You can contact customer support through the "Help" section in the app or by calling our support line.'
    },
    {
      'question': 'How do I contact customer support?',
      'answer':
          'You can contact customer support through the "Help" section in the app or by calling our support line.'
    },
    {
      'question': 'How do I contact customer support?',
      'answer':
          'You can contact customer support through the "Help" section in the app or by calling our support line.'
    },
    {
      'question': 'How do I contact customer support?',
      'answer':
          'You can contact customer support through the "Help" section in the app or by calling our support line.'
    },
    {
      'question': 'How do I contact customer support?',
      'answer':
          'You can contact customer support through the "Help" section in the app or by calling our support line.'
    },
    {
      'question': 'How do I contact customer support?',
      'answer':
          'You can contact customer support through the "Help" section in the app or by calling our support line.'
    },
    // Add more FAQs as needed
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final Size screenSize = MediaQuery.of(context).size;

    // Calculate responsive dimensions
    final double height = screenSize.height * 0.85;
    final double width = screenSize.width > 600 ? 500 : screenSize.width * 0.9;

    return Scaffold(
      body: Center(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Frequently Asked Questions",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: faqs.length, // Use the dynamic list length
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 9.0, horizontal: 16.0),
                      child: Card(
                        elevation: 2,
                        child: ExpansionTile(
                          title: Text(faqs[index]['question'] ?? 'Question'),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(faqs[index]['answer'] ?? 'Answer'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
