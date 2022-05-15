import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'HomeView.dart';

class SplashView extends StatefulWidget {
  final CameraDescription cameraDescription;
  const SplashView({Key? key, required this.cameraDescription}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/landing.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black54,
          child: Stack(
            children: <Widget>[
              Container(),
              Positioned(
                bottom: 90,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomeView(
                            title: 'Bushier2',
                            cameraDescription: widget.cameraDescription,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      height: 85,
                      // width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 67, 154, 103),
                      ),
                      child: const Center(
                        child: Text(
                          'Enter App',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 230,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      'D4DDY Some placeholder text here please!',
                      style: TextStyle(
                        height: 1.2,
                        color: Colors.white,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
