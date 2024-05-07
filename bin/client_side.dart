import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dart_sockets/print_color.dart';

import 'person.dart';
import 'poll.dart';

void main(List<String> args) async {
  final roomName = args.first;

  late Person person;
  String? username;
  final session = poll.sessions.firstWhere((e) => e.name == roomName);
  final socket = await Socket.connect('127.0.0.1', session.port);
  printColor('Conectou ao endereço: ${socket.address.address}:${socket.port}',
      Color.green);

  int pontos = 0;
  bool alreadyShowedPoints = false;

  do {
    printColor(
        "<Room: ${session.name}> Por favor, informe seu nome de usuário:",
        Color.green);
    username = stdin.readLineSync();
  } while (username == null || username.isEmpty);

  person = Person(name: username);
  socket.write("<Room: ${session.name}> ${person.name} entrou na sala!");

  socket.listen((Uint8List data) async {
    if (username != null) {
      for (final pergunta in session.questions) {
        if (pergunta.answered) continue;
        printColor(pergunta.question, Color.yellow);
        final resp = stdin.readLineSync();
        if (resp != null && resp.isNotEmpty) {
          pergunta.answered = true;
          pontos +=
              (resp.toLowerCase() == pergunta.answer.toLowerCase()) ? 1 : -1;
        }
      }
      if (session.questions.every((e) => e.answered)) {
        if (!alreadyShowedPoints) {
          socket.write(jsonEncode({
            'personaName': person.name,
            'points': pontos,
            'sessionName': session.name
          }));
          alreadyShowedPoints = true;
        }
      }
    }
  }, onDone: () {
    printColor('A sala foi fechada!', Color.red);
  });
}
