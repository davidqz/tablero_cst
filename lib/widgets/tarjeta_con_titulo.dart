import 'package:flutter/material.dart';

class TarjetaConTitulo extends StatelessWidget {
  const TarjetaConTitulo({
    required this.titulo,
    this.texto,
    this.widget,
    this.seExpande = true,
    this.flex = 1,
    Key? key,
  }) : super(key: key);

  final String titulo;
  final String? texto;
  final Widget? widget;
  final bool seExpande;
  final int flex;

  @override
  Widget build(BuildContext context) {
    final tarjeta = Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment:
            seExpande ? CrossAxisAlignment.stretch : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              titulo,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: texto != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        texto!,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    )
                  : widget,
            ),
          ),
        ],
      ),
    );
    return seExpande
        ? Expanded(child: tarjeta, flex: flex)
        : Container(child: tarjeta);
  }
}
