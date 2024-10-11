import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testsampleproject/TimeTracker/TimeEntry_model.dart';

class TimeEntry extends StatefulWidget {
  final TimeEntryModel timeEntry;

  const TimeEntry({required this.timeEntry});

  @override
  State<TimeEntry> createState() => _TimeEntryState();
}

class _TimeEntryState extends State<TimeEntry> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final _timeEntry = widget.timeEntry;

    String formatTime(DateTime? time) {
      return DateFormat('hh:mm:ss z').format(time!).toString();
    }

    TextStyle dateStyle(double size) {
      return TextStyle(fontSize: size, fontWeight: FontWeight.bold);
    }

    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black12))),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.black12))),
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      Text(_timeEntry.abbr, style: dateStyle(10)),
                      Text(_timeEntry.day, style: dateStyle(18))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Time in : ${formatTime(_timeEntry.start)}'),
                    if (_timeEntry.end != null)
                      Text('Time out : ${formatTime(_timeEntry.end!)}')
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
