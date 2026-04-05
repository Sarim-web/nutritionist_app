class Profile {
  final String id;
  final String name;
  final String? avatarPath;

  Profile({
    required this.id,
    required this.name,
    this.avatarPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'avatarPath': avatarPath,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      name: map['name'],
      avatarPath: map['avatarPath'],
    );
  }
}
