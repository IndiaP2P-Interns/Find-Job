class ProfileEntity {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String about;
  final List<String> skills;
  final String? resumePath;

  ProfileEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.about,
    required this.skills,
    this.resumePath,
  });

  ProfileEntity copyWith({
    String? id,
    String? name,
    String? phone,
    String? address,
    String? about,
    List<String>? skills,
    String? resumePath,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      about: about ?? this.about,
      skills: skills ?? this.skills,
      resumePath: resumePath ?? this.resumePath,
    );
  }
}
