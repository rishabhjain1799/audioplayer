import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool play = false;
  IconData playbtn = Icons.play_arrow;

  AudioPlayer _player;
  AudioCache cache;

  Duration position = new Duration();
  Duration musiclength = new Duration();

  Widget slider()
  {
    return Container(
      width: 300,
      child: Slider.adaptive(
    activeColor: Colors.red[800],
    inactiveColor: Colors.grey[350],
    value: position.inSeconds.toDouble(),
    max: musiclength.inSeconds.toDouble(),
    onChanged: (value)
    {
      seekTosec(value.toInt());
    })
    );
  } 

  void seekTosec(int sec)
  {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  void initState()
  {
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.durationHandler = (d)
  {
    setState(() {
      musiclength = d;
    });

    _player.positionHandler = (p)
    {
      setState(() {
        position = p;
      });
    };
  };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient:LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red[800],
              Colors.red[200]
          ])
        ),

       child: Padding(padding: EdgeInsets.only(top: 48),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[

           Padding(
             padding: const EdgeInsets.only(left: 12.0),
             child: Text("Music App", style: TextStyle(
               color: Colors.white,
               fontSize: 36,
               fontWeight: FontWeight.bold
             ),
             ),
           ),

           Padding(
             padding: const EdgeInsets.only(left: 12.0),
             child: Text("Listen to your Favourite Music", style: TextStyle(
               color: Colors.white,
               fontSize: 20,
               fontWeight: FontWeight.w400
             ),
             ),
           ),

           SizedBox(
             height: 24,
           ),

           Center(
             child: Container(
               width: 300,
               height: 300,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(30),
                 image: DecorationImage(
                   image: AssetImage("assets/mw.jpeg")
                 )
               ),
             ),
           ),

           SizedBox(
             height: 18,
           ),

           Center(
             child: Text("Rain Over Me", style: TextStyle(
               color: Colors.white,
               fontSize: 32,
               fontWeight: FontWeight.w600
             ),
             ),
           ),

           SizedBox(
             height: 25,
           ),

           Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                    )
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 400,
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("${position.inMinutes}:${position.inSeconds.remainder(60)}"),
                            slider(),
                            Text("${musiclength.inMinutes}:${musiclength.inSeconds.remainder(60)}"),
                          ],
                        ),
                      ),
                      Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(iconSize: 40,
                          color: Colors.red,
                          icon: Icon(Icons.skip_previous), onPressed: () 
                          {
                            _player.pause();
                              setState(() {
                                playbtn = Icons.play_arrow;
                                play = false;
                              });
                            Navigator.pushNamed(context, "second");
                          }
                          ),

                          IconButton(iconSize: 65,
                          color: Colors.red,
                           onPressed: () 
                          {
                            if(!play)
                            {
                              cache.play("audio/Rain over me.mp3");
                              setState(() {
                                playbtn = Icons.pause;
                                play = true;
                              });
                            }
                            else
                            {
                              _player.pause();
                              setState(() {
                                playbtn = Icons.play_arrow;
                                play = false;
                              });
                            }
                          },
                          icon: Icon(
                            playbtn,
                          ),
                          ),

                          IconButton(iconSize: 40,
                          color: Colors.red,
                          icon: Icon(Icons.skip_next), onPressed: () 
                          {
                            _player.pause();
                              setState(() {
                                playbtn = Icons.play_arrow;
                                play = false;
                              });
                            Navigator.pushNamed(context, "second");
                          }
                          ),
                          
                        ],
                      ),
                    ],
                  ),
             ),
           )
         ],
       ),
       ), 
      ),
      );
  }
}
