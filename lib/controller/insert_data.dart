import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notesimple/model/database_instance.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:dismissible_page/dismissible_page.dart';

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
    descriptionText = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;

    var dt = DateTime.now().toLocal();
    var newFormat = DateFormat("HH:mm");
    String updatedDt = newFormat.format(dt);

    return DismissiblePage(
        child: SafeArea(
            child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xFF282a36),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            forceMaterialTransparency: true,
            title: Container(
              height: 50,
              width: 500 * _mediaQuery.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromARGB(115, 54, 57, 73)),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new,
                            color: Color(0xff50fa7b))),
                  ),
                  Flexible(
                      flex: 2,
                      child: SizedBox(
                        width: 230 * _mediaQuery.width,
                      )),
                  Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                        onPressed: () async {
                          if (tittleText.text.isEmpty &&
                              descriptionText.text.isEmpty) {
                            IconSnackBar.show(
                                context: context,
                                label: 'Masukkan data yang kosong',
                                snackBarType: SnackBarType.fail);
                          } else if (tittleText.text.isNotEmpty &&
                              descriptionText.text.isNotEmpty) {
                            await databasesInstance.insert(
                              {
                                'title': tittleText.text,
                                'description': descriptionText.text,
                                'create_at': updatedDt.toString(),
                                'update_at': updatedDt.toString()
                              },
                            );
                            Navigator.pop(context);
                            setState(() {});
                            IconSnackBar.show(
                                context: context,
                                label: 'save',
                                snackBarType: SnackBarType.save);
                          } else {
                            IconSnackBar.show(
                                context: context,
                                label: 'Masukkan data yang kosong',
                                snackBarType: SnackBarType.fail);
                          }
                          ;
                        },
                        icon: const Icon(
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
                padding: const EdgeInsets.only(left: 15, right: 16, top: 10),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style:
                      const TextStyle(color: Color(0xffFFFBF5), fontSize: 24),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle:
                          TextStyle(color: Color(0xffe9ecef), fontSize: 24)),
                  controller: tittleText,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  style:
                      const TextStyle(color: Color(0xffe9ecef), fontSize: 18),
                  controller: descriptionText,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintStyle:
                        TextStyle(color: Color(0xffe9ecef), fontSize: 18),
                    hintText: 'Description',
                    border: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
        )),
        onDismissed: () {
          Navigator.pop(context);
        });
  }

  // Widget writingNote(){

  // }
}
