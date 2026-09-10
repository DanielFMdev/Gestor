import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gestor_ahorro_app/movimientos.dart';

class GestorScreen extends StatefulWidget {
  const GestorScreen({super.key});

  @override
  State<GestorScreen> createState() => _GestorScreenState();
}

class _GestorScreenState extends State<GestorScreen> {
  
  List<Movimiento> movimientos = [];

  final TextEditingController _controllerConcepto = TextEditingController();
  final TextEditingController _controllerCantidad = TextEditingController();
  final TextEditingController _controllerEsIngreso = TextEditingController();

  Future<void> _guardarMovimientos() async {
    final guardarMovimientos = await SharedPreferences.getInstance();

    List<String> movimientosAsString = movimientos.map((movimiento) => jsonEncode(movimiento.toJson())).toList();

    await guardarMovimientos.setStringList("mis_movimientos", movimientosAsString);
  }

  Future<void> _cargarMovimientos() async {
    final preferencias = await SharedPreferences.getInstance();

    final movimientosGuardados = preferencias.getStringList("mis_movimientos");

    if (movimientosGuardados != null) {
      setState(() {
        movimientos.clear();

        movimientos.addAll(
          movimientosGuardados.map((movimiento) => Movimiento.fromJson(jsonDecode((movimiento)))).toList()
        );
      });
    } 
  }

  @override
  void initState() {
    super.initState();
    _cargarMovimientos();
  }

  void _eliminarMovimiento(String concepto) {

    setState(() {
      if (concepto.isNotEmpty) {
        movimientos.removeWhere((m) => m.concepto == concepto);
      }
    });

  }

  void _agregarMovimiento(String concepto, double cantidad, bool esIngreso) {
   
    setState(() {
      if (concepto.isNotEmpty) {
        movimientos.add(Movimiento(concepto: concepto, cantidad: cantidad, esIngreso: esIngreso));
      }
    });

  }

  double get saldoTotal {
    double total = 0;
    for (var m in movimientos) {
      if (m.esIngreso) {
        total += m.cantidad;
      } else {
        total -= m.cantidad;
      }
    }
    return total;
  }

  @override
  void dispose() {
    _controllerCantidad.dispose();
    _controllerConcepto.dispose();
    _controllerEsIngreso.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Gestor Ahorro"),
      ),

      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          showDialog (
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Nuevo Movimiento"),
                content: Column(
                  children: [

                    CustomTextField(
                      controller: _controllerConcepto,
                      label: InputDecoration(label: Text("Concepto")),
                    ),

                    const SizedBox(height: 25),

                    CustomTextField(
                      controller: _controllerCantidad,
                      keyboardType: TextInputType.number,
                      label: InputDecoration(label: Text("Cantidad")),
                    ),

                    const SizedBox(height: 25),

                    CustomTextField(
                      controller: _controllerEsIngreso, 
                      label: InputDecoration(label: Text("¿Es un ingreso? (true / false)")),
                    ),
                  ],
                ),

                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            final String concepto = _controllerConcepto.text.trim().toUpperCase();
                            final double cantidad = double.tryParse(_controllerCantidad.text.trim()) ?? 0.0;
                            final esIngreso = _controllerEsIngreso.text.trim().toLowerCase() == "true";

                            _agregarMovimiento(concepto, cantidad, esIngreso);
                            _guardarMovimientos();
                            
                            _controllerConcepto.clear();
                            _controllerCantidad.clear();
                            _controllerEsIngreso.clear();

                            Navigator.pop(context);
                          });
                        }, 
                        child: Text("Agregar")
                      ),

                      TextButton(
                        onPressed: () {

                          _controllerConcepto.clear();
                          _controllerCantidad.clear();
                          _controllerEsIngreso.clear();
                                
                          Navigator.pop(context);
                        }, 
                        child: Text("Salir"),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },

        icon: Icon(Icons.add),

      ),
        
      body: Column(
        children: [

          Text(
            "Saldo: ${saldoTotal.toStringAsFixed(2)} €",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),  
          ),

          Expanded(
            child: ListView.builder(
              itemCount: movimientos.length,
              itemBuilder: (context, index) {
                final movimiento = movimientos[index];
                return ListTile(
                  title: Text(
                    movimiento.concepto, 
                    style: TextStyle(fontWeight: FontWeight.w500)
                  ),
                  trailing: Text(
                    "${movimiento.cantidad.toStringAsFixed(2)} €", 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
                  ),
                  leading: Icon(
                    movimiento.esIngreso ? Icons.expand_less : Icons.expand_more,
                    color: movimiento.esIngreso ? Colors.green : Colors.red
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 25),
            child: IconButton(
              onPressed: () {

                showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Eliminar concepto"),
                      content: CustomTextField(
                        controller: _controllerConcepto,
                        label: InputDecoration(label: Text("Concepto a eliminar")),
                      ),

                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _eliminarMovimiento(_controllerConcepto.text.trim().toUpperCase());
                              _guardarMovimientos();
                              
                              _controllerConcepto.clear();

                              Navigator.pop(context);
                            });
                          }, 

                          child: Text("Eliminar")

                        ),
                      ],
                    );
                  },
                );
              },

              icon: Icon(Icons.delete, color: Colors.red),

            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final InputDecoration label;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      autofocus: true,
      autocorrect: true,
      decoration: label,
    );
    
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;

  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: icon,
    );
  }
}
