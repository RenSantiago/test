import 'package:testsampleproject/TimeTracker/TimeEntry_model.dart';

abstract class TimeTrackerEvent {}

class AddTimeTrackerEvent extends TimeTrackerEvent {
  TimeEntryModel timeEntry;
  AddTimeTrackerEvent(this.timeEntry);
}


class GetTimeEntriesEvent extends TimeTrackerEvent {
  final String uid;
  final String month;
  GetTimeEntriesEvent({
    required this.uid ,
    required this.month
});
}

class GetActiveTimeEntryEvent extends TimeTrackerEvent {}

class GetAuthEvent extends TimeTrackerEvent {}

class SignoutEvent extends TimeTrackerEvent {}

class AddTimeOutEvent extends TimeTrackerEvent {
  final TimeEntryModel timeEntry;
  AddTimeOutEvent(this.timeEntry);
}