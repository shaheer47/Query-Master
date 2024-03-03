import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:query_master/services/gemni_service.dart';

import 'package:markdown_viewer/markdown_viewer.dart';

class PromptChatScreen extends StatefulWidget {
  String basePrompt, expertName;

  PromptChatScreen(
      {required this.basePrompt, required this.expertName, super.key});

  @override
  State<PromptChatScreen> createState() => _PromptChatScreenState();
}

class _PromptChatScreenState extends State<PromptChatScreen> {
  TextEditingController textController = TextEditingController();
  late String responseText;
  bool loading = false;

  @override
  void initState() {
    responseText = 'I am a ${widget.expertName}. How can i help you today?';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: AbsorbPointer(
        absorbing: loading,
        child: Scaffold(
          appBar: AppBar(
              title: Text(widget.expertName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24))),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                        labelText: 'What you want to ask?'),
                  ),
                ),
                loading
                    ? const CircularProgressIndicator()
                    : InkWell(
                        onTap: () {
                          getResponse();
                        },
                        child: const Icon(
                          Icons.send,
                          size: 30,
                        ),
                      )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  MarkdownViewer(
                    responseText,
                    enableTaskList: true,
                    enableSuperscript: false,
                    enableSubscript: false,
                    enableFootnote: false,
                    enableImageSize: false,
                    enableKbd: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getResponse() async {
    loading = true;
    setState(() {});
    String response = await GemniAI()
            .getText('${widget.basePrompt} ${textController.text}') ??
        'Something went wrong please try again';
    responseText = response;
    loading = false;
    setState(() {});
  }
}
