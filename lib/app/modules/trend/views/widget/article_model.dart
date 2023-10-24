import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String id;
  final String title;
  final String body;
  final String category;
  final String imageUrl;
  final int views;
  final String author;

  const Article({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.imageUrl,
    required this.views,
    required this.author,
  });

  static List<Article> articles = [
    Article(
      id: '1',
      title: 'Serum Anti Kerutan Somethinc Retinol',
      body: 'Nullam sed augue a turpis bibendum cursus...',
      category: 'Skincare',
      imageUrl: 'lib/aset/product/serum1.png',
      views: 891293,
      author: 'Anna G. Wright',
    ),
    Article(
      id: '2',
      title: 'Niacinamide Anti Jerawat Cuy!',
      body: 'Nullam sed augue a turpis bibendum cursus...',
      category: 'Bodycare',
      imageUrl: 'lib/aset/product/2.webp',
      views: 1204,
      author: 'Tazkia Damayanti',
    ),
    Article(
      id: '3',
      title: 'Salmon DNA Salmon',
      body: 'Nullam sed augue a turpis bibendum cursus...',
      category: 'Skincare',
      imageUrl: 'lib/aset/product/SERUM.jpg',
      views: 1204,
      author: 'Tazkia Damayanti',
    ),
    // ... other articles
  ];

  @override
  List<Object?> get props =>
      [id, title, body, category, imageUrl, views, author];
}
