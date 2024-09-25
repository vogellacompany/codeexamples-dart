import 'dart:io';

void main(List<String> args) {
  // Check if the user provided a target directory
  if (args.isEmpty) {
    print('Usage: dart append_to_adoc.dart <target_directory>');
    return;
  }

  // Get the target directory from the command line arguments
  final targetDirectory = Directory(args[0]);

  // Check if the directory exists
  if (!targetDirectory.existsSync()) {
    print('The provided directory does not exist.');
    return;
  }

  // Traverse the file system and process all 008_resourceslocal.adoc files
  traverseAndAppend(targetDirectory);
}

void traverseAndAppend(Directory directory) {
  // List all files and directories recursively
  final entities = directory.listSync(recursive: true, followLinks: false);

  for (var entity in entities) {
    // Check if the entity is a file and matches the name we are looking for
    if (entity is File && entity.path.endsWith('008_resourceslocal.adoc')) {
      appendToFile(entity);
    }
  }
}

void appendToFile(File file) {
  const contentToAppend = '''
include::../10_Include/source-flutter.adoc[]
''';

  try {
    // Open the file in append mode and add the content
    file.writeAsStringSync(contentToAppend, mode: FileMode.append);
    print('Appended to file: ${file.path}');
  } catch (e) {
    print('Failed to append to file: ${file.path}, Error: $e');
  }
}
