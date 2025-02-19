import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<String> generateResponse(String prompt, String modelName) async {
    try {
      final requestData = _buildRequestBody(prompt, modelName);
      final headers = _buildHeaders(modelName);
      final endpoint = _getEndpoint(modelName);

      final response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(requestData),
      );

      print({response.body});

      if (response.statusCode != 200) {
        throw Exception(
            'API request failed: ${response.statusCode} - ${response.body}');
      }

      return _parseResponse(response.body, modelName);
    } catch (e) {
      throw Exception('Failed to generate response: $e');
    }
  }

  // Build headers based on the selected model
  Map<String, String> _buildHeaders(String modelName) {
    final apiKey = _getApiKey(modelName);

    switch (modelName) {
      case 'gpt-4':
      case 'gpt-3.5-turbo':
        return {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        };
      case 'llama':
        return {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        };
      case 'deepseek-llm':
        return {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        };
      case 'gemini-1.5-flash':
        return {
          'Content-Type': 'application/json',
        };
      default:
        throw Exception('Unsupported model');
    }
  }

  // Get the API endpoint for each model
  String _getEndpoint(String modelName) {
    final apiKey = _getApiKey(modelName);
    switch (modelName) {
      case 'gpt-4':
      case 'gpt-3.5-turbo':
        return 'https://api.openai.com/v1/chat/completions';
      case 'llama':
        return "https://openrouter.ai/api/v1/chat/completions";
      case 'deepseek-llm':
        // return 'https://api.deepseek.com/v1/chat/completions'; // Replace with actual endpoint
        return "https://openrouter.ai/api/v1/chat/completions";
      case 'gemini-1.5-flash':
        return 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey';
      default:
        throw Exception('Unsupported model');
    }
  }

  // Retrieve the API key for each model from environment variables
  String _getApiKey(String modelName) {
    switch (modelName) {
      case 'gpt-4':
        return const String.fromEnvironment('OPENAI_API_KEY',
            defaultValue:
                "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");
      case 'gpt-3.5-turbo':
        return const String.fromEnvironment('OPENAI_API_KEY',
            defaultValue:
                "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");
      case 'llama':
        return const String.fromEnvironment('META_API_KEY',
            defaultValue:
                "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");
      case 'deepseek-llm':
        return const String.fromEnvironment('DEEPSEEK_API_KEY',
            defaultValue:
                "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");
      case 'gemini-1.5-flash':
        return const String.fromEnvironment('GEMINI_API_KEY',
            defaultValue: "AIzaSyBy_J53dC7GnTe4E17vziDL5wM51IEQeqw");
      default:
        throw Exception('API key not found for $modelName');
    }
  }

  // Build the request body dynamically based on the model
  Map<String, dynamic> _buildRequestBody(String prompt, String modelName) {
    switch (modelName) {
      case 'gpt-4':
        return {
          'model': 'gpt-4o-mini',
          'store': true,
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'max_tokens': 150,
        };
      case 'gpt-3.5-turbo':
        return {
          'model': 'gpt-4o-mini',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 0.7,
          'max_tokens': 150,
        };
      case 'llama':
        return {
          'model': 'meta-llama/llama-3.3-70b-instruct:free',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'max_tokens': 150,
        };
      case 'deepseek-llm':
        return {
          'model': 'deepseek/deepseek-chat:free',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 0.7,
          'max_tokens': 150,
        };
      case 'gemini-1.5-flash':
        return {
          'contents': [
            {
              'role': 'user',
              'parts': [
                {'text': prompt}
              ]
            }
          ],
        };
      default:
        throw Exception('Unsupported model');
    }
  }

  // Parse the response dynamically based on the model
  String _parseResponse(String responseBody, String modelName) {
    final data = jsonDecode(responseBody);

    switch (modelName) {
      case 'gpt-4':
      case 'gpt-3.5-turbo':
        return data['choices'][0]['message']['content'];
      case 'llama':
        return data['choices'][0]['message']['content'];
      case 'deepseek-llm':
        return data['choices'][0]['message']
            ['content']; // Assuming a similar structure to OpenAI
      case 'gemini-1.5-flash':
        return data['candidates'][0]['content']['parts'][0]['text'];
      default:
        throw Exception('Unsupported model');
    }
  }
}
