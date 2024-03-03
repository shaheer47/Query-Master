import 'dart:math';

import 'package:flutter/material.dart';
import 'package:query_master/ui/prompt_chat_screen.dart';

import '../models/type_selection_model.dart';
import '../widgets/animated_card.dart';
import '../widgets/simple_card.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class TypeSelectionScreen extends StatelessWidget {
  const TypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Select an Expert',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
        body: ListView.builder(
            itemCount: getTypeSelectionList().length,
            itemBuilder: (context, index) {
              TypeSelectionModel typeSelection = getTypeSelectionList()[index];
              return SimpleCard(
                color: typeSelection.color,
                child: InkWell(
                  onTap: () async {
                    if (typeSelection.title == 'Custom Expert') {
                      String? title = await getDialogBox(context);
                      if(title==null){
                        return;
                      }
                       typeSelection.basePrompt =
                          typeSelection.basePrompt.replaceAll('*****', title);

                      if (!title.toLowerCase().contains('expert')) {
                        title += ' Expert';
                      }
                      typeSelection.title = title;
                    }
                    typeSelection.title =
                        toBeginningOfSentenceCase(typeSelection.title);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PromptChatScreen(
                        basePrompt: typeSelection.basePrompt,
                        expertName: typeSelection.title,
                      ),
                    ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(typeSelection.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24)),
                            const Icon(Icons.navigate_next)
                          ],
                        ),
                        const Divider(),
                        Text(
                          typeSelection.details,
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  String getPromptText(TypeSelectionModel typeSelection, BuildContext context) {
    return typeSelection.basePrompt;
  }

  Future<String?> getDialogBox(BuildContext mainContext) async {
    String? customText = await showDialog(
      context: mainContext,
      builder: (BuildContext context) {
        TextEditingController textController = TextEditingController();
        return AlertDialog(
          title: const Text('Custom Expert'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(labelText: 'Enter expert name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(mainContext).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(mainContext)
                    .pop(textController.text); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    return customText;
  }
}
