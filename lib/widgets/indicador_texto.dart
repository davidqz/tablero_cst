import 'package:flutter/material.dart';

class IndicadorTexto extends StatelessWidget {
  IndicadorTexto({required this.titulo, required this.valor});

  final String titulo;
  final String valor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              titulo,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Text(
                  valor,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
