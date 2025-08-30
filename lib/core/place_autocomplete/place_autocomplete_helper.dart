import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';

import '../utils/logger_util.dart';

class AutoCompleteHelper {
  static AddressModel extractAddressFromPrediction(Prediction prediction) {
    final structuredFormatting = prediction.structuredFormatting;

    // Extract main text and secondary text
    final String mainText = structuredFormatting?.mainText ?? '';
    final String secondaryText = structuredFormatting?.secondaryText ?? '';

    // Extract city, state, and country from terms
    String city = '';
    String state = '';
    String country = '';

    // String description = prediction.description ?? '';

    List<String> addressComponents = secondaryText.split(", ");
    try {
      country = addressComponents[addressComponents.length - 1];
      state = addressComponents[addressComponents.length - 2];
      city = addressComponents[addressComponents.length - 3];
    } catch (e) {
      logger.i(e);
    }

    // Extract postal code from secondary text
    final List<String> secondaryTextParts = secondaryText.split(', ');
    String postalCode = '';
    if (secondaryTextParts.length > 1) {
      postalCode = secondaryTextParts[secondaryTextParts.length - 2];
    }

    return AddressModel(
      address: '$mainText, $secondaryText',
      city: city,
      state: state,
      country: country,
      latitude: prediction.lat ?? '0',
      longitude: prediction.lng ?? '0',
      postalCode: postalCode,
    );
  }

// Future<Map<String, dynamic>> _fetchPlaceDetails(String placeId) async {
//   final url =
//       "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=${NetworkConstant.googleAPIKey}";
//
//   final response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     return json.decode(response.body);
//   } else {
//     throw Exception('Failed to fetch place details');
//   }
// }
}

class AddressModel {
  final String address;
  final String city;
  final String state;
  final String country;
  final String latitude;
  final String longitude;
  final String postalCode;

  AddressModel({
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.postalCode,
  });

  @override
  String toString() {
    return 'AddressModel { address: $address, city: $city, state: $state, country: $country, latitude: $latitude, longitude: $longitude, postalCode: $postalCode }';
  }

  AddressModel copyWith({
    String? address,
    String? city,
    String? state,
    String? country,
    String? latitude,
    String? longitude,
    String? postalCode,
  }) {
    return AddressModel(
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      postalCode: postalCode ?? this.postalCode,
    );
  }
}
