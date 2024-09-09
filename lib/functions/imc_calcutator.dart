import 'dart:math';

(String, double) imcCalculator(double height, double weight) {
  //
  Map<double, String> tracks = {
    40: "Obesidade Grau III (mórbida)",
    35: 'Obesidade Grau II (severa)',
    30: 'Obesidade Grau I',
    25: 'Sobrepeso',
    18.5: 'Saudável',
    17: 'Magreza leve',
    16: 'Magreza moderada',
    0: "Magreza grave",
  };

  if (height == 0) {
    throw ArgumentError("The height must be greater than zero.");
  }
  //TODO: Verificar parâmetro máximos e mínimos pra altura e peso.

  double imcCalculated = weight / pow(height, 2);

  for (var imcValues in tracks.keys) {
    if (imcCalculated >= imcValues) {
      return (
      tracks[imcValues]!,
      double.parse(imcCalculated.toStringAsExponential(3)),
      );
    }
  }
  throw Exception("Error in imcCalculated");
}