import 'package:finalproject/GamesScreen/devprofiles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'color_home.dart';
import 'puzzle_home.dart';
import 'slot_home.dart';
import 'dice_home.dart';
import 'scramble_home.dart';
import 'tictac_home.dart';
import 'memogame_home.dart';
import 'menu.dart';
import 'rock_home.dart';
import 'quiz_home.dart';

class GameChoice extends StatefulWidget {
  @override
  _GameChoiceState createState() => _GameChoiceState();
}

class _GameChoiceState extends State<GameChoice> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            //app bar with welcome banner of the games
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(''),
                background: Stack(
                  children: [
                    Container(
                      height: 190.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/backgroundimage/AME.gif'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16.0,
                      right: 16.0,
                      child: FloatingActionButton(
                        onPressed: () {
                          audioPlayer.play(AssetSource('pop.mp3'));
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return MenuContent();
                            },
                          );
                        },
                        child: Icon(Icons.person),
                        backgroundColor: Color.fromARGB(255, 40, 3, 65),
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: Color.fromARGB(255, 40, 3, 65),
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.sports_esports, size: 29.0),
                  ),
                  Tab(
                    icon: Icon(Icons.info, size: 29.0),
                  ),
                ],
              ),
            ),
            // list of games
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  // Mind Games Tab
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('images/backgroundimage/background.gif'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            alignment: Alignment.center,
                            child: Text(
                              'Mind Games',
                              style: TextStyle(
                                fontSize: 40.0,
                                color: Color.fromARGB(255, 232, 226, 226),
                                fontFamily: 'RubikDoodleShadow',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          // mind games using caraousel slider
                          SizedBox(height: 0),
                          Container(
                            color: Color.fromARGB(31, 51, 2, 60),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: 180,
                                viewportFraction: 0.4,
                                enlargeCenterPage: true,
                                aspectRatio: 2.0,
                                autoPlayInterval: Duration(seconds: 3),
                              ),
                              items: [
                                CustomButton(
                                  buttonText: '',
                                  imagePath: 'images/games/qt.png',
                                  onPressed: () {
                                    audioPlayer.play(AssetSource(
                                      'decide.mp3',
                                    ));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QuizHome(),
                                      ),
                                    );
                                  },
                                ),
                                CustomButton(
                                  buttonText: '',
                                  imagePath: 'images/games/tc.png',
                                  onPressed: () {
                                    audioPlayer.play(AssetSource(
                                      'decide.mp3',
                                    ));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TictacHome(),
                                      ),
                                    );
                                  },
                                ),
                                CustomButton(
                                  buttonText: '',
                                  imagePath: 'images/games/mg.png',
                                  onPressed: () {
                                    audioPlayer.play(AssetSource(
                                      'decide.mp3',
                                    ));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MemoHome(),
                                      ),
                                    );
                                  },
                                ),
                                CustomButton(
                                  buttonText: '',
                                  imagePath: 'images/games/sp.png',
                                  onPressed: () {
                                    audioPlayer.play(AssetSource(
                                      'decide.mp3',
                                    ));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PuzzleHome(),
                                      ),
                                    );
                                  },
                                ),
                                CustomButton(
                                  buttonText: '',
                                  imagePath: 'images/games/sw.png',
                                  onPressed: () {
                                    audioPlayer.play(AssetSource(
                                      'decide.mp3',
                                    ));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ScrambleHome(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 500,
                            height: 100,
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            alignment: Alignment.center,
                            child: Text(
                              'Lucky Games',
                              style: TextStyle(
                                fontSize: 40.0,
                                color: Colors.white,
                                fontFamily: 'RubikDoodleShadow',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          // lucky  games using caraousel slider

                          Container(
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: 180.0,
                                viewportFraction: 0.4,
                                enlargeCenterPage: true,
                                aspectRatio: 1.0,
                                autoPlayInterval: Duration(seconds: 3),
                              ),
                              items: [
                                CustomButton(
                                  buttonText: '',
                                  imagePath: 'images/games/rd.png',
                                  onPressed: () {
                                    audioPlayer.play(AssetSource(
                                      'decide.mp3',
                                    ));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DiceHome(),
                                      ),
                                    );
                                  },
                                ),
                                CustomButton(
                                  buttonText: '',
                                  imagePath: 'images/games/sm.png',
                                  onPressed: () {
                                    audioPlayer.play(AssetSource(
                                      'decide.mp3',
                                    ));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SlotHome(),
                                      ),
                                    );
                                  },
                                ),
                                CustomButton(
                                  buttonText: '',
                                  imagePath: 'images/games/cg.png',
                                  onPressed: () {
                                    audioPlayer.play(AssetSource(
                                      'decide.mp3',
                                    ));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ColorHome(),
                                      ),
                                    );
                                  },
                                ),
                                CustomButton(
                                  buttonText: '',
                                  imagePath: 'images/games/rps.png',
                                  onPressed: () {
                                    audioPlayer.play(AssetSource(
                                      'decide.mp3',
                                    ));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RockHome(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 45),
                        ],
                      ),
                    ),
                  ),
                  // About Us Tab
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/backgroundimage/aboutbg.gif'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: const EdgeInsets.all(25.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About Us',
                            style: TextStyle(
                              fontSize: 50,
                              fontFamily: 'RubikDoodleShadow',
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 191, 185, 193),
                            ),
                          ),

                          SizedBox(height: 16),

                          //  clickable button
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to another page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DevProfiles()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.all(10.0),
                              primary: Colors
                                  .transparent, //  button background color to transparent
                            ),
                            child: Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF4A148C),
                                    Color(0xFF7E57C2)
                                  ], // Set your gradient colors
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Developers',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Purpose:',
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 224, 222, 222),
                            ),
                          ),
                          Text(
                            'Final Project for COSC30',
                            style: TextStyle(
                              fontFamily: 'Poppins-Medium',
                              fontSize: 14,
                              color: Color.fromARGB(255, 201, 199, 201),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'About the Game:',
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 224, 222, 222),
                            ),
                          ),
                          Text(
                            'Astromind Explorer is not just a single game; it is a collection of multiple challenging games within the vast universe. Each game presents a unique set of puzzles, mind games and lucky games, offering a diverse and thrilling gaming experience.',
                            style: TextStyle(
                              fontFamily: 'Poppins-Medium',
                              fontSize: 14,
                              color: Color.fromARGB(255, 201, 199, 201),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Follow us on social media:',
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Image.asset(
                                  'images/icons/facebook.png',
                                ),
                                iconSize: 50,
                                onPressed: () {
                                  _launchFacebook();
                                },
                              ),
                              IconButton(
                                icon: Image.asset(
                                  'images/icons/instagram.png',
                                ),
                                iconSize: 50,
                                onPressed: () {
                                  _launchInstagram();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//link of socmed using url launch
  void _launchInstagram() async {
    launch('https://www.instagram.com/astromindexplorer/');
  }

  void _launchFacebook() async {
    launch('https://www.facebook.com/profile.php?id=61555822293380');
  }
}

class CustomButton extends StatelessWidget {
  final String buttonText;
  final String imagePath;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 62, 0, 67).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 0,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
