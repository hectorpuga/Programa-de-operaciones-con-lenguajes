void main() {
  cerraduraDeKleene(['5', '6', '7', '8', 'a', 'b'], 3);
}

cerraduraDeKleene(List<String> L1, int ite) {
  List<String> cerraduraKleene = ['ε'];
  List<String> resultado = ['ε'];
  List<String> resultadoTempora = [];

  for (var i = 0; i < ite; i++) {
    for (var a = 0; a < L1.length; a++) {
      for (var b = 0; b < resultado.length; b++) {
        resultadoTempora
            .add(resultado[b] != 'ε' ? L1[a] + resultado[b] : L1[a]);
      }
    }

    resultado = [...resultadoTempora];
    cerraduraKleene.addAll(resultado);
    resultadoTempora.clear();
  }
  print(cerraduraKleene);
  return cerraduraKleene;
}
