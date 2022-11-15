// ignore: file_names
class Slot {
  Slot({id, heureDebut, heureFin});
  int id = 0;
  String heureDebut = "";
  String heureFin = "";

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "heureDebut": heureDebut,
      "heureFin": heureFin,
    };
  }

  factory Slot.fromMap(Map roleMap) {
    return Slot(
      id: roleMap['id'],
      heureDebut: roleMap['heureDebut'],
      heureFin: roleMap['heureFin'],
    );
  }
}
