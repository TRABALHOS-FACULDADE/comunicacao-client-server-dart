import 'package:dart_sockets/models/poll_model.dart';
import 'package:dart_sockets/models/question.dart';
import 'package:dart_sockets/models/session.dart';

final poll = Poll(
  sessions: [
    Session(
      port: 3000,
      name: 'Filmes',
      questions: [
        Question(
          question: 'Qual filme ganhou mais oscars?',
          answer: 'Titanic',
        ),
        Question(
          question: 'Qual o nome de heroi do Steve Rogers?',
          answer: 'Capitão América',
        ),
        Question(
          question: 'Qual a verdadeira profissão de Peter Parker?',
          answer: 'Fotografo',
        ),
        Question(
          question: 'Quem criou os Vingadores?',
          answer: 'Stan Lee',
        ),
      ],
    ),
    Session(
      port: 4000,
      name: 'Jogos',
      questions: [
        Question(
          question: 'Quando lançou GTA V?',
          answer: '2013',
        ),
        Question(
          question:
              'Qual o nome do jogo de Pokémon onde o inicial é APENAS o Pikachu?',
          answer: 'Yellow',
        ),
        Question(
          question:
              'Qual é o verdadeiro nome do personagem de roupa verde nos jogos da série "Zelda"?',
          answer: 'Link',
        ),
        Question(
          question: 'Qual console a Microsoft lançou no ano de 2013?',
          answer: 'XBOX ONE',
        ),
      ],
    ),
  ],
);
