import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:async';
import 'package:flutter_gdsc_sc/solution_challenge/try_again_page.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final SpeechToText _speechToText = SpeechToText();
  final List<String> _speechResultsList = [];
  bool _speechEnabled = false;
  String _wordsSpoken = "";
  bool _gameEnabled = true;
  int stickliedValue = 4;

  int _player1Score = 0;
  int _player2Score = 0;
  int _playerTurn = 0;

  List<String> data = List.filled(4, '');
  List<String> urls = [
    'http://192.168.0.19',
    'http://192.168.0.174',
    'http://192.168.0.114',
    'http://192.168.0.163'
  ];

  // Timer 관련 상수 및 변수 추가
  static const maxSeconds = 5;
  int timeLeft = maxSeconds;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    fetchData();
    initSpeech();
    _autoPressButton();
    timer = Timer.periodic(
        const Duration(milliseconds: 500), (timer) => fetchData());
  }

  @override
  void dispose() {
    timer.cancel(); // 타이머 취소
    super.dispose();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  void _startListening() async {
    _clearWordsSpoken(); // _wordsSpoken 초기화
    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: 'en_US', // 영어로만 인식되도록 설정
    );
    _startCoutDonwn(); // 초시계 작동
    setState(() {
      //_confidenceLevel = 0;
    });
  }

  void fetchData() async {
    for (var i = 0; i < urls.length; i++) {
      try {
        final response = await http.get(Uri.parse(urls[i]));
        if (response.statusCode == 200) {
          var document = parse(response.body);
          if (document.body != null) {
            var gyroData = document.body!.text.split(',');
            if (gyroData.isNotEmpty) {
              var num = gyroData[0].split(':')[1].trim();
              setState(() {
                data[i] = num;
              });
            }
          }
        }
      } catch (e) {
        // 오류 처리 부분 생략
      }
    }
  }

  Future<int> _stickling() async {
    print("ESP Data: $stickliedValue");
    if (data[0] == "0") {
      stickliedValue = 0;
    } else if (data[1] == "1") {
      stickliedValue = 1;
    } else if (data[2] == "2") {
      stickliedValue = 2;
    } else if (data[3] == "3") {
      stickliedValue = 3;
    } else {
      stickliedValue = 4;
    }
    print("ESP Data: $stickliedValue");
    return stickliedValue;
  }

  void _stopListening() async {
    int sticklied = await _stickling(); // Future<bool> 값을 받아옴
    await _speechToText.stop();
    setState(() {
      if (_wordsSpoken == "" ||
          _speechResultsList.contains(_wordsSpoken) ||
          _playerTurn % 4 != sticklied) {
        _gameEnabled = false;
        _navigateToTryAgainPage();
      } else {
        _changeText();
        _autoPressButton();
        _speechResultsList.add(_wordsSpoken);
        setState(() {
          if (_playerTurn % 2 == 0) {
            _player1Score++;
          } else {
            _player2Score++;
          }
          _playerTurn++;
        });
      }
    });
  }

  void _clearWordsSpoken() {
    setState(() {
      _wordsSpoken = "";
    });
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = "${result.recognizedWords}";
      //_confidenceLevel = result.confidence;
    });
  }

  void _startCoutDonwn() {
    Future.delayed(const Duration(seconds: 1), () {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timeLeft > 0) {
          setState(() {
            timeLeft--;
          });
        } else {
          resetTimer();
          timer.cancel();
        }
      });
    });
  }

  void resetTimer() {
    setState(() {
      _stopListening();
      timeLeft = maxSeconds;
    });
  }

  void _autoPressButton() {
    //  1초 후에 자동으로 Button을 누르도록 설정
    Future.delayed(const Duration(seconds: 1), () {
      if (_gameEnabled) {
        _startListening();
      }
    });
  }

  void _restartGame() {
    setState(() {
      _gameEnabled = true;
      _player1Score = 0;
      _player2Score = 0;
      _playerTurn = 0;
      //_confidenceLevel = 0;
      _speechResultsList.clear();
      _clearWordsSpoken();
    });
  }

  IconData _iconData = Icons.info;
  bool _showIconAndBox = false;

  void _changeText() {
    setState(() {
      _showIconAndBox = true;
      _iconData = Icons.sentiment_satisfied_alt;
      Timer(const Duration(seconds: 2), () {
        setState(() {
          _showIconAndBox = false;
          _iconData = Icons.info;
        });
      });
    });
  }

  void _navigateToTryAgainPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TryAgainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _speechToText.isListening
                          ? "Listening"
                          : _speechEnabled
                          ? "Not Listening"
                          : "Speech not available",
                      style: const TextStyle(fontSize: 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        alignment: Alignment.center,
                        width: constraints.maxWidth * 0.8,
                        height: constraints.maxHeight * 0.3,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(0, 193, 177, 177)
                                .withOpacity(0.4),
                            border: Border.all(
                                color: const Color(0x00939393).withOpacity(1)),
                            borderRadius: BorderRadius.circular(15)),
                        child: _showIconAndBox
                            ? Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(200),
                                    color: Colors.green),
                                child: Icon(
                                  _iconData,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                                height: constraints.maxHeight * 0.05),
                            Container(
                              width: constraints.maxWidth * 0.8 * 0.3,
                              height: constraints.maxHeight * 0.3 * 0.25,
                              decoration: BoxDecoration(
                                  color: const Color(0x008b956d)
                                      .withOpacity(0.4),
                                  border: Border.all(
                                      color: const Color(0x008b956d)
                                          .withOpacity(1))),
                              child: const Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Go On!',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'GamjaFlower'),
                                  ),
                                ],
                              ), // 작은 박스
                            ),
                          ],
                        )
                            : ListView.builder(
                          itemCount: _speechResultsList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_speechResultsList[index],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'BlackHanSans')),
                            );
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' $_player1Score : $_player2Score',
                          style: const TextStyle(
                              fontSize: 80,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'BlackHanSans'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.001,
                    ),
                    Text(
                      // timeLeft == 0 ? 'DONE' : timeLeft.toString(),
                      timeLeft == 0 ? '' : timeLeft.toString(),
                      style: const TextStyle(
                          fontSize: 150,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'BlackHanSans'),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.001)
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}