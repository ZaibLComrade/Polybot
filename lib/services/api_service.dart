import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:polybot/helper/database_helper.dart';

class ApiService {
  final DatabaseHelper _db = DatabaseHelper();

  Future<String> generateResponse(String prompt, String model) async {
    try {
      String? apiKey = await _getApiKey(model);
      if (apiKey == null) throw Exception('API key not found for $model');

      final requestData = _buildRequestBody(prompt, model);
      final headers = _buildHeaders(model, apiKey);
      final endpoint = _getEndpoint(model);

      final response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(requestData),
      );

      if (response.statusCode != 200) {
        throw Exception('API request failed: ${response.statusCode} - ${response.body}');
      }

      return _parseResponse(response.body, model);
    } catch (e) {
      throw Exception('Failed to generate response: $e');
    }
  }

  Future<String?> _getApiKey(String model) async {
    switch (model) {
      case 'GPT-4':
      case 'GPT-3.5':
        return await _db.getApiKey('openai');
      case 'Claude AI':
        return await _db.getApiKey('anthropic');
      case 'Llama 2':
        return await _db.getApiKey('replicate');
      case 'Gemini Flash':
        return await _db.getApiKey('gemini');
      default:
        return null;
    }
  }

  Map<String, String> _buildHeaders(String model, String apiKey) {
    switch (model) {
      case 'GPT-4':
      case 'GPT-3.5':
        return {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        };
      case 'Claude AI':
        return {
          'Content-Type': 'application/json',
          'x-api-key': apiKey,
          'anthropic-version': '2023-06-01',
        };
      case 'Llama 2':
        return {
          'Content-Type': 'application/json',
          'Authorization': 'Token $apiKey',
        };
      case 'Gemini Flash':
        return {
          'Content-Type': 'application/json',
        };
      default:
        throw Exception('Unsupported model');
    }
  }

  String _getEndpoint(String model) {
    switch (model) {
      case 'GPT-4':
      case 'GPT-3.5':
        return 'https://api.openai.com/v1/chat/completions';
      case 'Claude AI':
        return 'https://api.anthropic.com/v1/messages';
      case 'Llama 2':
        return 'https://api.replicate.com/v1/predictions';
      case 'Gemini Flash':
        return 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';
      default:
        throw Exception('Unsupported model');
    }
  }

  Map<String, dynamic> _buildRequestBody(String prompt, String model) {
    switch (model) {
      case 'GPT-4':
      case 'GPT-3.5':
        return {
          'model': model == 'GPT-4' ? 'gpt-4' : 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 0.7,
        };
      case 'Claude AI':
        return {
          'model': 'claude-2',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'max_tokens': 1000,
        };
      case 'Llama 2':
        return {
          "model": "llama3.1-70b",
          "input": {"prompt": prompt}
        };
      case 'Gemini Flash':
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

  String _parseResponse(String responseBody, String model) {
    final data = jsonDecode(responseBody);

    switch (model) {
      case 'GPT-4':
      case 'GPT-3.5':
        return data['choices'][0]['message']['content'];
      case 'Claude AI':
        return data['content'][0]['text'];
      case 'Llama 2':
        return data['output'];
      case 'Gemini Flash':
        return data['candidates'][0]['content']['parts'][0]['text'];
      default:
        throw Exception('Unsupported model');
    }
  }
}
