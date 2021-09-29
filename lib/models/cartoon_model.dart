import 'dart:convert';

class CartoonModel {
  final String name;
  final String cover;
  final String pdf;
  final int order;
  CartoonModel({
    this.name,
    this.cover,
    this.pdf,
    this.order,
  });

  CartoonModel copyWith({
    String name,
    String cover,
    String pdf,
    int order,
  }) {
    return CartoonModel(
      name: name ?? this.name,
      cover: cover ?? this.cover,
      pdf: pdf ?? this.pdf,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cover': cover,
      'pdf': pdf,
      'order': order,
    };
  }

  factory CartoonModel.fromMap(Map<String, dynamic> map) {
    return CartoonModel(
      name: map['name'],
      cover: map['cover'],
      pdf: map['pdf'],
      order: map['order'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartoonModel.fromJson(String source) => CartoonModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartoonModel(name: $name, cover: $cover, pdf: $pdf, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CartoonModel &&
      other.name == name &&
      other.cover == cover &&
      other.pdf == pdf &&
      other.order == order;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      cover.hashCode ^
      pdf.hashCode ^
      order.hashCode;
  }
}
