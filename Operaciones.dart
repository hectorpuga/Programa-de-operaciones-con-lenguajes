class Operaciones {
  Map<String, List<String>> lenguajes;
  Map<String, List<String>> copiaLenguajes;

  Operaciones(this.lenguajes, this.copiaLenguajes);

  TipOperaciones(String op, String a, {String d = ''}) {
    List<String> copiaA = [...lenguajes[a]!];
    List<String> copiaB = [...lenguajes[d]!];

    switch (op) {
      case 'U':
        return UnionOperacion(copiaA, copiaB);

      case '°':
        return InterseccionOperacion(copiaA, copiaB);

      case '-':
        return DiferenciaOperacion(copiaA, copiaB);
      case 'Δ':
        return DiferenciaSimetricaOperacion(copiaA, copiaB);

      case '~':
        return ComplementoOperacion(copiaLenguajes, copiaA);

      case '*':
        return ProductoOperacion(copiaA, copiaB);

      default:
        return <String>[];
    }
  }

  UnionOperacion(List<String> L1, List<String> L2) {
    List<String> Unica = [...L1, ...L2].toSet().toList();
    return Unica;
  }

  InterseccionOperacion(List<String> L1, List<String> L2) {
    List<String> interseccion = [];

    for (var i = 0; i < L1.length; i++) {
      for (var j = 0; j < L2.length; j++) {
        if (L1[i] == L2[j]) {
          interseccion.add(L1[i]);
        }
      }
    }

    return interseccion;
  }

  DiferenciaOperacion(List<String> L1, List<String> L2) {
    for (var i = 0; i < L2.length; i++) {
      L1.remove(L2[i]);
    }

    return L1;
  }

  DiferenciaSimetricaOperacion(List<String> L1, List<String> L2) {
    return <String>[
      ...DiferenciaOperacion([...L1], L2),
      ...DiferenciaOperacion([...L2], L1)
    ];
  }

  ComplementoOperacion(Map<String, List<String>> lenguajes, List<String> L1) {
    List<String> lenguajes = [];

    copiaLenguajes.forEach((key, value) {
      lenguajes.addAll(value);
    });

    lenguajes = lenguajes.toSet().toList();
    List complemento = DiferenciaOperacion(lenguajes, L1);

    return complemento;
  }

  ProductoOperacion(List<String> L1, List<String> L2) {
    List<String> producto = [];

    for (var i = 0; i < L1.length; i++) {
      for (var j = 0; j < L2.length; j++) {
        producto.add(L1[i] + L2[j]);
      }
    }

    return producto;
  }
}
