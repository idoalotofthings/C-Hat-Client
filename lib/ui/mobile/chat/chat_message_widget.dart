import 'package:flutter/material.dart';
import 'package:c_hat/model/message.dart';

class ChatMessageWidget extends StatelessWidget {
  final Message message;

  const ChatMessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(1),
              child: Text(
                message.author, 
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,              
                ),
            ),

            Row(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        message.content,
                        style: const TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child:
                          Text(message.time, style: const TextStyle(fontSize: 8)),
                    )
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
