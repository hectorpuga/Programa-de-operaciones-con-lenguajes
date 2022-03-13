class Operaciones {
  Map<String, List<String>> lenguajes = {};
  Map<String, List<String>> copiaLenguajes = {};

  Operaciones(this.lenguajes, this.copiaLenguajes);

  TipOperaciones(String op, String a, {String d = ''}) {
    switch (op) {
      case 'U':
        return UnionOperacion(lenguajes[a]!, lenguajes[d]!);

      case '°':
        return InterseccionOperacion(lenguajes[a]!, lenguajes[d]!);

      case '-':
        return DiferenciaOperacion(lenguajes[a]!, lenguajes[d]!);
      case 'Δ':
        return DiferenciaSimetricaOperacion(lenguajes[a]!, lenguajes[d]!);

      case '~':
        return ComplementoOperacion(copiaLenguajes, lenguajes[a]!);

      case '*':
        return ProductoOperacion(lenguajes[a]!, lenguajes[d]!);

      default:
    }

    return <String>[];
  }

  UnionOperacion(List<String> L1, List<String> L2) {
    List<String> Unica = [...L1, ...L2].toSet().toList();
    return Unica;
  }

  InterseccionOperacion(List<String> L1, List<String> L2) {
    List<String> f = [];

    for (var i = 0; i < L1.length; i++) {
      for (var j = 0; j < L2.length; j++) {
        if (L1[i] == L2[j]) {
          f.add(L1[i]);
        }
      }
    }

    return f;
  }

  DiferenciaOperacion(List<String> L1, List<String> L2) {
    List<String> a = [...L1];

    for (var i = 0; i < L2.length; i++) {
      a.remove(L2[i]);
    }

    return a;
  }

  DiferenciaSimetricaOperacion(List<String> L1, List<String> L2) {
    List<String> f = [];

    List<String> a = [...L1];
    List<String> b = [...L2];

    List<String> L1Copia = [...L1];
    List<String> L2Copia = [...L2];
    for (var i = 0; i < b.length; i++) {
      L1Copia.remove(b[i]);
    }

    for (var i = 0; i < a.length; i++) {
      L2Copia.remove(a[i]);
    }
    f = [...L1Copia, ...L2Copia];

    return f;
  }

  ComplementoOperacion(Map<String, List<String>> lenguajes, List<String> L1) {
    List<String> f = [];

    copiaLenguajes.forEach((key, value) {
      f.addAll(value);
    });

    f = f.toSet().toList();
    List s = DiferenciaOperacion(f, L1);

    return s;
  }

  ProductoOperacion(List<String> L1, List<String> L2) {
    List<String> f = [];

    for (var i = 0; i < L1.length; i++) {
      for (var j = 0; j < L2.length; j++) {
        f.add(L1[i] + L2[j]);
      }
    }

    return f;
  }
}
