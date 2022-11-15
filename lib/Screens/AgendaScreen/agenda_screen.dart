import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:esihapp/Screens/AgendaScreen/components/custom_button.dart';
import 'package:esihapp/Screens/SetBookingScreen/set_booking_screen.dart';
import 'package:esihapp/backend/database/ApiManager.dart';
import 'package:esihapp/backend/model/Slot.dart';
import 'package:esihapp/backend/model/TrancheHoraire.dart';
import 'package:esihapp/services/notification_service.dart';
import 'package:esihapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AgendaScreen extends StatefulWidget {
  final String specialite;
  const AgendaScreen({Key? key, required this.specialite}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedTime = "";
  List<Slot> timeSlots = <Slot>[];
  // ignore: prefer_typing_uninitialized_variables
  ApiManager api = ApiManager.instance;
  var notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    _selectedDate = DateTime.now();
    _getTimeSlots();
    notifyHelper = NotificationHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("L'agenda"),
          backgroundColor: kSecondaryColor,
        ),
        body: Column(
          children: [
            _headToday(),
            _dateTimeLine(),
            _displaySlotTime(),
          ],
        ));
  }

  _headToday() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        // ignore: avoid_unnecessary_containers
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text("Aujourd'hui", style: headingStyle),
            ],
          ),
        )
      ]),
    );
  }

  _dateTimeLine() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: kPrimaryColor,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 20, color: Colors.grey)),
        dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey)),
        monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey)),
        onDateChange: (date) async {
          setState(() {
            _selectedDate = date;
            _getTimeSlots();
          });

          print(_selectedDate);
          print(DateFormat("EEEE").format(date));
          // if (DateFormat("EEEE").format(date) == "Saturday") {
          //   List<TrancheHoraire> horaires =
          //       await api.getTranchesHorairesByJourNameAndSpecialite(
          //           "Samedi", widget.specialite);
          //   print("Heure fin");
          //   print(horaires[0].heureFin);
          //   print(horaires.toString());
          //   horaires.forEach((h) => {
          //         print(h.id),
          //       });
          // }
        },
      ),
    );
  }

  _displaySlotTime() {
    return Expanded(
      child: GridView.builder(
        itemCount: timeSlots.length,
        // itemCount: TIME_SLOTS.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              _selectedTime =
                  '${timeSlots.elementAt(index).heureDebut} - ${timeSlots.elementAt(index).heureFin}';
              // _selectedTime = TIME_SLOTS.elementAt(index);
            });
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SetBookingScreen(
                  selectedDate: _selectedDate,
                  selectedTime: _selectedTime,
                  specialite: widget.specialite);
            }));
          },
          child: Card(
            // color: _selectedTime == TIME_SLOTS.elementAt(index)
            color: _selectedTime ==
                    '${timeSlots.elementAt(index).heureDebut} - ${timeSlots.elementAt(index).heureFin}'
                ? Colors.white54
                : Colors.white,
            child: GridTile(
              // ignore: sort_child_properties_last
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ignore: unnecessary_string_interpolations
                    // Text('${TIME_SLOTS.elementAt(index)}'),
                    Text(
                        '${timeSlots.elementAt(index).heureDebut} - ${timeSlots.elementAt(index).heureFin}'),
                    const Text('Disponible'),
                  ],
                ),
              ),
              // header: _selectedTime == TIME_SLOTS.elementAt(index)
              header: _selectedTime ==
                      '${timeSlots.elementAt(index).heureDebut} - ${timeSlots.elementAt(index).heureDebut}'
                  ? const Icon(Icons.check)
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  // _getTime() async {
  //   List<TrancheHoraire> horaires = <TrancheHoraire>[];
  //   var ts = <String>[];

  //   if (DateFormat("EEEE").format(_selectedDate) == "Saturday") {
  //     horaires = await api.getTranchesHorairesByJourNameAndSpecialite(
  //         "Samedi", widget.specialite);
  //   } else if (DateFormat("EEEE").format(_selectedDate) == "Sunday") {
  //     horaires = await api.getTranchesHorairesByJourNameAndSpecialite(
  //         "Dimanche", widget.specialite);
  //   } else if (DateFormat("EEEE").format(_selectedDate) == "Monday") {
  //     horaires = await api.getTranchesHorairesByJourNameAndSpecialite(
  //         "Lundi", widget.specialite);
  //   } else if (DateFormat("EEEE").format(_selectedDate) == "Tuesday") {
  //     horaires = await api.getTranchesHorairesByJourNameAndSpecialite(
  //         "Mardi", widget.specialite);
  //   } else if (DateFormat("EEEE").format(_selectedDate) == "Wednesday") {
  //     horaires = await api.getTranchesHorairesByJourNameAndSpecialite(
  //         "Mercredi", widget.specialite);
  //   } else if (DateFormat("EEEE").format(_selectedDate) == "Thursday") {
  //     horaires = await api.getTranchesHorairesByJourNameAndSpecialite(
  //         "Jeudi", widget.specialite);
  //   } else if (DateFormat("EEEE").format(_selectedDate) == "Friday") {
  //     horaires = await api.getTranchesHorairesByJourNameAndSpecialite(
  //         "Vendredi", widget.specialite);
  //   }
  //   for (var h in horaires) {
  //     // print(h.id);
  //     var slots = _timeSlotSection(h.heureDebut, h.heureFin, h.id);
  //     for (var st in slots) {
  //       ts.add(st);
  //     }
  //   }
  //   setState(() {
  //     timeSlots = ts;
  //   });
  //   print("TimeSlots in gettime");
  //   print(timeSlots);
  // }

  _getTimeSlots() async {
    List<Slot> slots = <Slot>[];

    if (DateFormat("EEEE").format(_selectedDate) == "Saturday") {
      slots = await api.getSlotsBySpecialiteAndDay("Samedi", widget.specialite);
    } else if (DateFormat("EEEE").format(_selectedDate) == "Sunday") {
      slots =
          await api.getSlotsBySpecialiteAndDay("Dimanche", widget.specialite);
    } else if (DateFormat("EEEE").format(_selectedDate) == "Monday") {
      slots = await api.getSlotsBySpecialiteAndDay("Lundi", widget.specialite);
    } else if (DateFormat("EEEE").format(_selectedDate) == "Tuesday") {
      slots = await api.getSlotsBySpecialiteAndDay("Mardi", widget.specialite);
    } else if (DateFormat("EEEE").format(_selectedDate) == "Wednesday") {
      slots =
          await api.getSlotsBySpecialiteAndDay("Mercredi", widget.specialite);
    } else if (DateFormat("EEEE").format(_selectedDate) == "Thursday") {
      slots = await api.getSlotsBySpecialiteAndDay("Jeudi", widget.specialite);
    } else if (DateFormat("EEEE").format(_selectedDate) == "Friday") {
      slots =
          await api.getSlotsBySpecialiteAndDay("Vendredi", widget.specialite);
    }

    setState(() {
      timeSlots = slots;
    });
  }

  _timeSlotSection(DateTime heureDebut, DateTime heureFin, int jour) {
    List<String> l = <String>[];
    DateTime currentTime = heureDebut;
    do {
      var time2 = currentTime.add(const Duration(minutes: 30));
      var slot =
          '${DateFormat.Hm().format(currentTime)}-${DateFormat.Hm().format(time2)}J${jour}';
      currentTime = time2;
      l.add(slot);
    } while (heureFin != currentTime);
    print("Timeslots");
    print(l);

    return l;
  }
}
