import 'package:flutter/material.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxseek_v1/src/screens/home/home_screen_final.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});
  static const route = "/disclaimer";
  static const name = "DisclaimerScreen";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Column(
          children: [
            Center(
              child: Container(
                width: 600, // Add width and height constraints
                height: 600,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: AssetImage("assets/images/Disclaimer screen2.png"),
                      fit:
                          BoxFit.cover, // Ensure the image covers the container
                    )),
              ),
            ),
            // SizedBox(
            //   height: 134,
            //   child: Container(
            //     decoration: const BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage("assets/images/rxseek_logo_name.png")),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 50),
            SizedBox(
              width: 400, // Set the desired width
              height: 70,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        // ignore: use_full_hex_values_for_flutter_colors
                        WidgetStateProperty.all(const Color(0xffe37b1b8)),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                    elevation: WidgetStateProperty.all(10),
                  ),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 600,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    "Disclaimer",
                                    style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 31,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    "The information provided by this Language Model (LLM) is for educational and informational purposes only and is not intended as a substitute for diagnosis, or treatment. By using this LLM, you acknowledge that you understand these limitations and agree to consult a qualified healthcare professional for all medical and health-related inquiries. The creators and providers of this LLM are not responsible for any consequences arising from the use or misuse of the information provided. For any questions or concerns about the information provided by this LLM, please contact a licensed healthcare provider.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'SourceSans3',
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    GlobalRouter.I.router
                                        .go(HomeScreenFinal.route);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all(Colors.blue),
                                  ),
                                  child: const Text(
                                    "Understood",
                                    style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
