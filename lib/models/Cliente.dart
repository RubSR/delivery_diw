class Cliente {
  int? id;
  String? nombre;
  String? apellidos;
  int? telefono;
  List<Direcciones>? direcciones;

  Cliente(
      {this.id, this.nombre, this.apellidos, this.telefono, this.direcciones});

  Cliente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    apellidos = json['apellidos'];
    telefono = json['telefono'];
    if (json['direcciones'] != null) {
      direcciones = <Direcciones>[];
      json['direcciones'].forEach((v) {
        direcciones!.add(new Direcciones.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['apellidos'] = this.apellidos;
    data['telefono'] = this.telefono;
    if (this.direcciones != null) {
      data['direcciones'] = this.direcciones!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Direcciones {
  int? id;
  String? calle;
  String? numero;
  String? puertaPisoEscalera;
  int? codPostal;
  Municipio? municipio;
  Provincia? provincia;

  Direcciones(
      {this.id,
        this.calle,
        this.numero,
        this.puertaPisoEscalera,
        this.codPostal,
        this.municipio,
        this.provincia});

  Direcciones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    calle = json['calle'];
    numero = json['numero'];
    puertaPisoEscalera = json['puertaPisoEscalera'];
    codPostal = json['codPostal'];
    municipio = json['municipio'] != null
        ? new Municipio.fromJson(json['municipio'])
        : null;
    provincia = json['provincia'] != null
        ? new Provincia.fromJson(json['provincia'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['calle'] = this.calle;
    data['numero'] = this.numero;
    data['puertaPisoEscalera'] = this.puertaPisoEscalera;
    data['codPostal'] = this.codPostal;
    if (this.municipio != null) {
      data['municipio'] = this.municipio!.toJson();
    }
    if (this.provincia != null) {
      data['provincia'] = this.provincia!.toJson();
    }
    return data;
  }
}

class Municipio {
  int? id;
  String? municipio;

  Municipio({this.id, this.municipio});

  Municipio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    municipio = json['municipio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['municipio'] = this.municipio;
    return data;
  }
}

class Provincia {
  int? id;
  String? provincia;

  Provincia({this.id, this.provincia});

  Provincia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provincia = json['provincia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provincia'] = this.provincia;
    return data;
  }
}
