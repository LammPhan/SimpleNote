import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/home/model/event.dart';

class EventItem extends StatelessWidget {
  static const List<Color> listBackground = [
    Color(0xffFD99FF),
    Color(0xffFF9E9E),
    Color(0xff91F48F),
    Color(0xffFFF599),
    Color(0xff9EFFFF),
    Color(0xffB69CFF),
  ];
  final int index;
  final Event event;
  final Function onTap;
  EventItem({
    required this.event,
    required this.index,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => onTap.call(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: listBackground[index % listBackground.length],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 25,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title ?? "",
              style: GoogleFonts.nunito(
                color: Color(
                  0xff000000,
                ),
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              event.content ?? "",
              style: GoogleFonts.nunito(
                color: Color(
                  0xff000000,
                ),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
