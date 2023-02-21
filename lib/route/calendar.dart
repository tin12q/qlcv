import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:clean_calendar/clean_calendar.dart';
import 'package:qlcv/model/color_picker.dart';
import 'package:qlcv/model/task_box.dart';

import '../model/data_proc.dart';
import '../model/task.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Task> task2 = [];
  List<DateTime> selectedDates = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(
          children: [
            SizedBox(width: 10),
            Expanded(
                child: Center(
              child: CleanCalendar(
                currentDateProperties: DatesProperties(
                  datesDecoration: DatesDecoration(
                    datesTextColor: Colors.black87,
                    datesBorderColor: ColorPicker.primaryDark,
                    //datesBackgroundColor: ColorPicker.accent,
                    datesBorderRadius: 1000,
                  ),
                ),
                generalDatesProperties: DatesProperties(
                  datesDecoration: DatesDecoration(
                    datesBorderColor: ColorPicker.primaryLight,
                    datesBorderRadius: 1000,
                  ),
                ),
                leadingTrailingDatesProperties: DatesProperties(
                  datesDecoration: DatesDecoration(
                    datesBackgroundColor: ColorPicker.primaryLight,
                    datesBorderRadius: 1000,
                  ),
                ),
                dateSelectionMode: DatePickerSelectionMode.singleOrMultiple,

                // Listening to selected dates.
                onSelectedDates: (List<DateTime> value) {
                  // If selected date picked again then removing it from selected dates.
                  if (selectedDates.contains(value.first)) {
                    selectedDates.remove(value.first);
                  } else {
                    // If unselected date picked then adding it to selected dates.
                    selectedDates.add(value.first);
                  }

                  // setState to update the calendar with new selected dates.
                  setState(() {
                    task2 = [];
                    for (var i in DataProc.tasks) {
                      for (var j in selectedDates) {
                        if (i.endDate.day == j.day &&
                            i.endDate.month == j.month &&
                            i.endDate.year == j.year) {
                          task2.add(i);
                        }
                      }
                    }
                  });
                },

                // Providing calendar the dates to select in ui.
                selectedDates: selectedDates,

                // Customizing selected date.
                selectedDatesProperties: DatesProperties(
                  datesDecoration: DatesDecoration(
                    datesBackgroundColor: ColorPicker.primaryDark,
                    datesBorderColor: ColorPicker.primaryLight,
                    datesBorderRadius: 1000,
                  ),
                ),
              ),
            )),
            SizedBox(width: 10)
          ],
        ),
        Expanded(
          child: TaskBoxList(
            tasks: task2,
          ),
        )
      ]),
    ));
  }
}
