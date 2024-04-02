import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int seconds = 0,
      minutes = 0,
      hours = 0;
  String DigitSeconds = "00",
      DigitMinutes = "00",
      DigitHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  void Stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void Reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      DigitSeconds = "00";
      DigitMinutes = "00";
      DigitHours = "00";

      started = false;
      laps.clear();
    });
  }

  void addLaps() {
    String lap = "$DigitHours:$DigitMinutes:$DigitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  void Start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        DigitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        DigitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        DigitHours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Stopwatch',style: TextStyle(fontSize: 26,color: Colors.teal,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.teal, width: 5),
                  // color: Colors.teal.shade50,
                ),
                child: Center(
                  child: Text(
                    '$DigitHours:$DigitMinutes:$DigitSeconds',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 310,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap ${index + 1}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            "${laps[index]}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Reset();
                    },
                    icon: Icon(Icons.replay, color: Colors.teal),
                    iconSize: 35,
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      (!started) ? Start() : Stop();
                    },
                    icon: Icon((!started)
                        ? CupertinoIcons.play_circle_fill
                        : CupertinoIcons.pause_circle_fill,
                        color: Colors.teal),
                    iconSize: 50,
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      addLaps();
                    },
                    icon: Icon(Icons.flag, color: Colors.teal),
                    iconSize: 35,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
