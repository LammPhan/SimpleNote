import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/home/code_push/code_push_controller.dart';
import 'package:note/home/model/event.dart';
import 'package:note/home/widget/add_event.dart';
import 'package:note/home/widget/event_item.dart';
import 'package:note/home/widget/search.dart';
import 'package:note/home/widget/viewer.dart';
import 'package:note/main.dart';

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  List<Event> events = [
    // Event(name: 'Event 1', date: DateTime.now().add(Duration(days: 1))),
    // Event(name: 'Event 2', date: DateTime.now().add(Duration(days: 2))),
  ];

  @override
  void initState() {
    // TODO: implement initState
    initEvent();
    // CodePushAppController().init();
    super.initState();
  }

  Future<void> initEvent() async {
    events = await appDatabase?.eventDao.findAllEvent() ?? [];
    setState(() {});
  }

  Future<void> addEvent(Event? newEvent) async {
    if (newEvent != null) {
      await appDatabase?.eventDao.insertEvent(newEvent);
      setState(
        () {
          events.add(newEvent);
        },
      );
    }
  }

  Future<void> updateEvent(Event? event) async {
    if (event != null) {
      await appDatabase?.eventDao.updateEvent(event);
      int index = events.indexWhere(
        (element) => element.id == event.id,
      );
      setState(
        () {
          events[index] = event;
        },
      );
    }
  }

  Future<void> deleteEvent(Event? event) async {
    if (event != null) {
      await appDatabase?.eventDao.deleteEvent(event);
      events.removeWhere((element) => element == event);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      appBar: AppBar(
        title: Text(
          'Notes',
          style: GoogleFonts.nunito(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchEventPage(
                      listEvent: events,
                      updateEvent: (event) => updateEvent(event),
                      deleteEvent: (event) => deleteEvent(event),
                    ),
                  ),
                ).then((updatedEvent) {});
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: events.isEmpty
          ? buildEmpty(context)
          : ListView.separated(
              padding: EdgeInsets.only(top: 16),
              itemCount: events.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 25,
                );
              },
              itemBuilder: (context, index) {
                final event = events[index];
                return EventItem(
                  index: index,
                  event: event,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewerEventScreen(
                          event: event,
                          updatedEvent: (event) {
                            updateEvent(event);
                          },
                          removeEvent: (event) {
                            deleteEvent(event);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEventScreen(),
            ),
          ).then((newEvent) {
            addEvent(newEvent);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "packages/images/assets/images/note_empty.png",
            width: 350,
          ),
          Text(
            "Create your first note!",
            style: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
