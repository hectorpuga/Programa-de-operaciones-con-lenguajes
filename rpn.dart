import 'dart:collection';
import 'dart:math';

import 'main.dart';
import 'stack.dart';

class RPN {
  Queue<String> prefija;
  Stack<String> pila = Stack();

  RPN(this.prefija);

  String rpn() {
    String eleDer, eleIzq;

    for (var token in prefija) {
      if (RegExp('[U,n,-,Δ,c,*]').hasMatch(token)) {
        eleDer = pila.pop();

        eleIzq = pila.pop();
      } else {
        pila.push(token);
      }
    }

    return pila.pop();
  }
}
