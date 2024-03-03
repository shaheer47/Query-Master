import 'package:google_generative_ai/google_generative_ai.dart';

import '../constants/Constants.dart';


class GemniAI {
  Future<String?> getText(String userPrompt) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: API_KEY);

    final content = [Content.text(userPrompt)];
    final response = await model.generateContent(content);
    return response.text;
  }
}