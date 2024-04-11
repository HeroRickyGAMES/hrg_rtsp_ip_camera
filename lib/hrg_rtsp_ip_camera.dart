import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

//Desenvolvido por HeroRickyGames

class VideoStreamRTSP extends StatefulWidget {

  final String user;
  final String password;
  final String ip;
  final int porta;
  final int canal;
  const VideoStreamRTSP(this.user, this.password, this.ip, this.porta, this.canal, {super.key});

  @override
  State<VideoStreamRTSP> createState() => _VideoStreamRTSPState();
}

class _VideoStreamRTSPState extends State<VideoStreamRTSP> {
  late final player = Player();
  late final controller = VideoController(player);

  @override
  void initState() {
    MediaKit.ensureInitialized();
    super.initState();
  }

  openPlayer(){
    player.open(Media('rtsp://${widget.user}:${widget.password}@${widget.ip}:${widget.porta}/cam/realmonitor?channel=${widget.canal}&subtype=1'));
  }


  @override
  void dispose() {
    player.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    openPlayer();

    return LayoutBuilder(builder: (context, constrains){
      return Center(
        child: Stack(
          children: [
            SizedBox(
                height: 150,
                width: constrains.maxWidth,
                child: Video(
                    controller: controller,
                    controls: null
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: (){
                  dispose();
                },
                  icon: const Icon(Icons.close),
                )
              ],
            ),
          ],
        ),
      );
    }
    );
  }
}