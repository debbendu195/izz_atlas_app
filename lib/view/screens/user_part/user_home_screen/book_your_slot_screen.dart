import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izz_atlas_app/view/components/custom_button/custom_button.dart';
import 'package:izz_atlas_app/view/components/custom_button/custom_button_two.dart';
import 'package:izz_atlas_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_text/custom_text.dart';

class BookYourSlotScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookYourSlotScreen> {
  DateTime _selectedDate = DateTime(2021, 7, 5);
  String _selectedTime = "07:00";
  String _selectedCourt = "05";

  final List<String> availableTimes = [
    "07:00",
    "02:00",
    "03:00",
    "04:00",
    "05:00",
  ];
  final List<String> availableCourts = ["05", "08", "10", "06", "04"];

  DateTime today = DateTime.now();
  late DateTime selectedDay;

  // Initialize selectedDay to the current day (or any default date)
  @override
  void initState() {
    super.initState();
    selectedDay = today; // Set a default date
  }

  void isSelected(DateTime day) {
    setState(() {
      selectedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Booking"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "BOOK YOUR SLOT",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              bottom: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xff111827),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TableCalendar(
                calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyle(color: AppColors.white),
                  todayDecoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(color: AppColors.white),
                  selectedDecoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(color: Colors.red),
                ),
                locale: "en_US",
                rowHeight: 43,
                headerStyle: HeaderStyle(
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.w,
                  ),
                  formatButtonVisible: false,
                  titleCentered: true,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Color(0xff111827),
                  ),
                  leftChevronIcon: Icon(
                    Icons.arrow_left,
                    color: Colors.white, // Set left arrow color to white
                  ),
                  rightChevronIcon: Icon(
                    Icons.arrow_right,
                    color: Colors.white, // Set right arrow color to white
                  ),
                ),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) =>
                    isSelected(focusedDay),
                focusedDay: selectedDay,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 10, 16),
              ),
            ),
            SizedBox(height: 20),
            // Calendar Widget (for date selection)
            CustomText(
              text: "AVAILABILITY",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              bottom: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: availableTimes.map((time) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTime = time;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _selectedTime == time
                            ? Colors.black
                            : Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        time,
                        style: TextStyle(
                          color: _selectedTime == time
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            CustomText(
              text: "COURT NUMBER",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              bottom: 20,
            ),
            Row(
              children: availableCourts.map((court) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCourt = court;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _selectedCourt == court
                          ? Colors.black
                          : Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      court,
                      style: TextStyle(
                        color: _selectedCourt == court
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            CustomButton(
              onTap: () {},
              title: "BOOK NOW",
              textColor: AppColors.white,
            ),
            SizedBox(height: 16),
            CustomButtonTwo(
              onTap: () {},
              textColor: AppColors.blue,
              title: "CHAT WITH VENDOR",
              isBorder: true,
              borderWidth: 1,
              fillColor: AppColors.white,
              borderColor: AppColors.blue,
            ),
          ],
        ),
      ),
    );
  }

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2021, 1),
      lastDate: DateTime(2022, 12),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
