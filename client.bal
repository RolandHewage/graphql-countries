// import ballerina/io;
import ballerina/http;

public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + clientConfig - The configurations to be used when initializing the `connector`
    # + serviceUrl - URL of the target service
    # + return - An error at the failure of client initialization
    public isolated function init(string serviceUrl, http:ClientConfiguration clientConfig =  {}) returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
    }

    // Query functions (Option 5)

    remote isolated function getCountry(string query, string code) returns CountryResponse|error {
        http:Request request = new;
        ObjectParameters params = {
            query: query,
            variables: { code: code.toJson() }
        };
        request.setPayload(params.toJson());
        CountryResponse response = check self.clientEp-> post("", request, targetType = CountryResponse);
        return response;
    }

    remote isolated function getCountries(string query, CountryFilterInput? filter = ()) returns CountriesResponse|error {
        http:Request request = new;
        ObjectParameters params = {
            query: query,
            variables: { filter: filter.toJson() }
        };
        request.setPayload(params.toJson());
        CountriesResponse response = check self.clientEp-> post("", request, targetType = CountriesResponse);
        return response;
    }

    remote isolated function getLanguage(string query, string code) returns LanguageResponse|error {
        http:Request request = new;
        ObjectParameters params = {
            query: query,
            variables: { code: code.toJson() }
        };
        request.setPayload(params.toJson());
        LanguageResponse response = check self.clientEp-> post("", request, targetType = LanguageResponse);
        return response;
    }

    remote isolated function getLanguages(string query, LanguageFilterInput? filter = ()) returns LanguagesResponse|error {
        http:Request request = new;
        ObjectParameters params = {
            query: query,
            variables: { filter: filter.toJson() }
        };
        request.setPayload(params.toJson());
        LanguagesResponse response = check self.clientEp-> post("", request, targetType = LanguagesResponse);
        return response;
    }

    remote isolated function getContinent(string query, string code) returns ContinentResponse|error {
        http:Request request = new;
        ObjectParameters params = {
            query: query,
            variables: { code: code.toJson() }
        };
        request.setPayload(params.toJson());
        ContinentResponse response = check self.clientEp-> post("", request, targetType = ContinentResponse);
        return response;
    }

    remote isolated function getContinents(string query, ContinentFilterInput? filter = ()) returns ContinentsResponse|error {
        http:Request request = new;
        ObjectParameters params = {
            query: query,
            variables: { filter: filter.toJson() }
        };
        request.setPayload(params.toJson());
        ContinentsResponse response = check self.clientEp-> post("", request, targetType = ContinentsResponse);
        return response;
    }

    remote isolated function query(string query, string? countryCode = (), CountryFilterInput? countryFilterInput = (), 
                                string? languageCode = (), LanguageFilterInput? languageFilterInput = (),
                                string? continentCode = (), ContinentFilterInput? continentFilterInput = (),
                                map<anydata>? additionalVariables = ()) 
                                returns QueryResponse|error {
        json definedVariables = { 
                countryCode: countryCode.toJson(), 
                countryFilterInput: countryFilterInput.toJson(),
                languageCode: languageCode.toJson(),
                languageFilterInput: languageFilterInput.toJson(),
                continentCode: continentCode.toJson(),
                continentFilterInput: continentFilterInput.toJson()
            }; 
        json variables = check definedVariables.mergeJson(additionalVariables.toJson());                        
        ObjectParameters params = {
            query: query,
            variables: variables
        };
        http:Request request = new;
        request.setPayload(params.toJson());
        QueryResponse response = check self.clientEp-> post("", request, targetType = QueryResponse);
        return response;
    }
}
