import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/home/model/event.dart';
import 'package:note/home/widget/edit_event.dart';

class ViewerEventScreen extends StatefulWidget {
  final Event event;
  final Function(Event event) updatedEvent;
  final Function(Event event) removeEvent;

  ViewerEventScreen({required this.event, required this.updatedEvent, required this.removeEvent});

  @override
  _ViewerEventScreenState createState() => _ViewerEventScreenState();
}

class _ViewerEventScreenState extends State<ViewerEventScreen> {
  late Event event;
  @override
  void initState() {
    event = widget.event;
    super.initState();
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
                    Navigator.pop(context);
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditEventScreen(event: event),
                      ),
                    ).then((updatedEvent) {
                      if (updatedEvent != null) {
                        setState(() {
                          event = updatedEvent;
                        });
                        widget.updatedEvent.call(event);
                      }
                    });
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(color: Color(0xff3B3B3B), borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: Container(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "packages/images/assets/images/ic_edit.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
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
                              "Remove this note?",
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
                                  Navigator.pop(context, "ok");
                                },
                                child: Text(' Remove '),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff30BE71),
                                ),
                              ),
                            ],
                          );
                        });
                    if (rs != null) {
                      widget.removeEvent.call(event);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(color: Color(0xff3B3B3B), borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: Container(
                      width: 21,
                      height: 21,
                      child: Image.asset(
                        "packages/images/assets/images/ic_delete.png",
                        width: 21,
                        height: 21,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.0),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title ?? "",
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 38,
                  ),
                ),
                SizedBox(height: 30.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Text(
                        event.content ?? '',
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 16,
                        ),
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
