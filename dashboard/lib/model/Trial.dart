import 'package:dashboard/model/cellulo.dart';

class Trial {
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

  Trial();
}
