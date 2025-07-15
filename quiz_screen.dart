import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, Object>> _questions = [
    {
      'question': 'What is the safest way to check if a message is from your bank?',
      'options': [
        'Click the link in the SMS',
        'Call the number in the message',
        'Log in via bank’s official app or website',
        'Reply to the email and ask'
      ],
      'answer': 2,
    },
    {
      'question': 'Which of these is a strong password?',
      'options': [
        'password123',
        'yourname@123',
        'Xyz@#8120_!',
        '12345678'
      ],
      'answer': 2,
    },
    {
      'question': 'What is phishing?',
      'options': [
        'A cybercrime to steal data through fake messages or emails',
        'A type of investment scam',
        'Hacking your phone physically',
        'None of the above'
      ],
      'answer': 0,
    },
  ];

  int _currentIndex = 0;
  int _score = 0;
  bool _answered = false;
  int? _selectedOption;

  void _handleAnswer(int index) {
    if (_answered) return;

    setState(() {
      _selectedOption = index;
      _answered = true;
      if (_selectedOption == _questions[_currentIndex]['answer']) {
        _score++;
      }
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _currentIndex++;
        _answered = false;
        _selectedOption = null;
      });
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _answered = false;
      _selectedOption = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex >= _questions.length) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz Completed'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You scored $_score / ${_questions.length}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _restartQuiz,
                child: Text('Restart'),
              ),
            ],
          ),
        ),
      );
    }

    final question = _questions[_currentIndex];
    final options = question['options'] as List<String>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${_currentIndex + 1}/${_questions.length}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              question['question'] as String,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            ...options.asMap().entries.map((entry) {
              final idx = entry.key;
              final text = entry.value;
              final isCorrect = idx == question['answer'];
              final isSelected = idx == _selectedOption;

              Color? color;
              if (_answered) {
                if (isSelected && isCorrect) {
                  color = Colors.green;
                } else if (isSelected && !isCorrect) {
                  color = Colors.red;
                }
              }

              return Card(
                color: color,
                child: ListTile(
                  title: Text(text),
                  onTap: () => _handleAnswer(idx),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
