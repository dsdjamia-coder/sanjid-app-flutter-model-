import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  // കൺസ്ട്രക്റ്ററിൽ ടൈറ്റിൽ കൂടി ഉൾപ്പെടുത്തി
  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ഗെയിം വേരിയബിളുകൾ
  double birdY = 0;
  double birdVelocity = 0;
  final double gravity = 0.004;
  final double jumpForce = -0.06;

  double pipeX = 1.5;
  double pipeGap = 0.35;
  double pipeHeight = 0.3;

  bool gameStarted = false;
  bool gameOver = false;
  int score = 0;

  Timer? gameTimer;

  void startGame() {
    gameStarted = true;
    gameOver = false;
    score = 0;
    birdY = 0;
    birdVelocity = 0;
    pipeX = 1.5;

    gameTimer?.cancel();
    gameTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        birdVelocity += gravity;
        birdY += birdVelocity;

        pipeX -= 0.02;
        if (pipeX < -1.5) {
          pipeX = 1.5;
          score++;
        }

        if (birdY > 1 || birdY < -1) {
          endGame();
        }

        if (pipeX.abs() < 0.15) {
          if (birdY < -pipeGap + pipeHeight ||
              birdY > pipeGap - pipeHeight) {
            endGame();
          }
        }
      });
    });
  }

  void jump() {
    if (!gameStarted) {
      startGame();
    } else if (!gameOver) {
      birdVelocity = jumpForce;
    }
  }

  void endGame() {
    gameTimer?.cancel();
    gameOver = true;
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: jump,
      child: Scaffold(
        backgroundColor: Colors.blue.shade300,
        body: Stack(
          children: [
            // ബേർഡ് ഐക്കൺ
            Align(
              alignment: Alignment(0, birdY),
              child: const Icon(
                Icons.flutter_dash,
                size: 50,
                color: Colors.yellow,
              ),
            ),

            // മുകളിലെ പൈപ്പ്
            Align(
              alignment: Alignment(pipeX, -1.1),
              child: Container(
                width: 60,
                height: MediaQuery.of(context).size.height * pipeHeight,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 2),
                ),
              ),
            ),

            // താഴത്തെ പൈപ്പ്
            Align(
              alignment: Alignment(pipeX, 1.1),
              child: Container(
                width: 60,
                height: MediaQuery.of(context).size.height * pipeHeight,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 2),
                ),
              ),
            ),

            // സ്കോർ ഡിസ്‌പ്ലേ
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      widget.title, // app_root-ൽ നിന്ന് വരുന്ന ടൈറ്റിൽ
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      'Score: $score',
                      style: const TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (!gameStarted)
              const Center(
                child: Text(
                  'തുടങ്ങാൻ ടാപ്പ് ചെയ്യുക',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            if (gameOver)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'GAME OVER',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: startGame,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('RESTART'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
