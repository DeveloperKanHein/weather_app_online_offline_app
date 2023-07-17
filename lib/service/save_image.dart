import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';


Future<String> saveImage(imageLink) async
{
  final link = Uri.parse("http:$imageLink");
  var response = await http.get(link);
  Directory documentDirectory = await getApplicationDocumentsDirectory();
  var uuid = const Uuid();
  String rename = uuid.v1();
  File file = File(join(documentDirectory.path, '$rename.png'));
  file.writeAsBytesSync(response.bodyBytes);
  return file.path;
}