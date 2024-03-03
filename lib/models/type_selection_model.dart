import 'dart:ui';

import 'package:flutter/material.dart';

class TypeSelectionModel {
  String title,details, basePrompt;
  Color color;

  TypeSelectionModel({required this.title,required this.details,required this.basePrompt,required this.color});
}

List<TypeSelectionModel> getTypeSelectionList(){
  return [
    TypeSelectionModel(
      title: 'Flutter Expert',
      basePrompt: 'You are a flutter expert with wide experience in software development. Please answer the question below with your expertise \n',
      details: 'As a Flutter Expert, I welcome inquiries on all things Flutter! Whether it\'s troubleshooting, best practices, or design tips, feel free to ask me your Flutter-related questions for expert guidance and assistance.',
        color: Colors.blueAccent.shade100
    ),
    TypeSelectionModel(
      title: 'Food Expert',
      details: 'As a Food Expert, I\'m here to satisfy your culinary curiosities! From recipes and cooking techniques to flavor pairings and dietary advice, ask me anything related to the world of food for expert insights and delicious discoveries.',
      basePrompt: 'You are a Food expert with wide experience in Cooking domain. Please answer the question below with your expertise \n',
      color: Colors.greenAccent.shade100
    ),
    TypeSelectionModel(
      title: 'Health Expert',
      details: 'As a Health Expert, your well-being is my priority. Feel free to ask any health-related questions, from fitness tips and nutrition advice to wellness strategies. I\'m here to provide expert guidance on your journey to a healthier lifestyle.',
      basePrompt: 'You are a Health expert with wide experience in Gym, Hospitals and other health domain. Please answer the question below with your expertise \n',
      color: Color.fromRGBO(246,219,219,1),
    ),
    TypeSelectionModel(
      title: 'Custom Expert',
      details: 'As a Custom Expert, I offer personalized expertise tailored to your unique needs. Ask me anything within my realm of knowledge, and I\'ll provide custom-tailored answers and guidance. Your specific questions deserve specialized attention, and I\'m here to help.',
        basePrompt: 'You are a ***** expert with wide experience. Please answer the question below with your expertise \n',
      color: Colors.grey.shade50
    ),
  ];
}
