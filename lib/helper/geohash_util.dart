// Based on standard Base32 geohash spec
const _base32 = '0123456789bcdefghjkmnpqrstuvwxyz';

String encodeGeohash(double lat, double lon, {int precision = 7}) {
  final latRange = [-90.0, 90.0];
  final lonRange = [-180.0, 180.0];

  var isEven = true;
  int bit = 0;
  int ch = 0;
  String geohash = '';

  while (geohash.length < precision) {
    double mid;
    if (isEven) {
      mid = (lonRange[0] + lonRange[1]) / 2;
      if (lon > mid) {
        ch |= 1 << (4 - bit);
        lonRange[0] = mid;
      } else {
        lonRange[1] = mid;
      }
    } else {
      mid = (latRange[0] + latRange[1]) / 2;
      if (lat > mid) {
        ch |= 1 << (4 - bit);
        latRange[0] = mid;
      } else {
        latRange[1] = mid;
      }
    }

    isEven = !isEven;
    if (bit < 4) {
      bit++;
    } else {
      geohash += _base32[ch];
      bit = 0;
      ch = 0;
    }
  }

  return geohash;
}

/// Get all 8 neighbor geohashes of a center hash
List<String> geohashNeighbors(String hash) {
  // Brute-force neighbors: shift lat/lng slightly and encode again
  final decoded = decodeBoundingBox(hash);
  final lat = (decoded['minLat']! + decoded['maxLat']!) / 2;
  final lon = (decoded['minLon']! + decoded['maxLon']!) / 2;
  final latErr = (decoded['maxLat']! - decoded['minLat']!) / 2;
  final lonErr = (decoded['maxLon']! - decoded['minLon']!) / 2;

  final neighbors = <String>[];
  for (int dLat = -1; dLat <= 1; dLat++) {
    for (int dLon = -1; dLon <= 1; dLon++) {
      if (dLat == 0 && dLon == 0) continue;
      neighbors.add(
        encodeGeohash(
          lat + dLat * latErr * 2,
          lon + dLon * lonErr * 2,
          precision: hash.length,
        ),
      );
    }
  }
  return neighbors;
}

Map<String, double> decodeBoundingBox(String geohash) {
  final latRange = [-90.0, 90.0];
  final lonRange = [-180.0, 180.0];
  var isEven = true;

  for (int i = 0; i < geohash.length; i++) {
    final ch = geohash[i];
    int bits = _base32.indexOf(ch);
    for (int mask = 16; mask != 0; mask >>= 1) {
      if (isEven) {
        _refineInterval(lonRange, (bits & mask) != 0);
      } else {
        _refineInterval(latRange, (bits & mask) != 0);
      }
      isEven = !isEven;
    }
  }

  return {
    'minLat': latRange[0],
    'maxLat': latRange[1],
    'minLon': lonRange[0],
    'maxLon': lonRange[1],
  };
}

void _refineInterval(List<double> range, bool bitIsOne) {
  final mid = (range[0] + range[1]) / 2;
  if (bitIsOne) {
    range[0] = mid;
  } else {
    range[1] = mid;
  }
}
