import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dart_sockets/utils/print_color.dart';
import 'package:dart_sockets/utils/poll.dart';

void main(List<String> args) async {
  final roomName = args.first;
  final session = poll.getSessionByRoomName(roomName);

  if (session == null) {
    printColor('Sessão inexistente!', Color.red);
    return;
  }

  final server =
      await ServerSocket.bind(InternetAddress.anyIPv4.address, session.port);
  try {
    printColor('Servidor rodando na porta: ${session.port}', Color.magenta);
    server.listen(_handleClient);
  } catch (e) {
    await server.close();
  }
}

List<Socket> _clients = [];
List<Map<String, dynamic>> _finishingPlayers = [];

void _handleClient(Socket client) {
  printColor(
      "Endereço conectado: ${client.remoteAddress.address}${client.port}",
      Color.green);

  bool listenedLoggedMessage = false;

  client.listen((Uint8List data) {
    // Decodificação de bytes enviados pelo client
    final message = String.fromCharCodes(data);

    if (!listenedLoggedMessage) {
      _clients.add(client);
      client.write("Você está logado(a) como: $message");
      printColor(message, Color.yellow);
      listenedLoggedMessage = true;
    } else {
      // Mensagem de finalização
      final infos = jsonDecode(message) as Map<String, dynamic>;
      _finishingPlayers.add(infos);
      printColor(
          '${infos['personaName']} finalizou o quiz da sessão de ${infos['sessionName']} com ${infos['points']} pontos!',
          Color.blue);
    }
    if (_finishingPlayers.isNotEmpty) {
      if (_finishingPlayers.length == _clients.length) {
        printColor('\nPontuação geral:\n', Color.red);
        _finishingPlayers
            .sort((b, a) => (a['points'] as int).compareTo(b['points']));
        for (final player in _finishingPlayers) {
          printColor('${player['personaName']}: ${player['points']} pontos',
              Color.cyan);
        }
        _finishingPlayers.clear();
      }
    }
  }, onDone: () {
    printColor("${client.remoteAddress.address}${client.port} saiu da sala!",
        Color.red);
  });
}
