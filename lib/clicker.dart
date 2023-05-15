import 'package:flutter/material.dart';
import 'package:holding_gesture/holding_gesture.dart';

class Clicker extends StatefulWidget {
  const Clicker({super.key});

  @override
  State<Clicker> createState() => _ClickerState();
}

class _ClickerState extends State<Clicker> {
  double counter = 0;
  double _scale = 1.0;
  bool _visible = false;

  void increaseCounter() {
    setState(() {
      counter += 5;
      _scale += 0.05;
    });
  }

  void resetCounter() {
    setState(() {
      counter = 0;
      _scale = 1;
    });
    print('reset');
  }

  void checkCounter() {
    if (counter >= 200) {
      resetCounter();
      _visible = true;
    } else {
      _visible = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 68),
            alignment: Alignment.topCenter,
            child: Text('CLICK'),
          ),
          Center(
            child: AnimatedScale(
              duration: Duration(milliseconds: 100),
              scale: _scale,
              child: SizedBox(
                width: 100.0,
                height: 100.0,
                child: HoldDetector(
                  onHold: resetCounter,
                  holdTimeout: Duration(milliseconds: 100),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: CircleBorder()),
                    onPressed: () {
                      increaseCounter();
                      checkCounter();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          counter.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        const Icon(
                          Icons.touch_app_rounded,
                          size: 26,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 140),
              child: Text(
                'YOU WON!',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
