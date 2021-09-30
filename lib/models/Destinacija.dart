class Destination {
  Destination.create(
      {required this.id,
      required this.destination,
      required this.price,
      required this.description});

  final String id;
  final String destination;
  final int price;
  final String description;
}