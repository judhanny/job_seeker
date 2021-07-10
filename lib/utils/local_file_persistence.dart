import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class LocalFilePersistence {

  static const FILE_NAME= "job_applications";

  static final LocalFilePersistence _instance = LocalFilePersistence._internal();

  factory LocalFilePersistence(){
    return _instance;
  }

  LocalFilePersistence._internal();

  Future<String> get _localPath async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String filename) async {
    final String path = await _localPath;
    return File('$path/$filename');
  }

  Future<String> getFilename(/*String userId, String type, String key*/) async {
    //return userId + '/' + type + '/' + key;
    return FILE_NAME;
  }

  void saveObject(Map<String, dynamic> object) async {
    //final filename = await getFilename(userId, 'objects', key);
    final String filename = await getFilename();
    final File file = await _localFile(filename);

    if (!await file.parent.exists()) await file.parent.create(recursive: true);

    final String jsonString = JsonEncoder().convert(object);
    await file.writeAsString(jsonString);
  }

  void saveString(String value) async {
    //final filename = await getFilename(userId, 'objects', key);
    final String filename = await getFilename();
    final File file = await _localFile(filename);

    if (!await file.parent.exists()) await file.parent.create(recursive: true);

    await file.writeAsString(value);
  }

}