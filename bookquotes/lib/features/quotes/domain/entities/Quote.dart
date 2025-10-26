import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final int? id;
  final String text;
  final String author;
  final String book;


  const Quote({
    this.id,
    required this.text,
    required this.author,
    required this.book,
  });

  @override
  List<Object?> get props => [id, text, author, book];
}
