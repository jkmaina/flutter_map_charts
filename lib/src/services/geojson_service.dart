import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_map_charts/src/models/state_data_model.dart';
import 'package:flutter_map_charts/src/models/country_data_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';

class GeoJsonService {
  final Logger logger = Logger(); // Create a Logger instance
  List<dynamic> _geoJsonStateData = []; // Parsed GeoJSON data for states
  List<dynamic> _geoJsonCountryData = []; // Parsed GeoJSON data for countries

  GeoJsonService();

  Future<void> _loadGeoJsonData() async {
    try {
      String geoJsonStateString =
          await rootBundle.loadString('data/admin1.geojson');
      _geoJsonStateData = json.decode(geoJsonStateString)['features'];
      logger.i('State GeoJSON data loaded successfully');

      String geoJsonCountryString =
          await rootBundle.loadString('data/countries.geojson');
      _geoJsonCountryData = json.decode(geoJsonCountryString)['features'];
      logger.i('Country GeoJSON data loaded successfully');
    } catch (e) {
      logger.e('Error loading GeoJSON data: $e');
    }
  }

  // Ensures that the GeoJSON data is loaded before performing operations on it
  Future<void> _ensureDataLoaded() async {
    if (_geoJsonStateData.isEmpty) {
      await _loadGeoJsonData();
    }
  }

  // Predefined data map f
  //or states
  final Map<String, double> _stateValues = {
    // ... (populate with state ID and corresponding values)
    // For example, you could use a map to determine the value for a state
    // based on its id
    'USA-AL': 1,
    'USA-AK': 2,
    'USA-AZ': 3,
    'USA-AR': 4,
    'USA-CA': 5,
    'USA-CO': 6,
    'USA-CT': 7,
    'USA-DE': 8,
    'USA-FL': 9,
    'USA-GA': 10,
    'USA-HI': 11,
    'USA-ID': 12,
    'USA-IL': 13,
    'USA-IN': 14,
    'USA-IA': 15,
    'USA-KS': 16,
    'USA-KY': 17,
    'USA-LA': 18,
    'USA-ME': 19,
    'USA-MD': 20,
    'USA-MA': 21,
    'USA-MI': 22,
    'USA-MN': 23,
    'USA-MS': 24,
    'USA-MO': 25,
    'USA-MT': 26,
    'USA-NE': 27,
    'USA-NV': 28,
    'USA-NH': 29,
    'USA-NJ': 30,
    'USA-NM': 31,
    'USA-NY': 32,
    'USA-NC': 33,
    'USA-ND': 34,
    'USA-OH': 35,
    'USA-OK': 36,
    'USA-OR': 37,
    'USA-PA': 38,
    'USA-RI': 39,
    'USA-SC': 40,
    'USA-SD': 41,
    'USA-TN': 42,
    'USA-TX': 43,
    'USA-UT': 44,
    'USA-VT': 45,
    'USA-VA': 46,
    'USA-WA': 47,
    'USA-WV': 48,
    'USA-WI': 49,
    'USA-WY': 50,
  };

  final Map<String, double> _countryValues = {
    'AFG': 004,
    'ALA': 248,
    'ALB': 008,
    'DZA': 012,
    'ASM': 016,
    'AND': 020,
    'AGO': 024,
    'AIA': 660,
    'ATA': 010,
    'ATG': 028,
    'ARG': 032,
    'ARM': 051,
    'ABW': 533,
    'AUS': 036,
    'AUT': 040,
    'AZE': 031,
    'BHS': 044,
    'BHR': 048,
    'BGD': 050,
    'BRB': 052,
    'BLR': 112,
    'BEL': 056,
    'BLZ': 084,
    'BEN': 204,
    'BMU': 060,
    'BTN': 064,
    'BOL': 068,
    'BES': 535,
    'BIH': 070,
    'BWA': 072,
    'BVT': 074,
    'BRA': 076,
    'IOT': 086,
    'BRN': 096,
    'BGR': 100,
    'BFA': 854,
    'BDI': 108,
    'CPV': 132,
    'KHM': 116,
    'CMR': 120,
    'CAN': 124,
    'CYM': 136,
    'CAF': 140,
    'TCD': 148,
    'CHL': 152,
    'CHN': 156,
    'CXR': 162,
    'CCK': 166,
    'COL': 170,
    'COM': 174,
    'COG': 178,
    'COD': 180,
    'COK': 184,
    'CRI': 188,
    'CIV': 384,
    'HRV': 191,
    'CUB': 192,
    'CUW': 531,
    'CYP': 196,
    'CZE': 203,
    'DNK': 208,
    'DJI': 262,
    'DMA': 212,
    'DOM': 214,
    'ECU': 218,
    'EGY': 818,
    'SLV': 222,
    'GNQ': 226,
    'ERI': 232,
    'EST': 233,
    'SWZ': 748,
    'ETH': 231,
    'FLK': 238,
    'FRO': 234,
    'FJI': 242,
    'FIN': 246,
    'FRA': 250,
    'GUF': 254,
    'PYF': 258,
    'ATF': 260,
    'GAB': 266,
    'GMB': 270,
    'GEO': 268,
    'DEU': 276,
    'GHA': 288,
    'GIB': 292,
    'GRC': 300,
    'GRL': 304,
    'GRD': 308,
    'GLP': 312,
    'GUM': 316,
    'GTM': 320,
    'GGY': 831,
    'GIN': 324,
    'GNB': 624,
    'GUY': 328,
    'HTI': 332,
    'HMD': 334,
    'VAT': 336,
    'HND': 340,
    'HKG': 344,
    'HUN': 348,
    'ISL': 352,
    'IND': 356,
    'IDN': 360,
    'IRN': 364,
    'IRQ': 368,
    'IRL': 372,
    'IMN': 833,
    'ISR': 376,
    'ITA': 380,
    'JAM': 388,
    'JPN': 392,
    'JEY': 832,
    'JOR': 400,
    'KAZ': 398,
    'KEN': 404,
    'KIR': 296,
    'PRK': 408,
    'KOR': 410,
    'KWT': 414,
    'KGZ': 417,
    'LAO': 418,
    'LVA': 428,
    'LBN': 422,
    'LSO': 426,
    'LBR': 430,
    'LBY': 434,
    'LIE': 438,
    'LTU': 440,
    'LUX': 442,
    'MAC': 446,
    'MDG': 450,
    'MWI': 454,
    'MYS': 458,
    'MDV': 462,
    'MLI': 466,
    'MLT': 470,
    'MHL': 584,
    'MTQ': 474,
    'MRT': 478,
    'MUS': 480,
    'MYT': 175,
    'MEX': 484,
    'FSM': 583,
    'MDA': 498,
    'MCO': 492,
    'MNG': 496,
    'MNE': 499,
    'MSR': 500,
    'MAR': 504,
    'MOZ': 508,
    'MMR': 104,
    'NAM': 516,
    'NRU': 520,
    'NPL': 524,
    'NLD': 528,
    'NCL': 540,
    'NZL': 554,
    'NIC': 558,
    'NER': 562,
    'NGA': 566,
    'NIU': 570,
    'NFK': 574,
    'MKD': 807,
    'MNP': 580,
    'NOR': 578,
    'OMN': 512,
    'PAK': 586,
    'PLW': 585,
    'PSE': 275,
    'PAN': 591,
    'PNG': 598,
    'PRY': 600,
    'PER': 604,
    'PHL': 608,
    'PCN': 612,
    'POL': 616,
    'PRT': 620,
    'PRI': 630,
    'QAT': 634,
    'REU': 638,
    'ROU': 642,
    'RUS': 643,
    'RWA': 646,
    'BLM': 652,
    'SHN': 654,
    'KNA': 659,
    'LCA': 662,
    'MAF': 663,
    'SPM': 666,
    'VCT': 670,
    'WSM': 882,
    'SMR': 674,
    'STP': 678,
    'SAU': 682,
    'SEN': 686,
    'SRB': 688,
    'SYC': 690,
    'SLE': 694,
    'SGP': 702,
    'SXM': 534,
    'SVK': 703,
    'SVN': 705,
    'SLB': 090,
    'SOM': 706,
    'ZAF': 710,
    'SGS': 239,
    'SSD': 728,
    'ESP': 724,
    'LKA': 144,
    'SDN': 729,
    'SUR': 740,
    'SJM': 744,
    'SWE': 752,
    'CHE': 756,
    'SYR': 760,
    'TWN': 158,
    'TJK': 762,
    'TZA': 834,
    'THA': 764,
    'TLS': 626,
    'TGO': 768,
    'TKL': 772,
    'TON': 776,
    'TTO': 780,
    'TUN': 788,
    'TUR': 792,
    'TKM': 795,
    'TCA': 796,
    'TUV': 798,
    'UGA': 800,
    'UKR': 804,
    'ARE': 784,
    'GBR': 826,
    'USA': 840,
    'UMI': 581,
    'URY': 858,
    'UZB': 860,
    'VUT': 548,
    'VEN': 862,
    'VNM': 704,
    'VGB': 092,
    'VIR': 850,
    'WLF': 876,
    'ESH': 732,
    'YEM': 887,
    'ZMB': 894,
    'ZWE': 716,
  };

  // Method to determine the value for a state based on its ID
  double _determineValueForState(String id) {
    return _stateValues[id] ?? 0.0; // Default to 0.0 if state ID not found
  }

  // Method to determine the value for a country based on its ISO code
  double _determineValueForCountry(String isoCode) {
    return _countryValues[isoCode] ?? 0.0;
  }

  // Method to load and parse state data from GeoJSON
  Future<List<StateDataModel>> loadStatesFromGeoJson() async {
    await _ensureDataLoaded();
    List<StateDataModel> states = [];

    for (var feature in _geoJsonStateData) {
      var properties = feature['properties'];
      var countryCode = properties['ISO3166-1-Alpha-3'];

      // Only include features that are part of the US
      if (countryCode == 'USA') {
        var id = properties['id'] ?? properties['ISO3166-1-Alpha-3'];
        var name = properties['name'] ?? '';
        var coordinates = _extractCoordinates(feature['geometry']);

        states.add(StateDataModel(
          id: id,
          value: _determineValueForState(
              id), // This should be a method that determines the value
          label: name,
          points: coordinates,
        ));
      }
    }

    logger.i('Loaded ${states.length} states from GeoJSON');
    return states;
  }

  // Method to load and parse country data from GeoJSON
  Future<List<CountryDataModel>> loadCountriesFromGeoJson() async {
    await _ensureDataLoaded();

    List<CountryDataModel> countries = [];
    for (var feature in _geoJsonCountryData) {
      var properties = feature['properties'];
      var isoCode = properties['ISO_A3']; // ISO Alpha-3 country code
      var name = properties['ADMIN']; // Country name
      var coordinates = _extractCoordinates(feature['geometry']);

      countries.add(CountryDataModel(
          isoCode: isoCode,
          name: name,
          points: coordinates,
          value: _determineValueForCountry(isoCode)));
    }
    logger.i('Loaded ${countries.length} countries from GeoJSON');
    return countries;
  }

  // Helper method to extract LatLng points from GeoJSON geometry
  List<LatLng> _extractCoordinates(Map<String, dynamic> geometry) {
    var type = geometry['type'];
    var coords = geometry['coordinates'];

    List<LatLng> coordinates = [];

    try {
      if (type == 'Polygon') {
        for (var coord in coords[0]) {
          // Assuming the first array contains the polygon points
          coordinates.add(LatLng(coord[1], coord[0]));
        }
      } else if (type == 'MultiPolygon') {
        for (var polygon in coords) {
          for (var coord in polygon[0]) {
            // Assuming the first array in each polygon contains the points
            coordinates.add(LatLng(coord[1], coord[0]));
          }
        }
      }
      logger.i('Coordinates extracted successfully');
    } catch (e) {
      logger.e('Error extracting coordinates: $e');
    }
    return coordinates;
  }

  Future<List<LatLng>> getPointsForState(String stateId) async {
    await _ensureDataLoaded();
    List<LatLng> points = [];
    try {
      for (var feature in _geoJsonStateData) {
        if (feature['properties']['name'] == stateId) {
          var coordinates = feature['geometry']['coordinates'];
          // Check if it's a Polygon or MultiPolygon and extract accordingly
          if (feature['geometry']['type'] == 'Polygon') {
            for (var coord in coordinates[0]) {
              // Assuming outer boundary is the first in the array
              points.add(LatLng(coord[1], coord[0]));
            }
          } else if (feature['geometry']['type'] == 'MultiPolygon') {
            for (var polygon in coordinates) {
              for (var coord in polygon[0]) {
                // Assuming outer boundary is the first in the array
                points.add(LatLng(coord[1], coord[0]));
              }
            }
          }
          break; // Stop the loop once Texas is found
        }
        logger.i('Points extracted successfully');
      }
    } catch (e) {
      logger.e('Error getting points for state: $e');
    }
    return points;
  }
}
