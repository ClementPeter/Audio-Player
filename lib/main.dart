import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  //final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? status = ""; //status of the song -play, pause, stop
  String? duration; //Song Duration
  String? position; //Song position

  AudioPlayer audioPlayer =
      AudioPlayer(); // Play audio from local device and online

  AudioCache audioCache = AudioCache(); //

  @override
  void initState() {
    super.initState();
    setState(() {
      audioPlayer = AudioPlayer(); //Audio player Instance
      audioCache = AudioCache(fixedPlayer: audioPlayer);
    });
  }

  // @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
  }

  //Functions to play, pause and stop
  void play() {
    audioPlayer.stop();
    audioCache.play('vanilla.mp3');

    setState(() {
      status = 'Play';
    });
  }

  void pause() {
    status = 'Pause';
    audioPlayer.pause();
    setState(() {
      status = 'Pause';
    });
  }

  void stop() {
    audioPlayer.stop();
    setState(() {
      status = 'Stop';
    });
  }

  //Song Duration/ lenght
  // String getDuration() {
  //   audioPlayer.getDuration().then((value) {
  //     setState(() {
  //       duration = (value / 60000).toStringAsFixed(2);

  //       //convert the millisecond value to minutes
  //     });
  //   });
  //   return duration!;
  // }

  //Song current postion
  // String getPosition()  {
  //   audioPlayer.getCurrentPosition().then((value) {
  //        setState(() {
  //     position = (value / 60000).toStringAsFixed(2);
  //   });
  //   });

  // }

  @override
  Widget build(BuildContext context) {
    audioPlayer.getDuration().then((value) {
      setState(() {
        duration = (value / 60000).toStringAsFixed(2);
        //convert the millisecond value to minutes
      });
    });
    audioPlayer.getCurrentPosition().then((value) {
      setState(() {
        position = (value / 60000).toStringAsFixed(2);
      });
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Audio Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Status : $status',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Position : $position',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'Duration : $duration',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: pause,
            tooltip: 'Pause',
            child: const Icon(Icons.pause),
          ),
          FloatingActionButton(
            onPressed: play,
            tooltip: 'Play',
            child: const Icon(Icons.play_arrow),
          ),
          FloatingActionButton(
            onPressed: stop,
            tooltip: 'Stop',
            child: const Icon(Icons.stop),
          ),
        ],
      ),
    );
  }
}
