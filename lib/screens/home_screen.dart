import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlappyApp());
}

class FlappyApp extends StatelessWidget {
  const FlappyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlappyGame(),
    );
  }
}

class FlappyGame extends StatefulWidget {
  const FlappyGame({super.key});

  @override
  State<FlappyGame> createState() => _FlappyGameState();
}

class _FlappyGameState extends State<FlappyGame> {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: jump,
      child: Scaffold(
        backgroundColor: Colors.blue.shade300,
        body: Stack(
          children: [
            Align(
              alignment: Alignment(0, birdY),
              child: const Icon(
                Icons.flutter_dash,
                size: 50,
                color: Colors.yellow,
              ),
            ),

            Align(
              alignment: Alignment(pipeX, -1),
              child: Container(
                width: 60,
                height: MediaQuery.of(context).size.height * pipeHeight,
                color: Colors.green,
              ),
            ),

            Align(
              alignment: Alignment(pipeX, 1),
              child: Container(
                width: 60,
                height: MediaQuery.of(context).size.height * pipeHeight,
                color: Colors.green,
              ),
            ),

            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Score: $score',
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            if (!gameStarted)
              const Center(
                child: Text(
                  'TAP TO START',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            if (gameOver)
              Center(
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
                      child: const Text('RESTART'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
