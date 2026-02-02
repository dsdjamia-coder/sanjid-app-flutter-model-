import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlappyApp());
}

class FlappyApp extends StatelessWidget {
  const FlappyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp-ൽ നിന്ന് const ഒഴിവാക്കി, home-ൽ ഉള്ള വിഡ്ജറ്റിന് const നൽകി.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ഫ്ലാപ്പി ബേർഡ്',
      home: const FlappyGame(),
    );
  }
}

class FlappyGame extends StatefulWidget {
  const FlappyGame({super.key});

  @override
  State<FlappyGame> createState() => _FlappyGameState();
}

class _FlappyGameState extends State<FlappyGame> {
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

  // ഗെയിം തുടങ്ങാനുള്ള ഫംഗ്ഷൻ
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

        // പൈപ്പുകൾ ചലിപ്പിക്കുന്നു
        pipeX -= 0.02;
        if (pipeX < -1.5) {
          pipeX = 1.5;
          score++;
        }

        // ഗെയിം ഓവർ കണ്ടീഷനുകൾ (മുകളിലോ താഴെയോ തട്ടിയാൽ)
        if (birdY > 1 || birdY < -1) {
          endGame();
        }

        // പൈപ്പിൽ തട്ടിയാൽ
        if (pipeX.abs() < 0.15) {
          if (birdY < -pipeGap + pipeHeight ||
              birdY > pipeGap - pipeHeight) {
            endGame();
          }
        }
      });
    });
  }

  // ചാടാനുള്ള ഫംഗ്ഷൻ
  void jump() {
    if (!gameStarted) {
      startGame();
    } else if (!gameOver) {
      birdVelocity = jumpForce;
    }
  }

  // ഗെയിം അവസാനിപ്പിക്കുന്നു
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
            // പക്ഷി (Flutter Dash Icon)
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

            // സ്കോർ ബോർഡ്
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Score: $score',
                  style: const TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                  ),
                ),
              ),
            ),

            // ഗെയിം തുടങ്ങാൻ ആവശ്യപ്പെടുന്ന മെസ്സേജ്
            if (!gameStarted)
              const Center(
                child: Text(
                  'കളിക്കാൻ ടാപ്പ് ചെയ്യുക',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            // ഗെയിം ഓവർ സ്ക്രീൻ
            if (gameOver)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'കളി കഴിഞ്ഞു!',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'നിങ്ങളുടെ സ്കോർ: $score',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: startGame,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('വീണ്ടും കളിക്കുക'),
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
