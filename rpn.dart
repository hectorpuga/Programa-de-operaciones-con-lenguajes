import 'dart:collection';

import 'Operaciones.dart';
import 'stack.dart';

class RPN {
  Queue<String>? prefija;
  Stack<String> pila = Stack();
  Map<String, List<String>> lenguajes = {};

  RPN(this.prefija, this.lenguajes);

  List<String>? rpn() {
    Operaciones operaciones = Operaciones(lenguajes, {...lenguajes});
    String eleDer = '', eleIzq;

    for (var token in prefija!) {
      if (RegExp('[U°Δ~*]').hasMatch(token) || token == '-') {
        if (token != '~') {
          eleDer = pila.pop();
        }
        eleIzq = pila.pop();

        String r = '$eleIzq$token$eleDer';
        lenguajes['$eleIzq$token$eleDer'] =
            operaciones.TipOperaciones('$token', '$eleIzq', d: '$eleDer');
        print('---------------------------------------------------');
        print('$eleIzq$token$eleDer' +
            ': ' +
            '${lenguajes['$eleIzq$token$eleDer']}');

        pila.push(r);
      } else {
        pila.push(token);
      }
    }

    return lenguajes[pila.pop()];
  }
}
