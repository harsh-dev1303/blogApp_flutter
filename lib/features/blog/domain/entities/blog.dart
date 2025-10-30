// ignore_for_file: public_member_api_docs, sort_constructors_first
class Blog {
  final String id;
  final String poster_id;
  final String title;
  final String content;
  final String image_url;
  final List<String> topics;
  final DateTime updated_at;
  final String? poster_name;

  Blog({
    required this.id,
    required this.poster_id,
    required this.title,
    required this.content,
    required this.image_url,
    required this.topics,
    required this.updated_at,
    this.poster_name,
  });

  

  
}
