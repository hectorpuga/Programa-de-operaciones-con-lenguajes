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

    for (var token in prefija!) {
      String eleDer = '', eleIzq = '';

      if (RegExp('[U°Δ~*ε]').hasMatch(token) || token == '-' || token == 'e') {
        if (token != '~' && token != 'ε' && token != 'e') {
          eleDer = pila.pop();
        }

        eleIzq = pila.pop();

        String operacion = '$eleIzq$token$eleDer';

        lenguajes['$eleIzq$token$eleDer'] =
            operaciones.tipOperaciones('$token', '$eleIzq', d: '$eleDer');
        print('---------------------------------------------------');
        print('$eleIzq$token$eleDer' +
            ': ' +
            '${lenguajes['$eleIzq$token$eleDer']}');

        pila.push(operacion);
      } else {
        pila.push(token);
      }
    }

    return lenguajes[pila.pop()];
  }
}
