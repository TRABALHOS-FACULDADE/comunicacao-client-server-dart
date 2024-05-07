import 'package:dart_sockets/poll_model.dart';
import 'package:dart_sockets/question.dart';
import 'package:dart_sockets/session.dart';

final poll = Poll(
  sessions: [
    Session(
      port: 3000,
      name: 'Filmes',
      questions: [
        Question(
          question: 'Qual filme ganhou mais oscars?',
          answer: 'Titanic',
          answered: false,
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
          answered: false,
        ),
        Question(
          question:
              'Qual o nome do jogo de Pokémon onde o inicial é APENAS o Pikachu?',
          answer: 'Yellow',
          answered: false,
        ),
        Question(
          question:
              'Qual é o verdadeiro nome do personagem de roupa verde nos jogos da série "Zelda"?',
          answer: 'Link',
          answered: false,
        ),
        Question(
          question: 'Qual console a Microsoft lançou no ano de 2013?',
          answer: 'XBOX ONE',
          answered: false,
        ),
      ],
    ),
  ],
);
