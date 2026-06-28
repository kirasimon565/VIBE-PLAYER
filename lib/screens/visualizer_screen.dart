import 'package:flutter/material.dart';

class VisualizerScreen extends StatelessWidget {
  const VisualizerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Visualizers'),
        backgroundColor: Colors.transparent,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildVisCard('Neural Paint', Colors.purple),
          _buildVisCard('Spectral Forest', Colors.green),
          _buildVisCard('Galaxy Mode', Colors.blue),
          _buildVisCard('Wave Cathedral', Colors.orange),
        ],
      ),
    );
  }

  Widget _buildVisCard(String name, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.5), width: 2),
      ),
      child: Center(
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
