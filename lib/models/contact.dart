class Contact{

  String firstName = "";
  String lastName = "";
  String companyName = "";
  String role = "";
  String notes = "";

  Contact(this.firstName, this.lastName, this.companyName, this.role, this.notes);

  Contact.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        companyName = json['companyName'],
        role = json['role'],
        notes = json['notes'];

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'companyName': companyName,
    'role': role,
    'notes': notes,
  };

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Contact &&
      this.runtimeType == other.runtimeType && this.firstName == other.firstName && this. role == other.role
        && this.companyName == other.companyName && this.notes == other.notes;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^ lastName.hashCode ^ companyName.hashCode;
  }
}

