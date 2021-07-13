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

}