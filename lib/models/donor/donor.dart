class Donor {
  final String name;
  final String dob;
  final String blood;
  final int units;
  final String gender;
  final String location;
  final String email;

  Donor(this.name, this.dob, this.blood, this.units, this.gender, this.location,
      this.email);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "dob": dob,
      "blood": blood,
      "units": units,
      "gender": gender,
      "location": location,
      "email": email
    };
  }
}
