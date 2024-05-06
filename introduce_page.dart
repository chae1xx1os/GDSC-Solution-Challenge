import 'package:flutter/material.dart';
import 'package:flutter_gdsc_sc/solution_challenge/sc_homescreen.dart';

class introducePage1 extends StatelessWidget {
  const introducePage1({super.key});
  final textStyle = const TextStyle(
    fontFamily: 'GamjaFlower',
    fontSize: 35,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'sc_image/introduce_1.png',
                      width: constraints.maxHeight * 0.5,
                      height: constraints.maxWidth * 0.5,
                    ),
                    Positioned(
                      left: 60,
                      child: Icon(
                        Icons.trending_up_rounded,
                        size: constraints.maxHeight * 0.3,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: textStyle,
                        children: const [
                          TextSpan(
                            text: 'Alzheimer is a\n',
                          ),
                          TextSpan(
                            text: 'high-risk disease',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ',\nand it can occur even\nat a ',
                          ),
                          TextSpan(
                            text: 'young age',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '\n',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const introducePage2()),
                      );
                    },
                    icon: const Icon(
                      Icons.play_arrow,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class introducePage2 extends StatelessWidget {
  const introducePage2({super.key});
  final textStyle = const TextStyle(fontFamily: 'GamjaFlower', fontSize: 35);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'sc_image/introduce_2.png',
                    width: constraints.maxHeight * 0.5,
                    height: constraints.maxWidth * 0.5,
                  ),
                  Positioned(
                    left: 60,
                    child: Icon(
                      Icons.search,
                      size: constraints.maxHeight * 0.3,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      style: textStyle,
                      children: const [
                        TextSpan(
                          text: 'If detected ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'early',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '\nmanaged appropriately,',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '\nit can be helpful \nfor prevention',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const introducePage3()),
                    );
                  },
                  icon: const Icon(
                    Icons.play_arrow,
                    size: 50,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class introducePage3 extends StatelessWidget {
  const introducePage3({super.key});
  final textStyle = const TextStyle(fontFamily: 'GamjaFlower', fontSize: 35);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'sc_image/introduce_3.png',
                      width: constraints.maxHeight * 0.55,
                      height: constraints.maxWidth * 0.55,
                    ),
                    Positioned(
                      left: 70,
                      top: 35,
                      child: Icon(Icons.health_and_safety,
                          color: Colors.white,
                          size: constraints.maxHeight * 0.3),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: textStyle,
                        children: const [
                          TextSpan(
                            text:
                                'So we created a game\nthat can help improve both ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: '\nphysical fitness',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'memory',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: '\nat the same time!',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const introducePage4()),
                      );
                    },
                    icon: const Icon(Icons.play_arrow, size: 50),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class introducePage4 extends StatelessWidget {
  const introducePage4({super.key});
  final textStyle = const TextStyle(fontFamily: 'GamjaFlower', fontSize: 35);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 6),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'sc_image/introduce_4.png',
                    width: constraints.maxHeight * 0.55,
                    height: constraints.maxWidth * 0.55,
                  ),
                  Positioned(
                    left: 130,
                    top: 40,
                    child: Icon(
                      Icons.settings_accessibility,
                      size: constraints.maxHeight * 0.2,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Okay! Lets start game!!',
                    style: textStyle,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen_play()),
                    );
                  },
                  icon: const Icon(
                    Icons.play_arrow,
                    size: 50,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}