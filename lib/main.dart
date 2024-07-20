import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FilePickerScreen(),
    );
  }
}


class FilePickerScreen extends StatefulWidget {
  const FilePickerScreen({super.key});


  @override
  _FilePickerScreenState createState() => _FilePickerScreenState();
}


class _FilePickerScreenState extends State<FilePickerScreen> {
  String _uploadPath = '';
  String _downloadPath = '';


  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();


    if (result != null) {
      setState(() {
        _uploadPath = result.files.single.path ?? '';
      });
    }
  }


  Future<void> _pickDownloadDirectory() async {
    String? directoryPath = await getDirectoryPath();


    if (directoryPath != null) {
      TextEditingController fileNameController = TextEditingController();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enter File Name'),
            content: TextField(
              controller: fileNameController,
              decoration: const InputDecoration(hintText: "File Name"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    _downloadPath =
                        p.join(directoryPath, fileNameController.text);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Picker Sample'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Upload Path: $_uploadPath'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickFile,
              child: const Text('Upload'),
            ),
            const SizedBox(height: 40),
            Text('Download Path: $_downloadPath'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickDownloadDirectory,
              child: const Text('Download'),
            ),
          ],
        ),
      ),
    );
  }
}
