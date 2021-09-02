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

    // Query functions

    remote isolated function getCountry(string query, string code) returns CountryResponse|error {
        http:Request request = new;
        map<anydata> variables = { "code": code };
        json graphqlPayload = check getGraphqlPayload(query, variables);
        request.setPayload(graphqlPayload);
        CountryResponse response = check self.clientEp-> post("", request, targetType = CountryResponse);
        return response;
    }

    remote isolated function getCountries(string query, CountryFilterInput? filter = ()) 
                                          returns CountriesResponse|error {
        http:Request request = new;
        map<anydata> variables = { "filter": filter };
        json graphqlPayload = check getGraphqlPayload(query, variables);
        request.setPayload(graphqlPayload);
        CountriesResponse response = check self.clientEp-> post("", request, targetType = CountriesResponse);
        return response;
    }

    remote isolated function getLanguage(string query, string code) returns LanguageResponse|error {
        http:Request request = new;
        map<anydata> variables = { "code": code };
        json graphqlPayload = check getGraphqlPayload(query, variables);
        request.setPayload(graphqlPayload);
        LanguageResponse response = check self.clientEp-> post("", request, targetType = LanguageResponse);
        return response;
    }

    remote isolated function getLanguages(string query, LanguageFilterInput? filter = ()) 
                                          returns LanguagesResponse|error {
        http:Request request = new;
        map<anydata> variables = { "filter": filter };
        json graphqlPayload = check getGraphqlPayload(query, variables);
        request.setPayload(graphqlPayload);
        LanguagesResponse response = check self.clientEp-> post("", request, targetType = LanguagesResponse);
        return response;
    }

    remote isolated function getContinent(string query, string code) returns ContinentResponse|error {
        http:Request request = new;
        map<anydata> variables = { "code": code };
        json graphqlPayload = check getGraphqlPayload(query, variables);
        request.setPayload(graphqlPayload);
        ContinentResponse response = check self.clientEp-> post("", request, targetType = ContinentResponse);
        return response;
    }

    remote isolated function getContinents(string query, ContinentFilterInput? filter = ()) 
                                           returns ContinentsResponse|error {
        http:Request request = new;
        map<anydata> variables = { "filter": filter };
        json graphqlPayload = check getGraphqlPayload(query, variables);
        request.setPayload(graphqlPayload);
        ContinentsResponse response = check self.clientEp-> post("", request, targetType = ContinentsResponse);
        return response;
    }

    remote isolated function query(string query, string? countryCode = (), CountryFilterInput? countryFilterInput = (), 
                                   string? languageCode = (), LanguageFilterInput? languageFilterInput = (),
                                   string? continentCode = (), ContinentFilterInput? continentFilterInput = (),
                                   map<anydata>? additionalVariables = ()) 
                                   returns QueryResponse|error {
        http:Request request = new;
        map<anydata> definedVariables = { "countryCode": countryCode,  "countryFilterInput": countryFilterInput, 
            "languageCode": languageCode, "languageFilterInput": languageFilterInput, "continentCode":continentCode, 
            "continentFilterInput": continentFilterInput};
        json graphqlPayload = check getGraphqlPayload(query, definedVariables, additionalVariables);     
        request.setPayload(graphqlPayload);
        QueryResponse response = check self.clientEp-> post("", request, targetType = QueryResponse);
        return response;
    }
}
