import 'package:daxos/widgets/message_box.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MessageBox> messages = [
    MessageBox("Hello"),
    MessageBox("Bye", false),
    MessageBox("What r u doing?")
  ];

  TextEditingController controller = TextEditingController();

  bool isLocked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Daxos"
        ),
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 30
        )
      ),

      // Body
      body: Column(
        children: [

          // Chat
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              reverse: true,
              children: messages,
            )
          ),

          SizedBox(height: 10,),

          // Actions Bar
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    top: 10,
                    bottom: 10,
                    right: 5
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Ask me anything...",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                      )
                    ),
                    minLines: 3,
                    maxLines: 5,
                    // decoration: ,
                  ),
                ),
              ),
              Center(
                child: IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 32,
                  onPressed: isLocked ? null : () {
                    // TODO message logic
                  }
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}