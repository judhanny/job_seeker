import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:job_seeker/models/job_application.dart';
import 'package:path_provider/path_provider.dart';


class LocalFilePersistence {

  static const FILE_MAIN_DIRECTORY= "job_applications";
  static const FILE_POSTFIX= ".txt";

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

  Future<String> getFilename(String finalFileName) async {
    return FILE_MAIN_DIRECTORY + '/' + finalFileName + FILE_POSTFIX;
  }

  void saveObject(Map<String, dynamic> object, String finalFileName) async {
    final String filename = await getFilename(finalFileName);
    final File file = await _localFile(filename);

    if (!await file.parent.exists()) await file.parent.create(recursive: true);

    final String jsonString = JsonEncoder().convert(object);
    await file.writeAsString(jsonString);
  }

  void saveApplicationList(List<JobApplication> applications, String finalFileName) async {
    final String filename = await getFilename(finalFileName);
    final File file = await _localFile(filename);

    if (!await file.parent.exists()) await file.parent.create(recursive: true);

    final String jsonString = jsonEncode(applications);
    await file.writeAsString(jsonString);
  }


  Future<List<JobApplication>> readApplicationList(String filenamePostfix) async {
    final String filename = await getFilename(filenamePostfix);
    final file = await _localFile(filename);
    List<JobApplication> list = [];

    if (await file.exists()) {
      final objectString = await file.readAsString();

      list=(json.decode(objectString) as List).map((i) =>
          JobApplication.fromJson(i)).toList();
    }

    return list;
  }

  void saveString(String value, String filenamePostfix) async {
    final String filename = await getFilename(filenamePostfix);
    final File file = await _localFile(filename);

    if (!await file.parent.exists()) await file.parent.create(recursive: true);

    await file.writeAsString(value);
  }

  Future<Map<String, dynamic>> getObject(String filenamePostfix) async {
    final String filename = await getFilename(filenamePostfix);
    final file = await _localFile(filename);

    if (await file.exists()) {
      final objectString = await file.readAsString();
      return JsonDecoder().convert(objectString);
    }

    Map<String,dynamic> empty = new HashMap();
    return empty;
  }

}