import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const dev1());
}

class dev1 extends StatelessWidget {
  const dev1({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'images/backgroundimage/background.gif',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              child: SafeArea(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    width: 350.0,
                    height: 550,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(194, 81, 4, 157),
                          Color.fromARGB(230, 132, 95, 169),
                          Color.fromARGB(188, 237, 28, 178)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Color.fromARGB(255, 181, 178, 182),
                        width: 4.0,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          height: 120.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 15, 13, 13)
                                    .withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: AssetImage(
                              'images/Cardimage/Nadala_Antoinette_image1.jpg',
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Antoinette Nadala',
                          style: TextStyle(
                            fontFamily: 'Montez',
                            fontSize: 40.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '[full-stack developer]',
                          style: TextStyle(
                            fontFamily: 'SourceCodePro',
                            fontSize: 16,
                            color: Color.fromARGB(223, 232, 230, 230),
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _launchFacebook();
                              },
                              child: FaIcon(
                                FontAwesomeIcons.facebook,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                _launchTwitter();
                              },
                              child: FaIcon(
                                FontAwesomeIcons.twitter,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                _launchInstagram();
                              },
                              child: FaIcon(
                                FontAwesomeIcons.instagram,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'About',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 20,
                            color: Color.fromARGB(255, 25, 0, 37),
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'a 3rd year computer science student, adept in full-stack development with Flutter, HTML,CSS, JavaScript.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'SourceCodePro',
                            fontSize: 14,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchFacebook() async {
    launch('https://www.facebook.com/antoinadala');
  }

  void _launchTwitter() async {
    launch('https://twitter.com/iotna20');
  }

  void _launchInstagram() async {
    launch('https://www.instagram.com/antoinettenadala/');
  }
}
