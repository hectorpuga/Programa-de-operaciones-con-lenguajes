import 'dart:io';
import 'algoritmo_shunting_yard.dart';
import 'rpn.dart';

main() {
  OperationLenguajes op = OperationLenguajes();
  op.InputData();
}

class OperationLenguajes {
  String? alfabeto;
  int? a;
  Map<String, List<String>> lenguajes = {};
  Map<String, List<String>> copiaLenguajes = {};

  OperationLenguajes() {}
  void InputData() {
    stdout.writeln('Ingrese los simbolos del alfabeto');
    alfabeto = stdin.readLineSync() ?? 'no alfabeto';
    alfabeto!.replaceAll(',', '');
    String alfabeto2 = '';

    for (var i = 0; i < alfabeto!.length; i++) {
      if (alfabeto!.substring(i, i + 1) == '/') {
        alfabeto2 += '\/';
      } else {
        alfabeto2 += alfabeto!.substring(i, i + 1);
      }
    }

    alfabeto = alfabeto2;

    stdout.writeln('Cantidad de lenguajes para este ejercicio');
    a = int.parse(stdin.readLineSync() ?? '0');

    for (var i = 0; i < a!; i++) {
      stdout.writeln('Ingrese Lenguaje ${i + 1}');
      String LG = stdin.readLineSync() ?? 'no lenguajes';

      List<String> ArregloLg = LG.split(',');

      if (EvaluacionLenguaje(ArregloLg)) {
        print(EvaluacionLenguaje(LG.split(',')));
        lenguajes['L${i + 1}'] = ArregloLg;
        copiaLenguajes['L${i + 1}'] = ArregloLg;
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
    final rpn = RPN(f.prefi, lenguajes, copiaLenguajes);
    rpn.rpn();
//Δ
  }

//
//
  //  (L1U(L2UL3))Δ(L2n(L2*(L3*L2)))
  //]

}
