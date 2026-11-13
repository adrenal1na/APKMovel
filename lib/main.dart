import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ExploreMundoApp());
}

class ExploreMundoApp extends StatelessWidget {
  const ExploreMundoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore Mundo',
      debugShowCheckedModeBanner: false,
      home: const DestinationPage(),
    );
  }
}

class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  static const String _destination = 'Camping do Lago Oeschinen';
  static const String _location = 'Kandersteg, Suíça';

  bool _favorited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListView(
              children: [
                AspectRatio(
                  aspectRatio: 10 / 7,
                  child: Image.asset(
                    'images/lake.jpg',
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                    semanticLabel: 'Barracas com vista para o Lago Oeschinen',
                  ),
                ),
                _buildTitleSection(),
                _buildButtonSection(context),
                const Padding(
                  padding: EdgeInsets.all(28),
                  child: Text(
                    'O Lago Oeschinen fica aos pés do Blüemlisalp, nos Alpes '
                    'Berneses, a 1.578 metros de altitude. De Kandersteg, é '
                    'possível pegar um teleférico e seguir a pé por cerca de '
                    'meia hora, passando por pastagens e bosques de pinheiros. '
                    'No verão, dá para remar no lago ou descer de tobogã '
                    'perto da estação do teleférico.',
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 20),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _destination,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  _location,
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.star, color: Colors.red),
            isSelected: _favorited,
            tooltip: _favorited ? 'Remover dos favoritos' : 'Favoritar destino',
            onPressed: () {
              setState(() {
                _favorited = !_favorited;
              });
            },
          ),
          Text(_favorited ? '42' : '41'),
        ],
      ),
    );
  }

  Widget _buildButtonSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(Icons.call, 'CALL', () {
          _showMessage(context, 'Ligação para a agência simulada.');
        }),
        _buildButtonColumn(Icons.near_me, 'ROUTE', () {
          _showMessage(context, 'Ponto de partida da rota: Kandersteg, Suíça.');
        }),
        _buildButtonColumn(Icons.share, 'SHARE', () async {
          await Clipboard.setData(
            const ClipboardData(text: 'Conheça o $_destination em $_location!'),
          );
          if (context.mounted) {
            _showMessage(context, 'Destino copiado para compartilhar.');
          }
        }),
      ],
    );
  }

  Widget _buildButtonColumn(IconData icon, String label, VoidCallback onPressed) {
    return Flexible(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue.shade700,
          textStyle: const TextStyle(fontSize: 12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
