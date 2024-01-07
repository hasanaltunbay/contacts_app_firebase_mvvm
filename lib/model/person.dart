class Person {
  String? id;
  String name;
  String phoneNumber;
  String email;

  Person(
    this.name,
    this.phoneNumber,
    this.email,
  );

  Person.fromMap(this.id, Map<String, dynamic> map)
      : name = map["name"],
        phoneNumber = map["phoneNumber"],
        email = map["email"];

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "phoneNumber": phoneNumber,
      "email": email,
    };
  }
}
