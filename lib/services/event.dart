class Event {
  final int id;
  final String title;
  final String description;
  final String eventDate;
  final String eventTime;
  final String location;
  final String type;
  final int organizerId;
  final double price;
  final int maxRegistrations;
  final int sportId;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.eventDate,
    required this.eventTime,
    required this.location,
    required this.type,
    required this.organizerId,
    required this.price,
    required this.maxRegistrations,
    required this.sportId,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      eventDate: json['event_date'],
      eventTime: json['event_time'],
      location: json['location'],
      type: json['type'],
      organizerId: json['organizer_id'],
      // Safely handle price conversion
      price: json['price'] != null ? double.tryParse(json['price'].toString()) ?? 0.0 : 0.0,
      maxRegistrations: json['max_registrations'],
      sportId: json['sport_id'],
    );
  }
}
