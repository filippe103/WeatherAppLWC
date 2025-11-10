@IsTest
public class weatherAppControllerTest {

    
    private class WeatherHttpMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest request) {
            HttpResponse response = new HttpResponse();
            
            if(request.getEndpoint().contains('q=London')) {
                response.setBody('{"weather":[{"description":"clear sky"}],"main":{"temp":25.0}}');
                response.setStatusCode(200);
            } else {
                response.setBody('{"message":"city not found"}');
                response.setStatusCode(404);
            }
            return response;
        }
    }

    @IsTest
    static void testGetWeatherDetailsSuccess() {
        
        Test.setMock(HttpCalloutMock.class, new WeatherHttpMock());

        Test.startTest();
            String result = weatherAppController.getWeatherDetails('London');
        Test.stopTest();
        
        System.assert(result.contains('clear sky'), 'Deveria retornar uma resposta com "clear sky"');
    }

    @IsTest
    static void testGetWeatherDetailsNotFound() {

        Test.setMock(HttpCalloutMock.class, new WeatherHttpMock());

        Test.startTest();
            String result = weatherAppController.getWeatherDetails('UnknownCity');
        Test.stopTest();

        System.assert(result.contains('city not found'), 'Deveria retornar uma mensagem de erro');
    }

    @IsTest
    static void testGetKey() {
        String key = weatherAppController.getKey();
        System.assert(key.startsWith('&appid='), 'A chave deve começar com &appid=');
        System.assert(key.length() > 10, 'A chave deve conter o valor da API Key');
    }
}