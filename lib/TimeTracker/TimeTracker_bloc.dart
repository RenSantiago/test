import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:testsampleproject/TimeTracker/TimeEntry_model.dart';
import 'package:testsampleproject/TimeTracker/TimeTracker_event.dart';
import 'package:testsampleproject/TimeTracker/TimeTracker_state.dart';

String TIME_ENTRY_COLLECTION = 'time-entries';

class TimeTrackerBloc extends Bloc<TimeTrackerEvent, TimeTrackerState> {
  final firebaseAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  TimeTrackerBloc() : super(TimeTrackerInitialState()) {
    on<GetAuthEvent>((state, emit) async {
      emit(AuthLoadingState());

      final user = await firebaseAuth.authStateChanges().first;
      await Future.delayed(Duration(seconds: 2));
      if (user == null) {
        emit(AuthStateSignOut());
      } else {
        emit(AuthLoadedState(user!.uid));
      }
    });

    on<SignoutEvent>((state, emit) async {
      await firebaseAuth.signOut();
      emit(AuthStateSignOut());
    });

    on<GetTimeEntriesEvent>((state, emit) async {
      emit(TimeEntriesLoadingState());
      emit(TimeTrackerLoadingState());
      try {
        final response = await fireStore
            .collection(TIME_ENTRY_COLLECTION)
            .where('uid' , isEqualTo: state.uid)
            .where('month' , isEqualTo: state.month)
            .orderBy('createdOn' ,descending: true)
            .get();
        final listing = response.docs.map((e) {
          final entryPayload = e.data();
          entryPayload['id'] = e.id;
          return TimeEntryModel.fromJson(entryPayload);
        }).toList();
        final lastEntry =
            listing.where((timeEntry) => timeEntry.end == null).firstOrNull;

        if (lastEntry != null) {
          emit(TimeTrackerLoadedState(
              lastEntry.end == null ? lastEntry.id! : null));
        } else {
          emit(TimeTrackerLoadedState(null));
        }
        emit(TimeEntriesLoadedState(listing));
      } catch (e) {
        print(e);
        emit(TimeTrackerLoadedState(''));
      }
    });

    on<AddTimeTrackerEvent>((state, emit) async {
      emit(TimeTrackerLoadingState());
      final timeEntryPayload = state.timeEntry.toJson();
      final response = await fireStore
          .collection(TIME_ENTRY_COLLECTION)
          .add(timeEntryPayload);
      TimeEntryModel newTimeEntry = state.timeEntry;
      newTimeEntry.id = response.id;
      emit(TimeTrackerLoadedState(response.id));
      emit(AddTimeEntrySuccessState(newTimeEntry));
    });

    on<AddTimeOutEvent>((state, emit) async {
      emit(TimeTrackerLoadingState());
      final timeEntry = state.timeEntry.toJson();
      await fireStore
          .collection(TIME_ENTRY_COLLECTION)
          .doc(state.timeEntry.id)
          .update(timeEntry);
      emit(TimeTrackerLoadedState(null));
    });
  }
}
