// features/quotes/data/models/quote_model.dart
import 'package:bookquotes/features/quotes/domain/entities/Quote.dart';

class QuoteModel extends Quote {
  const QuoteModel({
    super.id,
    required super.text,
    required super.author,
    required super.book,
  });

  // Factory constructor for creating QuoteModel from JSON
  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: _parseId(json['id']),
      text: json['text']?.toString() ?? '',
      author: json['author']?.toString() ?? 'Unknown Author',
      book: json['book_title']?.toString() ?? 
            json['book']?.toString() ?? 
            'Unknown Book',
    );
  }

  // Helper method to parse id from different types
  static int? _parseId(dynamic id) {
    if (id == null) return null;
    if (id is int) return id;
    if (id is String) return int.tryParse(id);
    return null;
  }

  // Convert QuoteModel to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'text': text,
      'author': author,
      'book_title': book, // Map to book_title for Spring Boot API
    };
  }

  // Convert QuoteModel to a Map for local storage
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'text': text,
      'author': author,
      'book': book,
    };
  }

  // Factory constructor for creating QuoteModel from Map (for local storage)
  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      id: _parseId(map['id']),
      text: map['text']?.toString() ?? '',
      author: map['author']?.toString() ?? 'Unknown Author',
      book: map['book']?.toString() ?? 'Unknown Book',
    );
  }

  // Copy with method for immutable updates
  QuoteModel copyWith({
    int? id,
    String? text,
    String? author,
    String? book,
  }) {
    return QuoteModel(
      id: id ?? this.id,
      text: text ?? this.text,
      author: author ?? this.author,
      book: book ?? this.book,
    );
  }

  // Convert to entity (though QuoteModel extends Quote, this is for clarity)
  Quote toEntity() {
    return Quote(
      id: id,
      text: text,
      author: author,
      book: book,
    );
  }

  // Override toString for debugging
  @override
  String toString() {
    return 'QuoteModel(id: $id, text: $text, author: $author, book: $book)';
  }

  // Override equality (inherited from Quote via Equatable)
  @override
  List<Object?> get props => [id, text, author, book];
}