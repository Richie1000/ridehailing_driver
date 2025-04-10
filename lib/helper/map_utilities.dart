import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ridehailing_driver/helper/api_request_utils.dart';
import 'package:ridehailing_driver/helper/api_results.dart';
import 'package:ridehailing_driver/helper/secret.dart';
import 'package:ridehailing_driver/models/direction_details.dart';
import 'package:ridehailing_driver/models/geocode_address.dart';
import 'package:ridehailing_driver/models/prediction_model.dart';

class MapUtilities {
  static Future<ApiResult<GeocodeAddress>>
  convertCoordinatesIntoHumanReadableAddress(Position position) async {
    String geoCodingUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$GOOGLE_MAP_KEY";

    try {
      final response = await RequestUtils.receiveRequest(geoCodingUrl);

      if (response.statusCode == 200) {
        final results = response.data['results'];
        if (results != null && results.isNotEmpty) {
          String address = results[0]['formatted_address'];
          List<String> addressParts = address.split(", ");
          if (addressParts.first.contains("+")) {
            addressParts.removeAt(0);
          }
          address = addressParts.join(", ");

          final geocode =
              GeocodeAddress()
                ..humanReadableAddress = address
                ..placeName = address
                ..placeID = results[0]["place_id"]
                ..latitude = position.latitude
                ..longitude = position.longitude;

          return ApiSuccess(geocode);
        }
        return ApiFailure("No address found at the provided location.");
      }
      return ApiFailure("Failed to fetch address: ${response.error}");
    } catch (e) {
      return ApiFailure("Unexpected error: $e");
    }
  }

  static Future<ApiResult<List<PredictionModel>>> getPlaceAutocomplete(
    String input,
  ) async {
    String baseUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String url = '$baseUrl?input=$input&key=$map_api_key&components=country:GH';

    try {
      ApiResponse response = await RequestUtils.receiveRequest(url);

      if (response.statusCode == 200) {
        var data = response.data;
        if (data['status'] == 'OK') {
          List<PredictionModel> predictions =
              (data['predictions'] as List)
                  .map((item) => PredictionModel.fromJson(item))
                  .toList();
          return ApiSuccess(predictions);
        } else {
          return ApiFailure("Place API returned status: ${data['status']}");
        }
      }
      return ApiFailure("Network error: ${response.error}");
    } catch (e) {
      return ApiFailure("Unexpected error: $e");
    }
  }

  static Future<ApiResult<DirectionDetails>> getDirectionDetailsFromAPI(
    LatLng source,
    LatLng destination,
  ) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?destination=${Uri.encodeComponent(destination.latitude.toString())},${Uri.encodeComponent(destination.longitude.toString())}"
        "&origin=${Uri.encodeComponent(source.latitude.toString())},${Uri.encodeComponent(source.longitude.toString())}&key=$direction_api_key";

    try {
      ApiResponse response = await RequestUtils.receiveRequest(url);

      if (response.statusCode == 200 &&
          response.data["routes"] != null &&
          response.data["routes"].isNotEmpty) {
        var leg = response.data["routes"][0]["legs"][0];
        DirectionDetails details =
            DirectionDetails()
              ..distanceTextString = leg["distance"]["text"]
              ..durationTextString = leg["duration"]["text"]
              ..distanceValue = leg["distance"]["value"]
              ..durationValue = leg["duration"]["value"]
              ..polyLinePoints =
                  response.data["routes"][0]["overview_polyline"]["points"];

        return ApiSuccess(details);
      }
      return ApiFailure("No valid route found between the locations.");
    } catch (e) {
      return ApiFailure("Error retrieving directions: $e");
    }
  }

  static Future<ApiResult<GeocodeAddress>> getPlaceDetails(
    String placeID,
  ) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=$map_api_key';

    try {
      ApiResponse response = await RequestUtils.receiveRequest(url);

      if (response.statusCode == 200) {
        var results = response.data["result"];
        if (results != null && results.isNotEmpty) {
          GeocodeAddress place =
              GeocodeAddress()
                ..placeName = results["name"]
                ..latitude = results["geometry"]["location"]["lat"]
                ..longitude = results["geometry"]["location"]["lng"]
                ..placeID = placeID;

          return ApiSuccess(place);
        }
        return ApiFailure("No details found for the place ID: $placeID");
      }
      return ApiFailure("Failed API call: ${response.error}");
    } catch (e) {
      return ApiFailure("Error getting place details: $e");
    }
  }
}
