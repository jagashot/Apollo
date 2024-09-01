import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class BuildRecordView extends StatefulWidget {
  const BuildRecordView({super.key});

  @override
  _BuildRecordViewState createState() => _BuildRecordViewState();
}

class _BuildRecordViewState extends State<BuildRecordView> {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  String? _filePath;

  @override
  void dispose() {
    _recorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      if (await _recorder.hasPermission()) {
        String path = '${Directory.systemTemp.path}/recording.m4a';

        RecordConfig config = const RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        );

        await _recorder.start(config, path: path);

        setState(() {
          _isRecording = true;
          _filePath = path;
        });
      }
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _recorder.stop();

      setState(() {
        _isRecording = false;
      });
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<void> _playRecording() async {
    if (_filePath != null) {
      try {
        await _audioPlayer.play(DeviceFileSource(_filePath!));
      } catch (e) {
        print('Error playing recording: $e');
      }
    }
  }

 Future<void> _sendFileToServer() async {
    if(_filePath == null) return;
    final url = Uri.parse('http://localhost:3000/sendFileToModel');
    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath(
      'file', 
      _filePath!, 
      contentType: MediaType('audio', 'm4a'),
    ));

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final bytes = await response.stream.toBytes();
        var midiFilePath = '${Directory.systemTemp.path}/output.midi';

        final file = File(midiFilePath);
        await file.writeAsBytes(bytes);

        print('MIDI file downloaded to: $midiFilePath');

        // Trigger UI update for downloading the MIDI file
        setState(() {
          midiFilePath = midiFilePath;
        });
      } else {
        print('Failed to download MIDI file.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _isRecording ? 'Recording...' : 'Tap to Record',
            style: const TextStyle(color: Colors.white, fontSize: 20, decoration: TextDecoration.none),
          ),
          const SizedBox(height: 40),
          AvatarGlow(
            glowCount: _isRecording ? 3 : 2,
            glowRadiusFactor: _isRecording ? 0.3 : 0.1,
            animate: true,
            child: GestureDetector(
              onTap: () async {
                if (_isRecording) {
                  await _stopRecording();
                  await _sendFileToServer();  // Send the file to the server after recording
                } else {
                  await _startRecording();
                }
              },
              child: Material(
                shape: const CircleBorder(),
                elevation: 8,
                child: Container(
                  padding: const EdgeInsets.all(40),
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/photos/main_btn.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 140, 80, 182),
                  ),
                  child: Icon(
                    _isRecording ? Icons.stop : Icons.mic,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _filePath != null ? _playRecording : null,
            child: const Text('Play Recording'),
          ),
        ],
      ),
    );
  }
}
