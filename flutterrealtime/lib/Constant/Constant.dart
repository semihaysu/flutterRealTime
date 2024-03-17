
import 'dart:convert';

class Constant{
String apiUrl = 'http://easycopro.ibaysoft.com:8080/v1/Yonetim/GetirTotalCiro?raporrealtimebayisec=lazza54007&siparisrapordetaytarih=2024-03-04';

  
getbase64Authentication()
{
  String authettusername = "ibrahim";
  String authettpass = "41";
  return 'Basic ' + base64Encode(utf8.encode('$authettusername:$authettpass'));
}


}