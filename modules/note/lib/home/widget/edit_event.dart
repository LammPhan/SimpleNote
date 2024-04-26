import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/home/model/event.dart';

class EditEventScreen extends StatefulWidget {
  final Event event;

  EditEventScreen({required this.event});

  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late TextEditingController nameController;
  late TextEditingController contentController;
  // late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.event.title);
    contentController = TextEditingController(text: widget.event.content);
    // dateController = TextEditingController(text: widget.event.date.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 53.0),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    var rs = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actionsAlignment: MainAxisAlignment.spaceAround,
                            backgroundColor: Color(0xff252525),
                            icon: Icon(
                              Icons.info,
                              color: Color(0xff606060),
                            ),
                            title: Text(
                              "Are your sure you want discard your changes ?",
                              style: GoogleFonts.nunito(
                                color: Color(0xffCFCFCF),
                                fontSize: 23,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context, "ok");
                                },
                                child: Text('Discard '),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffFF0000),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('  Keep  '),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff30BE71),
                                ),
                              ),
                            ],
                          );
                        });
                    if (rs != null) {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(color: Color(0xff3B3B3B), borderRadius: BorderRadius.circular(8)),
                    child: Image.asset(
                      "packages/images/assets/images/ic_left.png",
                      width: 13,
                      height: 22,
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    var rs = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actionsAlignment: MainAxisAlignment.spaceAround,
                            backgroundColor: Color(0xff252525),
                            icon: Icon(
                              Icons.info,
                              color: Color(0xff606060),
                            ),
                            title: Text(
                              "Save changes?",
                              style: GoogleFonts.nunito(
                                color: Color(0xffCFCFCF),
                                fontSize: 23,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Discard '),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffFF0000),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  String name = nameController.text;
                                  String content = contentController.text;

                                  Event updatedEvent = Event(title: name, content: content);
                                  Navigator.pop(context, updatedEvent);
                                },
                                child: Text('  Save  '),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff30BE71),
                                ),
                              ),
                            ],
                          );
                        });
                    if (rs != null) {
                      Navigator.pop(context, rs);
                    }
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Color(0xff3B3B3B), borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        "packages/images/assets/images/ic_save.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.0),
            Expanded(
                child: Column(
              children: [
                TextField(
                  controller: nameController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 38,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: GoogleFonts.nunito(
                      color: Color(0xff9A9A9A),
                      fontSize: 48,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                // SizedBox(height: 16.0),
                // TextField(
                //   controller: dateController,
                //   decoration: InputDecoration(hintText: 'Time'),
                //   keyboardType: TextInputType.datetime,
                //   cursorColor: Colors.white,
                // ),
                SizedBox(height: 30.0),
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: contentController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Type something...',
                        hintStyle: GoogleFonts.nunito(
                          color: Color(0xff9A9A9A),
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 500,
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
