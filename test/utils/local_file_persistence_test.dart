import 'package:job_seeker/utils/local_file_persistence.dart';
import 'package:test/test.dart';

void main() {
  LocalFilePersistence persistence = LocalFilePersistence();
  test('test local file name getting', () async {
    String filename = await persistence.getFilename();
    expect(filename, LocalFilePersistence.FILE_NAME);
  });

  test('test is singleton', () async {
    LocalFilePersistence persistence2 = LocalFilePersistence();
    expect(true, persistence == persistence2);
  });
}