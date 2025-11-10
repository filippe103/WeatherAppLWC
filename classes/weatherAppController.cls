public with sharing class weatherAppController {
    
    @AuraEnabled
    public static string getWeatherDetails(String input){
        String url = 'https://api.openweathermap.org/data/2.5/weather?q=' + input + '&units=metric' + getKey();
        String response = getResponse(url);
        return response;
    }

    public static string getResponse(String strUrl){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        request.setMethod('GET');
        request.setEndpoint(strUrl);
        request.setTimeout(120000);
        response = http.send(request);
        String responseBody = response.getBody();
        return responseBody;
    }

    public static string getKey(){
        string key = '05c86ae8f0ee5ac5acc42241bcfe66ee'; //System.Label.WeatherAPIKey
        string output = '&appid=' + key;
        return output;
    }
}