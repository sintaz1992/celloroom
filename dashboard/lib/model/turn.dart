import 'package:dashboard/model/cellulo.dart';
import 'package:dashboard/model/Trial.dart';
class Turn {
  int progress = -1;
  String id;
//  String _title;
  // String _description;
  int numAttempts = 0;
  int elapsedTime = 0;
  var mistakes = {
    "slope": 0,
    "initialPoint": 0,
    "intercept": 0,
  };
  Cellulo cellulox = new Cellulo();
  Cellulo celluloy = new Cellulo();
  Cellulo cellulov = new Cellulo();
  List<double> velocity = [0.0, 0.0];
  double error = 0;
  bool isBluereached = false;
  bool isRedreached = false;
  bool isPurplereached = false;
  List<Trial> trials = [new Trial(), new Trial(), new Trial(), new Trial(), new Trial(), new Trial()];
  var mapHit = {
    'Circles': [0, 0, 0, 0, 0, 0, 0, 0],
    'Rectangles': [0, 0, 0, 0, 0, 0, 0],
    'Polygons': [0, 0, 0, 0, 0, 0, 0],
  };

  Turn();
}
