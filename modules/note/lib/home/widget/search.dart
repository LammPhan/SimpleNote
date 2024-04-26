import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/home/model/event.dart';
import 'package:note/home/widget/event_item.dart';
import 'package:note/home/widget/viewer.dart';

class SearchEventPage extends StatefulWidget {
  final List<Event> listEvent;
  final Future Function(Event event) deleteEvent;
  final Future Function(Event event) updateEvent;
  SearchEventPage({required this.listEvent, required this.deleteEvent, required this.updateEvent});
  @override
  _SearchEventPageState createState() => _SearchEventPageState();
}

class _SearchEventPageState extends State<SearchEventPage> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  List<Event> listEventResult = [];
  Future<void> updateEvent(Event? event) async {
    if (event != null) {
      await widget.updateEvent.call(event);
      int index = listEventResult.indexWhere(
        (element) => element.id == event.id,
      );
      setState(
        () {
          listEventResult[index] = event;
        },
      );
    }
  }

  Future<void> deleteEvent(Event? event) async {
    if (event != null) {
      await widget.deleteEvent.call(event);
      listEventResult.removeWhere((element) => element == event);
      widget.listEvent.removeWhere((element) => element == event);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 60.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 16),
                  child: TextField(
                    controller: _searchController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.search,
                    style: GoogleFonts.nunito(
                      color: Color(0xffffffff),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 30, right: 30),
                      hintText: 'Search by the keyword...',
                      hintStyle: GoogleFonts.nunito(
                        color: Color(0xff9A9A9A),
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: BorderSide(
                          color: Color(0xff252525),
                          width: 1,
                        ),
                      ),
                      fillColor: Color(0xff3B3B3B),
                      filled: true,
                      suffixIcon: _searchText.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _searchController.text = "";
                                setState(() {
                                  _searchText = '';
                                  listEventResult = [];
                                });
                              },
                              icon: Image.asset(
                                "packages/images/assets/images/ic_close.png",
                                width: 24,
                                height: 24,
                              ),
                            )
                          : null,
                    ),
                    onChanged: (text) {
                      setState(() {
                        _searchText = text;
                        listEventResult = widget.listEvent
                            .where((element) =>
                                "${element.title}${element.content}".toLowerCase().contains(text.toLowerCase()))
                            .toList();
                      });
                    },
                    onSubmitted: (text) {
                      //
                    },
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: listEventResult.isEmpty && _searchText.isNotEmpty
                  ? buildEmpty(context)
                  : ListView.separated(
                      padding: EdgeInsets.only(top: 16),
                      itemCount: listEventResult.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 25,
                        );
                      },
                      itemBuilder: (context, index) {
                        final event = listEventResult[index];
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
            ),
          )
        ],
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
            "packages/images/assets/images/file_not_found.png",
            width: 350,
          ),
          Text(
            "Note not found. Try searching again.",
            style: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
