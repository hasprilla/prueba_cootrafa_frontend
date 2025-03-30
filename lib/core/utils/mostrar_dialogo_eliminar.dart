import 'package:flutter/material.dart';

void mostrarDialogoEliminar({
  required BuildContext context,
  required String nombreRegistro,
  required VoidCallback onConfirmar,
  String titulo = 'Confirmar eliminación',
  String mensaje = '¿Estás seguro de que quieres eliminar el registro',
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titulo),
        content: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(text: '$mensaje '),
              TextSpan(
                text: nombreRegistro,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: '?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Eliminar', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirmar();
            },
          ),
        ],
      );
    },
  );
}
