import 'dart:collection';
import 'dart:io';

import 'algoritmo_shunting_yard.dart';
import 'stack.dart';

main() {
  OperationLenguajes op = OperationLenguajes();
  op.InputData();
}

class OperationLenguajes {
  List<String> Signo = ['U', 'n', '-', 'Δ', 'c', '.'];
  String? alfabeto;
  int? a;
  Map<String, List<String>> lenguajes = {};
  Map<String, List> Resultado = {};
  List<String> OperacionesLargas = [];

  OperationLenguajes() {}
  void InputData() {
    stdout.writeln('Ingrese los simbolos del alfabeto');
    alfabeto = stdin.readLineSync() ?? 'no alfabeto';
    alfabeto!.replaceAll(',', '');

    stdout.writeln('Cantidad de lenguajes para este ejercicio');
    a = int.parse(stdin.readLineSync() ?? '0');

    for (var i = 0; i < a!; i++) {
      stdout.writeln('Ingrese Lenguaje ${i + 1}');
      String LG = stdin.readLineSync() ?? 'no lenguajes';

      List<String> ArregloLg = LG.split(',');

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

    List<String> A = [];
    for (var i = 0; i < Operacion.length; i++) {
      if (Operacion.substring(i, i + 1) == 'L') {
        String L = Operacion.substring(i, i + 2);
        i = i + 1;
        A.add(L);
      } else {
        A.add(Operacion.substring(i, i + 1));
      }
    }

    final f = ShuntingYard(A);
    print(f.prefi);

    prefija = f.prefi;

    print(rpn());

//Δ
  }

//
//
  //  (L1U(L2UL3))Δ(L2n(L2*(L3*L2)))
  //]

  Operaciones(String op, String a, String d) {
    switch (op) {
      case 'U':
        return UnionOperacion(lenguajes[a]!, lenguajes[d]!).split('');

      case 'n':
        return InterseccionOperacion(lenguajes[a]!, lenguajes[d]!).split('');

      case '-':
        return DiferenciaOperacion(lenguajes[a]!, lenguajes[d]!).split('');
      case 'Δ':
        return DiferenciaSimetricaOperacion(lenguajes[a]!, lenguajes[d]!)
            .split('');

      case 'c':
        return ComplementoOperacion(lenguajes, lenguajes[a]!).split('');

      case '*':
        return ProductoOperacion(lenguajes[a]!, lenguajes[a]!).split('');

      default:
    }

    return <String>[];
  }

  String UnionOperacion(List<String> L1, List<String> L2) {
    List<String> Unica = [...L1, ...L2].toSet().toList();

    return Unica.join();
  }

  String InterseccionOperacion(List L1, List L2) {
    List<String> f = [];
    for (var i = 0; i < L1.length; i++) {
      for (var j = 0; j < L2.length; j++) {
        if (L1[i] == L2[j]) {
          f.add(L1[i]);
        }
      }
    }

    return f.join();
  }

  String DiferenciaOperacion(List<String> L1, List<String> L2) {
    for (var i = 0; i < L2.length; i++) {
      L1.remove(L2[i]);
    }

    return L1.join();
  }

  String DiferenciaSimetricaOperacion(List<String> L1, List<String> L2) {
    List<String> f = [...L1];

    for (var i = 0; i < L2.length; i++) {
      L1.remove(L2[i]);
    }

    for (var i = 0; i < f.length; i++) {
      L2.remove(f[i]);
    }
    f = [...L1, ...L2];

    return f.join();
  }

  String ComplementoOperacion(
      Map<String, List<String>> lenguajes, List<String> L1) {
    List<String> f = [];

    lenguajes.forEach((key, value) {
      f.addAll(value);
    });

    f = f.toSet().toList();

    f = DiferenciaOperacion(f, L1).split('');

    return f.join();
  }

  String ProductoOperacion(List<String> L1, List<String> L2) {
    List<String> f = [];

    for (var i = 0; i < L1.length; i++) {
      for (var j = 0; j < L2.length; j++) {
        f.add(L1[i] + L2[j]);
      }
    }

    return f.join();
  }

  Queue<String>? prefija;
  Stack<String> pila = Stack();

  String rpn() {
    String eleDer, eleIzq;

    for (var token in prefija!) {
      if (RegExp('[U,n,-,Δ,c,*]').hasMatch(token)) {
        eleDer = pila.pop();
        eleIzq = pila.pop();

        String r = '$eleIzq$token$eleDer';
        lenguajes['$eleIzq$token$eleDer'] =
            Operaciones('$token', '$eleIzq', '$eleDer');

        print(r);

        pila.push(r);
      } else {
        pila.push(token);
      }
    }

    return lenguajes[pila.pop()].toString();
  }
}
