import 'dart:collection';

import 'stack.dart';

class ShuntingYard {
  List Operacion = [];
  Queue<String> prefija = Queue();

  ShuntingYard(List Operacion) {
    this.Operacion = Operacion;
    shuntigYard();
  }

  void shuntigYard() {
    int contador = 0;
    Stack<String> pila = Stack();
    for (var i = 0; i < Operacion.length; i++) {
      if (RegExp('^[L/\d]+').hasMatch(Operacion[i])) {
        prefija.add(Operacion[i]);
      } else if (Operacion[i] == '(') {
        pila.push(Operacion[i]);

        contador++;
      } else if (RegExp('[U°Δ~\*]').hasMatch(Operacion[i]) ||
          Operacion[i] == '-') {
        if (!pila.isEmpty) {
          if (compararPresedencia(Operacion[i], pila.peek)) {
            prefija.add(pila.pop());
            pila.push(Operacion[i]);
          } else {
            pila.push(Operacion[i]);
          }
        } else {
          pila.push(Operacion[i]);
        }
      } else if (Operacion[i] == ')') {
        contador--;

        if (!pila.isEmpty) {
          while (true) {
            if (!pila.isEmpty) {
              if (!(pila.peek == '(')) {
                prefija.add(pila.pop());
              } else {
                pila.pop();
                break;
              }
            } else {
              break;
            }
          }
        } else {
          print('comprobación de si no hay cierre de parentesis');
        }
      }
      if (contador < 0) {
        // exepccion de 0
      }
    }
    while (!pila.isEmpty) {
      if (!(pila.peek == '(')) {
        prefija.add(pila.pop());
      } else {
        //exepcion de parentesis de apertura sobrante
      }
    }
  }

  int darPresedencia(String op) {
    switch (op) {
      case "Δ":
        return 4;

      case "°":
      case "~":
      case "*":
        return 2;

      case "-":
      case "U":
        return 1;

      default:
        return 0;
    }
  }

  bool compararPresedencia(String opExp, String opTopPila) =>
      darPresedencia(opExp) < darPresendicaPila(opTopPila);

  int darPresendicaPila(String op) {
    switch (op) {
      case "Δ":
        return 3;
      case "°":
      case "~":
      case "*":
        return 2;

      case "-":
      case "U":
        return 1;

      default:
        return 0;
    }
  }

  Queue<String> get prefi => prefija;
}
