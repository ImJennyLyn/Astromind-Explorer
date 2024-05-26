import 'package:finalproject/devProfile/dev1.dart';
import 'package:finalproject/devProfile/dev2.dart';
import 'package:finalproject/devProfile/dev3.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(DevProfiles());
}

class DevProfiles extends StatefulWidget {
  @override
  _DevProfilesState createState() => _DevProfilesState();
}

class _DevProfilesState extends State<DevProfiles> {
  AudioPlayer audioPlayer = AudioPlayer();

  int _currentIndex = 0;

  List<Map<String, dynamic>> profiles = [
    {
      'image': 'images/Cardimage/Nadala_Antoinette_image1.jpg',
      'text': 'Antoinette Nadala',
      'page': dev1(),
    },
    {
      'image': 'images/Cardimage/cris.jpg',
      'text': 'Cris John Angcaya',
      'page': dev2(),
    },
    {
      'image': 'images/Cardimage/jenny.png',
      'text': 'Jenny Lyn Vallador',
      'page': dev3(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/cardBg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider(
                  items: profiles.map((profile) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            audioPlayer.play(AssetSource(
                              'pop.mp3',
                            ));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => profile['page'],
                              ),
                            );
                          },
                          child: GlowingOverscrollIndicator(
                            axisDirection: AxisDirection.down,
                            color: const Color.fromARGB(
                                255, 34, 2, 40), // Glowing color
                            child: Container(
                              height: 250,
                              width: 300,
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(150, 81, 4, 157),
                                    Color.fromARGB(213, 95, 4, 69)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    blurRadius: 5.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage:
                                        AssetImage(profile['image']),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    profile['text'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 200.0,
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(profiles.length, (index) {
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index
                            ? Color(0xffff00cd)
                            : Colors.grey,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
