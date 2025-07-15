import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  int selectedOption = -1;
  bool answered = false;

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "You receive a call claiming to be your bank asking for your OTP. What should you do?",
      "options": [
        "Share OTP to confirm identity",
        "Ignore and report the call",
        "Call them back later",
        "Give only part of the OTP"
      ],
      "answerIndex": 1
    },
    {
      "question":
          "Which is a sign of a phishing website?",
      "options": [
        "HTTPS in the URL",
        "Misspelled domain names",
        "Padlock icon in address bar",
        "Official bank app"
      ],
      "answerIndex": 1
    },
    {
      "question":
          "What is the safest way to access your bank account?",
      "options": [
        "Clicking on links in SMS",
        "Logging in from cyber café",
        "Using official bank app",
        "Using shared Wi-Fi"
      ],
      "answerIndex": 2
    }
  ];

  void checkAnswer(int index) {
    setState(() {
      selectedOption = index;
      answered = true;
      if (index == questions[currentQuestionIndex]["answerIndex"]) {
        score++;
      }
    });
  }

  void goToNext() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedOption = -1;
        answered = false;
      } else {
        // Quiz finished
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(score: score, total: questions.length),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text("Fraud Awareness Quiz"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Question ${currentQuestionIndex + 1} of ${questions.length}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 15),
            Text(currentQuestion["question"],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            ...List.generate(currentQuestion["options"].length, (index) {
              final isCorrect = currentQuestion["answerIndex"] == index;
              final isSelected = selectedOption == index;
              Color? tileColor;

              if (answered) {
                if (isSelected && isCorrect)
                  tileColor = Colors.green[200];
                else if (isSelected && !isCorrect)
                  tileColor = Colors.red[200];
              }

              return ListTile(
                title: Text(currentQuestion["options"][index]),
                tileColor: tileColor,
                onTap: answered ? null : () => checkAnswer(index),
              );
            }),
            SizedBox(height: 30),
            if (answered)
              Center(
                child: ElevatedButton(
                  onPressed: goToNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text(
                    currentQuestionIndex < questions.length - 1
                        ? "Next"
                        : "Finish",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

// RESULT SCREEN
class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified_user, size: 100, color: Colors.deepPurple),
              SizedBox(height: 30),
              Text(
                "Quiz Completed!",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade800),
              ),
              SizedBox(height: 20),
              Text(
                "You scored $score out of $total",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to Welcome screen
                },
                child: Text("Back to Home"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

      