String? validateDouble({
  required String? value,
  double? limLower,
  double? limUpper,
}) {
  if((limLower!=null && limUpper!= null) && (limLower>limUpper)){
    throw ArgumentError("Limite inferior deve ser menor que o superior");
  }
  var num = double.tryParse(value!);
  //
  if (num == null) {
    return "Deve ser um número.";
  }
  //
  if (limLower != null && (num < limLower)) {
    return "Um número >= $limLower";
  }
  //
  if (limUpper != null && (num > limUpper)) {
    return "Um número <= $limUpper";
  }

  return null;
}
