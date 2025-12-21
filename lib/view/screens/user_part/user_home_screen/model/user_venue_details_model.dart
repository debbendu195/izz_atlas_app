/// ================= RESPONSE =================
class VenueDetailsResponse {
  final bool success;
  final String message;
  final VenueDetails data;

  VenueDetailsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory VenueDetailsResponse.fromJson(Map<String, dynamic> json) {
    return VenueDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: VenueDetails.fromJson(json['data'] ?? {}),
    );
  }
}

/// ================= VENUE =================
class VenueDetails {
  final String id;
  final String venueName;
  final String sportsType;
  final int pricePerHour;
  final int capacity;
  final String location;
  final bool venueStatus;
  final String description;
  final String venueImage;
  final List<Amenity> amenities;
  final List<int> courtNumbers;
  final String everyServiceStatus;
  final String venueRating;
  final int venueReviewCount;
  final String createdAt;
  final String updatedAt;
  final String vendorId;
  final List<VenueAvailability> venueAvailabilities;

  VenueDetails({
    required this.id,
    required this.venueName,
    required this.sportsType,
    required this.pricePerHour,
    required this.capacity,
    required this.location,
    required this.venueStatus,
    required this.description,
    required this.venueImage,
    required this.amenities,
    required this.courtNumbers,
    required this.everyServiceStatus,
    required this.venueRating,
    required this.venueReviewCount,
    required this.createdAt,
    required this.updatedAt,
    required this.vendorId,
    required this.venueAvailabilities,
  });

  factory VenueDetails.fromJson(Map<String, dynamic> json) {
    return VenueDetails(
      id: json['id'] ?? '',
      venueName: json['venueName'] ?? '',
      sportsType: json['sportsType'] ?? '',
      pricePerHour: json['pricePerHour'] ?? 0,
      capacity: json['capacity'] ?? 0,
      location: json['location'] ?? '',
      venueStatus: json['venueStatus'] ?? false,
      description: json['description'] ?? '',
      venueImage: json['venueImage'] ?? '',
      amenities: json['amenities'] == null
          ? []
          : List<Amenity>.from(
        json['amenities'].map((x) => Amenity.fromJson(x)),
      ),
      courtNumbers: json['courtNumbers'] == null
          ? []
          : List<int>.from(json['courtNumbers']),
      everyServiceStatus: json['EveryServiceStatus'] ?? '',
      venueRating: json['venueRating'] ?? '0',
      venueReviewCount: json['venueReviewCount'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      vendorId: json['vendorId'] ?? '',
      venueAvailabilities: json['venueAvailabilities'] == null
          ? []
          : List<VenueAvailability>.from(
        json['venueAvailabilities']
            .map((x) => VenueAvailability.fromJson(x)),
      ),
    );
  }
}

/// ================= AMENITY =================
class Amenity {
  final String amenityName;

  Amenity({required this.amenityName});

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      amenityName: json['amenityName'] ?? '',
    );
  }
}

/// ================= AVAILABILITY =================
class VenueAvailability {
  final String id;
  final String day;
  final String createdAt;
  final String venueId;
  final List<ScheduleSlot> scheduleSlots;

  VenueAvailability({
    required this.id,
    required this.day,
    required this.createdAt,
    required this.venueId,
    required this.scheduleSlots,
  });

  factory VenueAvailability.fromJson(Map<String, dynamic> json) {
    return VenueAvailability(
      id: json['id'] ?? '',
      day: json['day'] ?? '',
      createdAt: json['createdAt'] ?? '',
      venueId: json['venueId'] ?? '',
      scheduleSlots: json['scheduleSlots'] == null
          ? []
          : List<ScheduleSlot>.from(
        json['scheduleSlots']
            .map((x) => ScheduleSlot.fromJson(x)),
      ),
    );
  }
}

/// ================= SLOT =================
class ScheduleSlot {
  final String id;
  final String from;
  final String to;
  final String venueId;
  final String availableVenueId;

  ScheduleSlot({
    required this.id,
    required this.from,
    required this.to,
    required this.venueId,
    required this.availableVenueId,
  });

  factory ScheduleSlot.fromJson(Map<String, dynamic> json) {
    return ScheduleSlot(
      id: json['id'] ?? '',
      from: json['from'] ?? '',
      to: json['to'] ?? '',
      venueId: json['venueId'] ?? '',
      availableVenueId: json['availableVenueId'] ?? '',
    );
  }
}
