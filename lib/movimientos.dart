class Movimiento {
  final String concepto;
  final double cantidad;
  final bool esIngreso;

  Movimiento({
    required this.concepto,
    required this.cantidad,
    required this.esIngreso,
  });

  factory Movimiento.fromJson(Map<String, dynamic> json) {
    return Movimiento(
      concepto: json['concepto'], 
      cantidad: (json['cantidad'] as num).toDouble(),
      esIngreso: json['esIngreso']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'concepto': concepto,
      'cantidad': cantidad,
      'esIngreso': esIngreso,
    };
  }
}