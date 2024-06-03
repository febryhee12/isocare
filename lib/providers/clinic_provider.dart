import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import '../helpers/url.dart';
import 'package:xml2json/xml2json.dart';

final Xml2Json xml2json = Xml2Json();

class ClinicProvider extends GetConnect {
  Future<List<dynamic>> fetchByKeyword(keyword) async {
    String soap = '''<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <bindData1AD_2 xmlns="http://tempuri.org/">
      <optky>iLQObWcalaUqqVbQu0TrNUKHypU/joTO5aTtXSVNCjE=</optky>
      <PROVIDERID>''' +
        keyword +
        '''</PROVIDERID>
      <PROVIDERTYPE>all</PROVIDERTYPE>
      <SEARCH>''' +
        keyword +
        '''</SEARCH>
      <POLICYNO></POLICYNO>
    </bindData1AD_2>
  </soap12:Body>
</soap12:Envelope>''';
    final response = await post(
      Uri.parse(postXmlServiceUrl).toString(),
      soap,
      headers: {
        'content-type': 'text/xml',
      },
    );

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      xml2json.parse(response.body);
      var jsonString = xml2json.toParker();
      var decodedRes = jsonDecode(jsonString);
      return jsonDecode(decodedRes['soap:Envelope']['soap:Body']
          ['bindData1AD_2Response']['bindData1AD_2Result'])['Table'];
    }
  }

  Future<List<dynamic>> fetchByCoordinate(lat, long) async {
    String soap = '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <providerByLocationAD_2 xmlns="http://tempuri.org/">
      <optky>iLQObWcalaUqqVbQu0TrNUKHypU/joTO5aTtXSVNCjE=</optky>
      <RangeRS>20</RangeRS>
      <lat1>''' +
        lat +
        '''</lat1>
      <longt1>''' +
        long +
        '''</longt1>
      <group>all</group>
      <POLICYNO></POLICYNO>
    </providerByLocationAD_2>
  </soap:Body>
</soap:Envelope>''';
    final response = await post(
      Uri.parse(postXmlServiceUrl).toString(),
      soap,
      headers: {
        'content-type': 'text/xml',
      },
    );

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      xml2json.parse(response.body);
      var jsonString = xml2json.toParker();
      var decodedRes = jsonDecode(jsonString);
      return jsonDecode(decodedRes['soap:Envelope']['soap:Body']
              ['providerByLocationAD_2Response']
          ['providerByLocationAD_2Result'])['Table'];
    }
  }
}
