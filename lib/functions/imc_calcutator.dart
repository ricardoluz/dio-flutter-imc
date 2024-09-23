import 'dart:math';

(String, double) bmiCalculator(double height, double weight) {
  if (height == 0) {
    throw ArgumentError("The height must be greater than zero.");
  }
  //TODO: Verificar parâmetro máximos e mínimos pra altura e peso.

  double bmiCalculated = weight / pow(height, 2);

  return (
    bmiDescription(bmiCalculated)!,
    double.parse(bmiCalculated.toStringAsExponential(3))
  );
}

String bmiDescription(double bmiValue) {
  final Map<double, String> tracks = <double, String>{
    40: "Obesidade Grau III (mórbida)",
    35: 'Obesidade Grau II (severa)',
    30: 'Obesidade Grau I',
    25: 'Sobrepeso',
    18.5: 'Saudável',
    17: 'Magreza leve',
    16: 'Magreza moderada',
    0: "Magreza grave",
  };
  if (bmiValue <= 0) {
    throw ArgumentError("The value must be greater than zero.");
  }
  String bmiDescription = "";
  for (var bmiBoundaryValue in tracks.keys) {
    if (bmiValue >= bmiBoundaryValue) {
      bmiDescription = tracks[bmiBoundaryValue]!;
      break;
    }
  }
  return (bmiDescription);
}