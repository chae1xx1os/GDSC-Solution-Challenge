import 'package:flutter/material.dart';
import 'package:flutter_gdsc_sc/solution_challenge/game_page.dart';

class TryAgainPage extends StatelessWidget {
  const TryAgainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 150, left: 30, right: 30),
                  child: Container(
                    width: 400,
                    height: 200,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(0, 193, 177, 177)
                            .withOpacity(0.4),
                        border: Border.all(
                            color: const Color(0x00939393).withOpacity(1)),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(200)),
                          child: const Icon(
                            Icons.sentiment_very_dissatisfied,
                            size: 70,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color(0x008b956d).withOpacity(0.4),
                                border: Border.all(
                                    color: const Color(0x008b956d)
                                        .withOpacity(1))),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Try Again!',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'GamjaFlower'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(100),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.red,
                        boxShadow: const [
                          BoxShadow(blurRadius: 7, color: Colors.grey)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const GamePage()));
                          },
                          child: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 100,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}