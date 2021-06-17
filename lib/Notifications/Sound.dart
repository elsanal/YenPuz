import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class Sound{

  Soundpool soundpool = Soundpool.fromOptions(
      options: SoundpoolOptions(streamType: StreamType.ring));
  Future<int> soundId;
  int soundStreamId = 0;

    Sound({required this.soundId,required this.soundpool});


  Future<void> playSound() async {
    var sound = await soundId;
    soundStreamId = await soundpool.play(sound);
  }

  Future<void> updateVolume(newVolume) async{
    var sound = await soundId;
    soundpool.setVolume(soundId: sound, volume: newVolume);
  }

}