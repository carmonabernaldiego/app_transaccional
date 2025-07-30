class UserModel {
  final String curp;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String email;
  final String? role;
  final String? rfc;
  final String? cedulaProfesional;
  final String? telefono;
  final Map<String, dynamic>? permisosPrescripcion;
  final Map<String, dynamic>? declaracionTerminos;
  final String? fechaNacimiento;
  final String? domicilio;
  final String? imagen;
  final bool? isTwoFactorEnable;

  UserModel({
    required this.curp,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.email,
    this.role,
    this.rfc,
    this.cedulaProfesional,
    this.telefono,
    this.permisosPrescripcion,
    this.declaracionTerminos,
    this.fechaNacimiento,
    this.domicilio,
    this.imagen,
    this.isTwoFactorEnable,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      curp: json['curp'] ?? '',
      nombre: json['nombre'] ?? '',
      apellidoPaterno: json['apellidoPaterno'] ?? '',
      apellidoMaterno: json['apellidoMaterno'] ?? '',
      email: json['email'] ?? '',
      role: json['role'],
      rfc: json['rfc'],
      cedulaProfesional: json['cedulaProfesional'],
      telefono: json['telefono'],
      permisosPrescripcion: json['permisosPrescripcion'],
      declaracionTerminos: json['declaracionTerminos'],
      fechaNacimiento: json['fechaNacimiento'],
      domicilio: json['domicilio'],
      imagen: json['imagen'],
      isTwoFactorEnable: json['isTwoFactorEnable'],
    );
  }
}
