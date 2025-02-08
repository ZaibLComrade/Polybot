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
      case 'claude-2':
        return {
          'Content-Type': 'application/json',
          'x-api-key': apiKey,
          'anthropic-version': '2023-06-01',
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
      case 'claude-2':
        return 'https://api.anthropic.com/v1/messages';
      case 'deepseek-llm':
        return 'https://api.deepseek.com/v1/chat/completions'; // Replace with actual endpoint
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
        return const String.fromEnvironment('OPENAI_API_KEY');
      case 'claude-2':
        return const String.fromEnvironment('ANTHROPIC_API_KEY');
      case 'deepseek-llm':
        return const String.fromEnvironment('DEEPSEEK_API_KEY',
            defaultValue: "sk-f1902595dc654ed78470b63797acac09");
      case 'gemini-1.5-flash':
        return const String.fromEnvironment('GEMINI_API_KEY',
            defaultValue: "AIzaSyAFbt5CxNJVeSDqfPIaeFyBm9jMsN1Zo2A");
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
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 0.7,
        };
      case 'gpt-3.5-turbo':
        return {
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 0.7,
        };
      case 'claude-2':
        return {
          'model': 'claude-2',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'max_tokens': 1000,
        };
      case 'deepseek-llm':
        return {
          'model': 'deepseek-llm',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 0.7,
          'max_tokens': 1000,
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
          ]
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
      case 'claude-2':
        return data['content'][0]['text'];
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
