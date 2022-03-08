import 'dart:io';

main() {
  OperationLenguajes();
}

class OperationLenguajes {
  List Signo = ['U', 'n', '-', 'Δ', 'c', '.'];
  String? alfabeto;
  int? a;
  Map<String, List> lenguajes = {};
  Map<String, List> Resultado = {};
  List<String> OperacionesLargas = [];

  OperationLenguajes() {
    InputData();
  }
  void InputData() {
    stdout.writeln('Ingrese los simbolos del alfabeto');
    alfabeto = stdin.readLineSync() ?? 'no alfabeto';
    alfabeto!.replaceAll(',', '');

    stdout.writeln('Cantidad de lenguajes para este ejercicio');
    a = int.parse(stdin.readLineSync() ?? '0');

    for (var i = 0; i < a!; i++) {
      stdout.writeln('Ingrese Lenguaje ${i + 1}');
      String LG = stdin.readLineSync() ?? 'no lenguajes';

      List ArregloLg = LG.split(',');

      if (EvaluacionLenguaje(ArregloLg)) {
        print(EvaluacionLenguaje(LG.split(',')));
        lenguajes['L${i + 1}'] = ArregloLg;
        print(lenguajes);
      } else {
        print('Error en el alfabeto del lenguaje');
        return;
      }
    }

    DetectorOperaciones(lenguajes);
  }

  bool EvaluacionLenguaje(List Lenguaje) {
    for (var c = 0; c < Lenguaje.length; c++) {
      RegExp regExp = RegExp('^[$alfabeto]+\$');

      if (!regExp.hasMatch(Lenguaje[c])) {
        return false;
      }
    }
    return true;
  }

  DetectorOperaciones(Map Lenguajes) {
    stdout.writeln('Ingrese operación');

    String Operacion = stdin.readLineSync() ?? 'no lenguajes';

    List A = Operacion.split('');

//Δ
  }

  LeerOperacionesSimples(String operacion) {
    for (var i = 0; i < operacion.length; i++) {
      for (var j = 0; j < Signo.length; j++) {
        if (operacion.substring(i, i + 1) == Signo[j]) {
          String Anterior = operacion.substring(i - 2, i);
          String Siguiente = operacion.substring(i + 1, i + 3);
          // print(Anterior);
          //print(Siguiente);
          //print(Signo[j]);
          Resultado[operacion] = Operaciones(Signo[j], Anterior, Siguiente);
        }
      }
    }
  }

  Operaciones(String op, String a, String d) {
    switch (op) {
      case 'U':
        return UnionOperacion(lenguajes[a]!, lenguajes[d]!);

      case 'n':
        return InterseccionOperacion(lenguajes[a]!, lenguajes[d]!);

      case '-':
        return DiferenciaOperacion(lenguajes[a]!, lenguajes[d]!);
      case 'Δ':
        return DiferenciaSimetricaOperacion(lenguajes[a]!, lenguajes[d]!);

      case 'c':
        return ComplementoOperacion(lenguajes, lenguajes[a]!);

      case '.':
        return ProductoOperacion(lenguajes[a]!, lenguajes[a]!);

      default:
    }

    return [];
  }

  List UnionOperacion(List L1, List L2) {
    List Unica = [...L1, ...L2].toSet().toList();

    return Unica;
  }

  List InterseccionOperacion(List L1, List L2) {
    List f = [];
    for (var i = 0; i < L1.length; i++) {
      for (var j = 0; j < L2.length; j++) {
        if (L1[i] == L2[j]) {
          f.add(L1[i]);
        }
      }
    }

    return f;
  }

  List DiferenciaOperacion(List L1, List L2) {
    for (var i = 0; i < L2.length; i++) {
      L1.remove(L2[i]);
    }

    return L1;
  }

  List DiferenciaSimetricaOperacion(List L1, List L2) {
    List f = [...L1];

    for (var i = 0; i < L2.length; i++) {
      L1.remove(L2[i]);
    }

    for (var i = 0; i < f.length; i++) {
      L2.remove(f[i]);
    }
    f = [...L1, ...L2];

    return f;
  }

  List ComplementoOperacion(Map<String, List> lenguajes, List L1) {
    List f = [];

    lenguajes.forEach((key, value) {
      f.addAll(value);
    });

    f = f.toSet().toList();

    f = DiferenciaOperacion(f, L1);

    return f;
  }

  List ProductoOperacion(List L1, List L2) {
    List f = [];

    for (var i = 0; i < L1.length; i++) {
      for (var j = 0; j < L2.length; j++) {
        f.add(L1[i] + L2[j]);
      }
    }

    return f;
  }
}
