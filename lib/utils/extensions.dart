extension MyExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  String capitalizeWords() {
    var words = this.split("");
    String finalWord = "";
    for (String word in words) {
      finalWord += "${word.capitalize()} ";
    }
    return finalWord;
  }

  String _getJourName() {
    String jour = "";
    if (this == "Saturday") {
      jour = "Samedi";
    } else if (this == "Sunday") {
      jour = "Dimanche";
    } else if (this == "Monday") {
      jour = "Lundi";
    } else if (this == "Tuesday") {
      jour = "Mardi";
    } else if (this == "Wednesday") {
      jour = "Mercredi";
    } else if (this == "Thursday") {
      jour = "Jeudi";
    } else if (this == "Friday") {
      jour = "Vendredi";
    }
    return jour;
  }
}
