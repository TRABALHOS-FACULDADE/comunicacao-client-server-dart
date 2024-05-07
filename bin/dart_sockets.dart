import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dart_sockets/print_color.dart';

import 'poll.dart';

void main(List<String> args) async {
  final roomName = args.first;
  final port = poll.sessions.firstWhere((e) => e.name == roomName).port;
  final server = await ServerSocket.bind(InternetAddress.anyIPv4.address, port);
  try {
    printColor('Server running on port: $port', Color.magenta);
    server.listen(handle);
  } catch (e) {
    await server.close();
  }
}

List<Socket> clients = [];
List<Map<String, dynamic>> finishingPlayers = [];

void handle(Socket client) {
  printColor(
      "Endereço conectado: ${client.remoteAddress.address}${client.port}",
      Color.green);

  bool listenedLoggedMessage = false;

  client.listen((Uint8List data) {
    final message = String.fromCharCodes(data);

    if (!listenedLoggedMessage) {
      clients.add(client);
      client.write("Você está logado(a) como: $message");
      printColor(message, Color.yellow);
      listenedLoggedMessage = true;
    } else {
      final infos = jsonDecode(message) as Map<String, dynamic>;
      finishingPlayers.add(infos);
      // Mensagem de finalização
      printColor(
          '${infos['personaName']} finalizou o quiz da sessão de ${infos['sessionName']} com ${infos['points']} pontos!',
          Color.blue);
    }
    if (finishingPlayers.isNotEmpty) {
      if (finishingPlayers.length == clients.length) {
        printColor('\nPontuação geral:\n', Color.red);
        finishingPlayers
            .sort((b, a) => (a['points'] as int).compareTo(b['points']));
        for (final player in finishingPlayers) {
          printColor('${player['personaName']}: ${player['points']} pontos',
              Color.cyan);
        }
      }
    }
  }, onDone: () {
    printColor("${client.remoteAddress.address}${client.port} saiu da sala!",
        Color.red);
  });
}
