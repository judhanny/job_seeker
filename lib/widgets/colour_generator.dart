import 'dart:math';
import 'dart:ui';

import 'package:job_seeker/widgets/custom_colours.dart';

class ColourGenerator{

  Random random = Random();

  Color getRandomColour(){
      return Color.fromARGB(random.nextInt(300), random.nextInt(300),
          random.nextInt(300), random.nextInt(300));
  }

  Color getPastelColour(){
    return CustomColours.PASTELS[random.nextInt(CustomColours.PASTELS.length)];
  }

  Color getPastelColourForKey(String key){
    int value = key.hashCode % CustomColours.PASTELS.length;
    return CustomColours.PASTELS[value];
  }

  Color darken(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 50);
    var f = 1 - percent / 100;
    return Color.fromARGB(
        c.alpha,
        (c.red * f).round(),
        (c.green  * f).round(),
        (c.blue * f).round()
    );
  }

  Color lighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 50);
    var p = percent / 100;
    return Color.fromARGB(
        c.alpha,
        c.red + ((255 - c.red) * p).round(),
        c.green + ((255 - c.green) * p).round(),
        c.blue + ((255 - c.blue) * p).round()
    );
  }

}