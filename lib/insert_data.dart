import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_instance.dart';

import 'package:simple_markdown_editor/simple_markdown_editor.dart';

class InsertData extends StatefulWidget {
  const InsertData({super.key});

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  DatabasesInstance databasesInstance = DatabasesInstance();
  TextEditingController tittleText = TextEditingController();
  TextEditingController descriptionText = TextEditingController();

  @override
  void initState() {
    databasesInstance.databases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dt = DateTime.now().toLocal();
    var newFormat = DateFormat("HH:mm");
    String updatedDt = newFormat.format(dt);

    print(descriptionText);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF282a36),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Container(
          height: 50,
          width: 500,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color.fromARGB(115, 54, 57, 73)),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 5),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new,
                        color: Color(0xff50fa7b))),
              ),
              SizedBox(
                width: 230,
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                child: IconButton(
                    onPressed: () async {
                      await databasesInstance.insert({
                        'title': tittleText.text,
                        'description': descriptionText.text,
                        'create_at': updatedDt.toString(),
                        'update_at': updatedDt.toString()
                      });
                      Navigator.pop(context);
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.done_outlined,
                      color: Color(0xff50fa7b),
                    )),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Tittle',
                  hintStyle: TextStyle(color: Colors.white)),
              controller: tittleText,
            ),
          ),
          MarkdownField(
            padding: EdgeInsets.only(left: 15),
            controller: descriptionText,
            emojiConvert: true,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Sarabun',
                backgroundColor: Colors.white),
          )
        ],
      ),
    );
  }

  // Widget writingNote(){

  // }
}
