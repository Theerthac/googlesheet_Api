import 'package:googlesheet/model/user.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetApi {
  static const credentials = r'''  
  {
  "type": "service_account",
  "project_id": "gsheets-405311",
  "private_key_id": "b307915c94e7083ad49d8a90925c7aa712d82f0d",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDdeqEGXfI63Xn3\nvtx13DM58/XP9wR8982UeT+l1++EGjAr/K8rsceopn/d6/JTwz6JkZVswSNgaFrn\nyeeMA1kYrh0ouxzkTV7WYgr/q31Gd/mlxcFTz84BuSMuHynnNHqK2AF1Y4t1Gmnk\nxSANwYZVSGdIyUBIfknodctVKmdW3BLgIF/iVHLZUqrgP++Y/TwdDV2ewhyUfehu\ngSEauEGNc934OBAW7Ccjx8nbS599XnBbOmmnBxHFN/ifsdkRgCjE0mGFfL70exmd\nLDsuEDu1otCFC3aCrCQGnC4qfPpbMs3S+Lwt+jV7Tk91aYgEowis4hb4VBgBKm3h\nSD3l8xjBAgMBAAECggEAAhQPhMbG6iR/64JAAV8in+2ZJe10flO4+ya0ITNIjR3N\ny+vgHPHbJMsDMirvqDeR06qpE08wrMvt5nTvllHFuUSRA3vWBpJvTGW5IrMSRuID\nVrnnWYj+rud03A7wzrmgWMM0KEzZ1yx7R+lNprNlNlGqnnU9BDEjMmpAkTkHpToA\n/ds6saDAzwjLJCoNhw6RvpQqB2dpPXJYgb+gAaqzasMcAMWpoVoQBj3hxXFcTPgh\n2eDojr4UyHydkRqQGJNRBkvPT63JU5kddhRMneaAB1INm4wevnOcJCCTzUwmD0g/\nPJnstJPAJk13IgYpb3U/jTfunAEnl71lSmMPZltS0QKBgQD6RSRNeIUOW6aSbEMq\ngiQOER1hiou6L4pa0NlsNhMt95oTg130VBcMuA3UJXDQbI8St+g2oATN8ppXxoEW\nfCGmlzWHAevOew8UhtWXw+hCtlchXWcU/hRF31cEtLHeQDj8nPFpxXRkw923Nmcz\nbuNh98An5BLz30sfzT8PGSqcXQKBgQDijL1nY8vhdRiqk/VnzSFGi1ngyRo6E4lt\nG7ofwCLAjo4hFoAHW7pOU59QUeW9B3jbwqQFYlH307LV1I7AcdC682e8VvxVDJge\nZfGdFnBudRAwXJ7ZKbOCr4EiBQHoT0wFToVSMw02rZwe6SMGEe0FARtYa1nePplc\nUlQyyfwHtQKBgQCFx1/YaYv2WNd5fZWJq3dKbaue8EgwhikW0nzmcyFdePVLaPVY\nHXsUuW3q8PiU8PKpttTSHkdzLzOBqAJo2oHCYyGhwU0jWnR9LHYQYhBNWNrKYvsv\nJYIAt5n0UgKiIwJTRjFlsL6+/lQOE26m96dkPuLgb/IRmlK19Si4EWPNoQKBgCZu\n1drqVTYkVVDq1OENLa34CgFWXHqpwdCeuY6VW8/q3zXByWp2Jz8OdKJ9oknVMK2n\ncYfwTBOM+HPKIYWISW7NyDVtVFVhU5Ukmj6aBezXMy3hKJmSt39eIrwQuWgdu7nS\nvk9Zlc5G2Yts5aIr/Fey/l6bp51KZV4CIYKUPYtZAoGAf9VgLYGrpqA7o5LMOQgf\nEeujVLEQ2IGbdCZZ5hJFNdSob+43ddgcsDnXoasBpF2X5RJdVBburyPAjM8Qr0vi\nW3tbrJNKb2R7z1K/N8iV4d4oiKikJ8GvijyqCP5sRxn/WmhQsZRf++klE19gie1+\nqhPeY8weR3fZudtttkMdaxI=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-405311.iam.gserviceaccount.com",
  "client_id": "107959659718655428738",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-405311.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

   ''';
  static const spreadsheetId = '1xdA9-Ub90bifD9mklu45DnTdSEtUlhr4zjJcwgLMUXk';
  static final gsheets = GSheets(credentials);
  static Worksheet? userSheet;

  static Future init() async {
    try {
      final Spreadsheet = await gsheets.spreadsheet(spreadsheetId);
      userSheet = await getWorkSheet(Spreadsheet, title: 'Users');

      final firstRow = UserFields.getFields();
      userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return await spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async {
    if (userSheet == null) 0;
    final lastRow = await userSheet!.values.lastRow();
    return lastRow == null?0:int.tryParse(lastRow.first) ?? 0;
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (userSheet == null) return;
    userSheet!.values.map.appendRows(rowList);
  }
}
