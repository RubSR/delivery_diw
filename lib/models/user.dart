class User {
  String? token;
  int? id;
  int? idCliente;

  User({this.token, this.id, this.idCliente});

  User.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    idCliente = json['idCliente'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    data['idCliente'] = this.idCliente;
    return data;
  }
}
