import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';

const kncircleColor = Color(0xFFFF1744);
const knredColor = Color(0xFFFFCDD2);
const knbackgroundColor = Color(0xFFB71C1C);

final largeTextStyle = GoogleFonts.poppins(
    color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold);
final smallTextStyle =
    GoogleFonts.poppins(color: knbackgroundColor, fontWeight: FontWeight.w600);

void main() {
  runApp(const KnightApp());
}

class KnightApp extends StatelessWidget {
  const KnightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const CountDownTimer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({super.key});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

final _countDownController = CountDownController();

class _CountDownTimerState extends State<CountDownTimer> {
  TextEditingController durationController = TextEditingController();
  int _timeDuration = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: knbackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularCountDownTimer(
              controller: _countDownController,
              duration: _timeDuration,
              isReverse: true,
              fillColor: kncircleColor,
              height: 250,
              width: 250,
              strokeWidth: 35,
              onComplete: () => {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Countdown Ended',
                    style: smallTextStyle,
                  ),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 2),
                  backgroundColor: knredColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ))
              },
              onStart: () => {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Countdown Started',
                    style: smallTextStyle,
                  ),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 2),
                  backgroundColor: knredColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ))
              },
              strokeCap: StrokeCap.round,
              isReverseAnimation: true,
              ringColor: knredColor,
              autoStart: false,
              textStyle: largeTextStyle,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Button(
                    text: 'Start',
                    onPressed: () => _countDownController.start()),
                const SizedBox(
                  width: 10,
                ),
                Button(
                    text: 'Pause',
                    onPressed: () => _countDownController.pause()),
              ]),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Button(
                    text: 'Resume',
                    onPressed: () => _countDownController.resume()),
                const SizedBox(
                  width: 10,
                ),
                Button(
                    text: 'Restart',
                    onPressed: () => _countDownController.start()),
              ])
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                cursorColor: knredColor,
                controller: durationController,
                decoration: const InputDecoration(
                  labelText: 'Enter Time Duration in Seconds',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Button(
                  text: 'SetTimer',
                  onPressed: () {
                    if (durationController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Time can't be Empty",
                          style: smallTextStyle,
                        ),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 2),
                        backgroundColor: knredColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ));
                    }
                    int newDuration = int.parse(durationController.text);
                    setState(() {
                      _timeDuration = newDuration;
                    });
                    _timeDuration = newDuration;
                  }),
            ],
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: smallTextStyle,
        ));
  }
}
