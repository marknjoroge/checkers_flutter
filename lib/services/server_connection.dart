import 'dart:convert';

  import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

// const String _baseUrl = 'https://restcountries.com';
// const String _endpoint = '/v3.1/all';

final channel = IOWebSocketChannel.connect('ws://localhost:3000');


const String _baseUrl = 'http://localhost:3000';
// const String _endpoint = '/get/game-details';
const String _endpoint = '';

void main() {

// channel.stream.listen((message) {
//   print('Received: $message');
// });

// channel.sink.add('Hello, server!');


  Stopwatch stopwatch = Stopwatch()..start(); // create and start stopwatch
  print('Elapsed time at checkpoint 1: ${stopwatch.elapsedMilliseconds} milliseconds');
  // code to start and stop the stopwatch as needed
  // Create a new instance of ApiService
  final apiService = ApiService();
  print('Elapsed time at checkpoint 2: ${stopwatch.elapsedMilliseconds} milliseconds');
  // Call getData() function from ApiService
  // apiService.getData();
  print('Elapsed time at checkpoint 3: ${stopwatch.elapsedMilliseconds} milliseconds');

  // .then((data) {
  //   // Print the data from the API
  //   print(data);
  // });
}

class ApiService {
  Future<dynamic> getData() async {
    final response = await http.get(Uri.parse('$_baseUrl/$_endpoint'));
print(response.body);
    if (response.statusCode == 200) {
      // return jsonDecode(response.body);
      
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  // Future<void> sendgameData() async {
  //   final url = Uri.parse('http://127.0.0.1:3000/get/game-details');
  //   final headers = {'Content-Type': 'application/json'};
  //   final data = {'name': 'John Doe', 'age': 30};
  //   final jsonData = jsonEncode(data);

  //   try {
  //     final response = await http.post(url, headers: headers, body: jsonData);
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //   } catch (error) {
  //     print('Error sending data: $error');
  //   }
  // }
}
