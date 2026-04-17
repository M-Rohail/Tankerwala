enum UserRole { customer, tanker }

class UserModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final UserRole role;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'role': role.name,
    'createdAt': createdAt.toIso8601String(),
  };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    id: map['id'] ?? '',
    name: map['name'] ?? '',
    phone: map['phone'] ?? '',
    email: map['email'] ?? '',
    role: UserRole.values.firstWhere(
          (r) => r.name == map['role'],
      orElse: () => UserRole.customer,
    ),
    createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
  );
}