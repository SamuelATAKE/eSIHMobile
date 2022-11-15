class Role {
  Role({id, titre});
  int id = 0;
  String titre = "";

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "titre": titre,
    };
  }

  factory Role.fromMap(Map roleMap) {
    return Role(
      id: roleMap['id'],
      titre: roleMap['titre'],
    );
  }
}
