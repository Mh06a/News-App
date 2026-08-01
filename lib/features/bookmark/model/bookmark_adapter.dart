import 'package:hive/hive.dart';
import 'package:news_app/features/bookmark/model/bookmark_model.dart';

class BookmarkAdapter extends TypeAdapter<BookmarkModel> {
  @override
  final int typeId = 1; // stable id for BookmarkModel

  @override
  BookmarkModel read(BinaryReader reader) {
    final url = reader.readString();
    final author = reader.readString();
    final title = reader.readString();
    final description = reader.readString();
    final urlToImage = reader.readString();
    final publishedAt = reader.readString();
    final userId = reader.readString();

    return BookmarkModel(
      url: url,
      author: author,
      title: title,
      description: description,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      userId: userId,
    );
  }

  @override
  void write(BinaryWriter writer, BookmarkModel obj) {
    writer.writeString(obj.url);
    writer.writeString(obj.author);
    writer.writeString(obj.title);
    writer.writeString(obj.description);
    writer.writeString(obj.urlToImage);
    writer.writeString(obj.publishedAt);
    writer.writeString(obj.userId);
  }
}
