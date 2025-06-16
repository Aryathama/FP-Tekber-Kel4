enum Gender { female, male }

class UserProfile {
  final Gender? gender;
  final int? age;
  final int? weight; // in kg
  final int? height; // in cm

  UserProfile({
    this.gender,
    this.age,
    this.weight,
    this.height,
  });

  // Utility method to create a new UserProfile with updated fields
  UserProfile copyWith({
    Gender? gender,
    int? age,
    int? weight,
    int? height,
  }) {
    return UserProfile(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
    );
  }

  @override
  String toString() {
    return 'UserProfile(gender: $gender, age: $age, weight: $weight, height: $height)';
  }
}