import 'package:flutter/material.dart';
import 'info_card.dart';
import 'game_utils.dart';
import 'package:finalproject/GamesScreen/games.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MemoryGame(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MemoryGame extends StatefulWidget {
  const MemoryGame({Key? key}) : super(key: key);

  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  AudioPlayer audioPlayer = AudioPlayer();

  TextStyle whiteText = TextStyle(color: Colors.white);
  Game _game = Game();
  int tries = 0;
  int score = 0;
  @override
  void initState() {
    super.initState();
    _game.initGame();
  }

  void _resetGame() {
    setState(() {
      _game.initGame();
      tries = 0;
      score = 0;
    });
  }

  void _showHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameChoice()),
    );
  }

  void _showWinPopup() {
    audioPlayer.play(AssetSource(
      'success.mp3',
    ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You Win!'),
          content: Text('Congratulations! You completed the game!'),
          actions: [
            TextButton(
              onPressed: () {
                _resetGame();
                Navigator.pop(context);
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void _showTutorialDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/backgroundimage/dialog.jpg'), // Replace with your image asset
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Color.fromARGB(255, 212, 193, 211),
                width: 5.0,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Welcome to Memory Game!',
                    style: TextStyle(
                      fontFamily: 'Salsa',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '1. The game initializes with a grid of cards, tracking the number of tries and score.',
                    style: TextStyle(
                      fontFamily: 'Genos',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '2. Players tap cards to reveal them, and the game updates the score based on matches.',
                    style: TextStyle(
                      fontFamily: 'Genos',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '3. Win and game over popups appear for specific conditions.',
                    style: TextStyle(
                      fontFamily: 'Genos',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Add your tutorial content here
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 116, 16, 138),
              ),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showGameOverPopup() {
    audioPlayer.play(AssetSource(
      'over.mp3',
    ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content:
              Text('You have reached the maximum number of moves. Try again!'),
          actions: [
            TextButton(
              onPressed: () {
                _resetGame();
                Navigator.pop(context);
              },
              child: Text('Retry'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/backgroundimage/Memory.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                info_card("Tries", "$tries"),
                info_card("Score", "$score"),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                itemCount: _game.gameImg!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 13.0,
                  mainAxisSpacing: 13.0,
                ),
                padding: EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      audioPlayer.play(AssetSource(
                        'flipcard.mp3',
                      ));
                      setState(() {
                        tries++;
                        _game.gameImg![index] = _game.cards_list[index];
                        _game.matchCheck.add({index: _game.cards_list[index]});
                      });
                      if (_game.matchCheck.length == 2) {
                        if (_game.matchCheck[0].values.first ==
                            _game.matchCheck[1].values.first) {
                          score += 100;
                          _game.matchCheck.clear();

                          // Check for the win condition
                          if (score == 800) {
                            _showWinPopup();
                          }
                        } else {
                          Future.delayed(Duration(milliseconds: 500), () {
                            setState(() {
                              _game.gameImg![_game.matchCheck[0].keys.first] =
                                  _game.hiddenCardpath;
                              _game.gameImg![_game.matchCheck[1].keys.first] =
                                  _game.hiddenCardpath;
                              _game.matchCheck.clear();
                            });
                          });
                        }
                      }

                      // Check for game over condition
                      if (tries >= 30) {
                        _showGameOverPopup();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 14, 0, 37),
                        borderRadius: BorderRadius.circular(3.0),
                        image: DecorationImage(
                          image: AssetImage(_game.gameImg![index]),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: Color.fromARGB(255, 212, 193, 211),
                          width: 2.0,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 5.0),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    30), // Adjust the border radius as needed
                gradient: LinearGradient(
                  colors: [Color(0xffde3dfe), Color(0xfffe3da8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(
                        0x3cae2468), // Adjust the shadow color and opacity
                    spreadRadius: 2, // Adjust the spread radius
                    blurRadius: 5, // Adjust the blur radius
                    offset: Offset(0, 3), // Adjust the offset
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: () {
                  audioPlayer.play(AssetSource(
                    'pop.mp3',
                  ));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameChoice()),
                  );
                },
                child: Icon(Icons.home, size: 40),
                backgroundColor: Colors.transparent,
                elevation: 0, // Remove the default elevation
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [Color(0xffb014b5), Color(0xfffd1dc5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3cae2468),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: () {
                  audioPlayer.play(AssetSource(
                    'pop.mp3',
                  ));
                  _showTutorialDialog(
                      context); // Call the function to show the tutorial dialog
                },
                child: Icon(Icons.help, size: 40),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
