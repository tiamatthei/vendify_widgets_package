import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:vendify_widgets_package/classes/etraining/assistant_config.dart';
import 'package:vendify_widgets_package/classes/etraining/assistant_message.dart';

class AzureAssistant {
  AssistantConfig assistantConfig;


  AzureAssistant(this.assistantConfig);

  String get endpoint => assistantConfig.endpoint;
  String get apiKey => assistantConfig.apiKey;
  String get assistantId => assistantConfig.assistantId;
  String get instructions => assistantConfig.instructions;
  List<String>? get vectorStoreIds => assistantConfig.vectorStoreIds;


  /// Create an assistant.
  Future<String> createAssistant(String name) async {
    try {
      final url = Uri.parse('$endpoint/openai/assistants?api-version=2024-05-01-preview');
      final response = await http.post(
        url,
        headers: {
          'api-key': apiKey,
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "instructions": instructions,
          "name": name,
          "tools": [
            {"type": "file_search"}
          ],
          "model": "gpt-35-turbo-2",
          "tool_resources": {
            "file_search": {"vector_store_ids": vectorStoreIds}
          },
          "temperature": 1,
          "top_p": 1
        }),
      );
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      log(data.toString());
      return data["id"] ?? "";
    } catch (e) {
      log(e.toString());
      return "";
    }
  }

  /// Create a thread.
  Future<String> createThread() async {
    try {
      final url = Uri.parse('$endpoint/openai/threads?api-version=2024-05-01-preview');
      final response = await http.post(url, headers: {
        'api-key': apiKey,
        'Content-Type': 'application/json',
      });
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      return data["id"] ?? "";
    } catch (e) {
      log(e.toString());
      return "";
    }
  }

  /// Add a user message to the thread.
  Future<void> addUserMessage(String threadId, String content) async {
    try {
      final url = Uri.parse('$endpoint/openai/threads/$threadId/messages?api-version=2024-05-01-preview');
      await http.post(url,
          headers: {
            'api-key': apiKey,
            'Content-Type': 'application/json',
          },
          body: json.encode({
            "role": "user",
            "content": content,
          }));
    } catch (e) {
      log(e.toString());
    }
  }

  /// Run the thread by specifying the assistant ID.
  Future<String> runThread(String threadId) async {
    try {
      final url = Uri.parse('$endpoint/openai/threads/$threadId/runs?api-version=2024-05-01-preview');
      final response = await http.post(url,
          headers: {
            'api-key': apiKey,
            'Content-Type': 'application/json',
          },
          body: json.encode({"assistant_id": assistantId}));
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      log(data.toString());
      return data["id"] ?? "";
    } catch (e) {
      log(e.toString());
      return "";
    }
  }

  /// Get the run status.
  Future<Map<String, dynamic>> getRunStatus(String threadId, String runId) async {
    try {
      final url = Uri.parse('$endpoint/openai/threads/$threadId/runs/$runId?api-version=2024-05-01-preview');
      final response = await http.get(url, headers: {
        'api-key': apiKey,
      });
      return jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      log(e.toString());
      return {};
    }
  }

  /// Retrieve the assistant's latest messages.
  Future<List<AssistantMessage>> getThreadMessages(String threadId) async {
    try {
      final url = Uri.parse('$endpoint/openai/threads/$threadId/messages?api-version=2024-05-01-preview');
      final response = await http.get(url, headers: {
        'api-key': apiKey,
        'Content-Type': 'application/json',
      });
      log(response.body);
      // remove anything that looks like this: ã something ã
      final cleanResponse = response.body.replaceAll(RegExp(r'ã.*?ã'), '');
      dynamic jsonResponse = jsonDecode(utf8.decode(cleanResponse.codeUnits));
      return List<AssistantMessage>.from(jsonResponse['data'].map((msg) => AssistantMessage.fromJson(msg)));
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}

// Future<String> askBusinessAssistant(String userQuestion) async {
//   // Business context or instructions
//   const String systemContext = """
// Eres un asistente de IA para la empresa Getnet. Conoce nuestros precios, características,
// productos y políticas. Responde concisamente y en español a preguntas de nuestros empleados.
// """;

//   final requestBody = {
//     "messages": [
//       {"role": "system", "content": systemContext},
//       {"role": "user", "content": userQuestion}
//     ],
//     "max_tokens": 150,
//     "temperature": 0.7
//   };

//   final response = await http.post(
//     Uri.parse(endpoint),
//     headers: {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $apiKey',
//     },
//     body: json.encode(requestBody),
//   );

//   if (response.statusCode == 200) {
//     final responseData = jsonDecode(utf8.decode(response.bodyBytes));
//     return responseData['choices'][0]['message']['content'].trim();
//   } else {
//     return 'No se pudo obtener una respuesta.';
//   }
// }
