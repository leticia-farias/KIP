/// Modelo que representa um Pacote ou Plano de Serviço.
///
/// Este modelo espelha a estrutura enviada pelo backend Dart e
/// contém informações como nome, tipo, preço, descrição e características.
class Package {
  final String name;
  final String description;
  final String type;
  final double price;
  final String features;

  Package({
    required this.name,
    required this.description,
    required this.type,
    required this.price,
    required this.features,
  });

  /// Cria um [Package] a partir de um JSON.
  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      name: json['name'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      price: (json['price'] as num).toDouble(),
      features: json['features'] as String,
    );
  }

  /// Retorna uma string formatada para exibição no chat.
  String toChatString() {
    return '✅ **${name.toUpperCase()}**\n'
        'Tipo: ${type == 'mobile_data' ? 'Dados Móveis' : 'Internet Fixa'}\n'
        'Preço: R\$${price.toStringAsFixed(2)}\n'
        'Características: $features\n'
        'Descrição: $description';
  }
}