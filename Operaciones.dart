class Operaciones {
  Map<String, List<String>> lenguajes;
  Map<String, List<String>> copiaLenguajes;

  Operaciones(this.lenguajes, this.copiaLenguajes);

  tipOperaciones(String op, String a, {String d = ''}) {
    print(op);

    List<String> copiaA = [...lenguajes[a]!];

    List<String> copiaB = d != '' ? [...lenguajes[d]!] : <String>[];
    print(copiaA);
    switch (op) {
      case 'U':
        return unionOperacion(copiaA, copiaB);

      case '°':
        return interseccionOperacion(copiaA, copiaB);

      case '-':
        return diferenciaOperacion(copiaA, copiaB);
      case 'Δ':
        return diferenciaSimetricaOperacion(copiaA, copiaB);

      case '~':
        return complementoOperacion(copiaLenguajes, copiaA);

      case '*':
        return productoOperacion(copiaA, copiaB);
      case 'ε':
        return cerraduraDeKleene(copiaA, 3);
      case '|':
        return cerraduraPositiva(copiaA, 3);

      default:
        return <String>[];
    }
  }

  unionOperacion(List<String> L1, List<String> L2) =>
      <String>[...L1, ...L2].toSet().toList();

  interseccionOperacion(List<String> L1, List<String> L2) {
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

  diferenciaOperacion(List<String> L1, List<String> L2) {
    for (var i = 0; i < L2.length; i++) {
      L1.remove(L2[i]);
    }

    return L1;
  }

  diferenciaSimetricaOperacion(List<String> L1, List<String> L2) => <String>[
        ...diferenciaOperacion([...L1], L2),
        ...diferenciaOperacion([...L2], L1)
      ];

  complementoOperacion(Map<String, List<String>> lenguajes, List<String> L1) {
    List<String> lenguajes = [];

    copiaLenguajes.forEach((key, value) {
      lenguajes.addAll(value);
    });

    lenguajes = lenguajes.toSet().toList();
    List complemento = diferenciaOperacion(lenguajes, L1);

    return complemento;
  }

  productoOperacion(List<String> L1, List<String> L2) {
    List<String> producto = [];

    for (var i = 0; i < L1.length; i++) {
      for (var j = 0; j < L2.length; j++) {
        producto.add(L1[i] + L2[j]);
      }
    }

    return producto;
  }

  cerraduraDeKleene(List<String> L1, int ite) {
    List<String> erraduraKleene = ['ε'];
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
      erraduraKleene.addAll(resultado);
      resultadoTempora.clear();
    }
    print(erraduraKleene);
    return erraduraKleene;
  }

  cerraduraPositiva(List<String> L1, int ite) {
    List<String> cerraduraPositiva = [];
    List<String> resultado = [...L1];
    List<String> resultadoTempora = [];

    for (var i = 0; i < ite; i++) {
      for (var a = 0; a < L1.length; a++) {
        for (var b = 0; b < resultado.length; b++) {
          resultadoTempora.add(L1[a] + resultado[b]);
        }
      }

      resultado = [...resultadoTempora];
      cerraduraPositiva.addAll(resultado);
      resultadoTempora.clear();
    }
    print(cerraduraPositiva);
    return cerraduraPositiva;
  }
}
