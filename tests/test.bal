import  ballerina/test;
import ballerina/log;

Client baseClient = check new Client(serviceUrl = "https://countries.trevorblades.com/");

@test:Config {}
function  testCountry() returns error? {
    // Usage of a single query field related remote operation
    string countryQuery = string `query($code: ID!) {
        country(code: $code) {
            name
        }
    }`;
    CountryResponse? response = check baseClient->getCountry(countryQuery, "LK");
    log:printInfo(response.toString());
}

@test:Config {}
function  testCountries() returns error? {
    // Usage of a nested query in a single query field related remote operation
    StringQueryOperatorInput stringQueryOperatorInput = {
        eq: "LK"
    };
    CountryFilterInput filter = {
        code: stringQueryOperatorInput
    };
    string countriesQuery = string `query($filter: CountryFilterInput) {  
        countries(filter: $filter) {    
            name 
            continent {
                countries {
                    continent {
                        name
                    }
                }
            }
        }
    }`;
    CountriesResponse response = check baseClient->getCountries(countriesQuery, filter);
    log:printInfo(response.toString());
}

@test:Config {}
function  testQuery() returns error? {
    // Usage of multiple query fields
    string countryQuery = string `query {
        countries {
            name
        }
        country(code: "LK") {
            name
        }
    }`;
    QueryResponse? response = check baseClient->query(countryQuery);
    log:printInfo(response?.data?.country?.name.toString());
}

@test:Config {}
function  testQuery1() returns error? {
    // Usage of multiple query fields with defined variables
    string countryQuery = string `query ($countryCode: ID!) {
        countries {
            name
        }
        country(code: $countryCode) {
            name
        }
    }`;
    QueryResponse? response = check baseClient->query(countryQuery, "LK");
    log:printInfo(response?.data?.country?.name.toString());
}

@test:Config {}
function  testQuery2() returns error? {
    // Usage of multiple query fields with defined variables (scalars & records)
    string countryQuery = string `query ($countryCode: ID!, $countryFilterInput: CountryFilterInput) {
        country(code: $countryCode) {
            name
        }
        countries(filter: $countryFilterInput) {
            name
        }
    }`;
    StringQueryOperatorInput stringQueryOperatorInput = {
        eq: "LK"
    };
    CountryFilterInput countryFilterInput = {
        code: stringQueryOperatorInput
    };
    QueryResponse? response = check baseClient->query(countryQuery, "LK", countryFilterInput);
    log:printInfo(response.toString());
}

@test:Config {}
function  testQuery3() returns error? {
    // Usage of multiple query fields with defined variables (scalars & multiple records)
    string countryQuery = string `query ($countryCode: ID!, $countryFilterInput: CountryFilterInput, $languageFilterInput: LanguageFilterInput) {
        country(code: $countryCode) {
            name
        }
        countries(filter: $countryFilterInput) {
            name
        }
        languages(filter: $languageFilterInput) {
            name
            code
        }
    }`;
    StringQueryOperatorInput stringQueryOperatorInput1 = {
        eq: "LK"
    };
    CountryFilterInput countryFilterInput = {
        code: stringQueryOperatorInput1
    };
    StringQueryOperatorInput stringQueryOperatorInput2 = {
        eq: "si"
    };
    LanguageFilterInput languageFilterInput = {
        code: stringQueryOperatorInput2
    };
    QueryResponse? response = check baseClient->query(countryQuery, "LK", countryFilterInput, languageFilterInput = languageFilterInput);
    log:printInfo(response.toString());
}

@test:Config {}
function  testQuery4() returns error? {
    // Usage of multiple query fields with defined variables (scalars & multiple records) & nested queries
    string countryQuery = string `query ($countryCode: ID!, $countryFilterInput: CountryFilterInput, $languageFilterInput: LanguageFilterInput) {
        country(code: $countryCode) {
            name
        }
        countries(filter: $countryFilterInput) {
            name
            continent {
                countries {
                    name
                }
            }
        }
        languages(filter: $languageFilterInput) {
            name
            code
        }
    }`;
    StringQueryOperatorInput stringQueryOperatorInput = {
        eq: "LK"
    };
    CountryFilterInput countryFilterInput = {
        code: stringQueryOperatorInput
    };
    StringQueryOperatorInput stringQueryOperatorInput1 = {
        eq: "si"
    };
    LanguageFilterInput languageFilterInput = {
        code: stringQueryOperatorInput1
    };
    QueryResponse? response = check baseClient->query(countryQuery, "LK", countryFilterInput, languageFilterInput = languageFilterInput);
    log:printInfo(response.toString());
}

@test:Config {}
function  testQuery5() returns error? {
    // Usage of aliases
    string testQuery = string `query {
        srilanka: country(code: "LK") {
            name
            continent {
                name
            }
        }
        india: country(code: "IN") {
            name
        }
        australia: country(code: "AU") {
            name
        }
    }`;
    QueryResponse? response = check baseClient->query(testQuery);
    log:printInfo(response.toString());
}

@test:Config {}
function  testQuery6() returns error? {
    // Usage of directives
    string testQuery = string `query {
        srilanka: country(code: "LK") {
            name
            continent @include(if: true) {
                name
            }
        }
        india: country(code: "IN") {
            name
            continent @include(if: false) {
                name
            }
        }
        australia: country(code: "AU") {
            name
            continent @skip(if: true) {
                name
            }
        }
        canada: country(code: "CA") {
            name
            continent @skip(if: false) {
                name
            }
        }
    }`;
    QueryResponse? response = check baseClient->query(testQuery);
    log:printInfo(response.toString());
}

@test:Config {}
function  testQuery7() returns error? {
    // Usage of inline fragments
    string testQuery = string `query {
        srilanka: country(code: "LK") {
            name
            continent {
                name
            }
            ... on Country {
                capital
            }
        }
        india: country(code: "IN") {
            name
            continent {
                name
            }
            ... on Country {
                currency
                languages {
                    name
                }
            }
        }
        australia: country(code: "AU") {
            name
            continent {
                name
            }
        }
        canada: country(code: "CA") {
            name
            continent {
                name
            }
        }
    }`;
    QueryResponse? response = check baseClient->query(testQuery);
    // log:printInfo(response["srilanka"].toString());
    log:printInfo(response.toString());
}

@test:Config {}
function  testQuery8() returns error? {
    // Usage of fragments
    string testQuery = string `query {
        srilanka: country(code: "LK") {
            name
            continent {
                name
            }
            ... currencyLaguageInfoCountry
        }
        india: country(code: "IN") {
            name
            ... currencyLaguageInfoCountry
        }
        australia: country(code: "AU") {
            name
            continent {
                name
            }
            ... on Country {
                currency
                languages {
                    name
                }
            }
        }
        canada: country(code: "CA") {
            name
            continent {
                name
            }
        }
    }

    fragment currencyLaguageInfoCountry on Country {
        currency
        languages {
            name
        }
    }`;
    QueryResponse? response = check baseClient->query(testQuery);
    // log:printInfo(response["srilanka"].toString());
    log:printInfo(response.toString());
}

@test:Config {}
function  testQuery9() returns error? {
    // Usage of directives in query field related remote operations
    string testQuery = string `query ($code: ID!) {
        country(code: $code) {
            name
            continent @include(if: true) {
                name
            }
        }
    }`;
    Country? response = check baseClient->getCountry(testQuery, "SL");
    log:printInfo(response.toString());
}

@test:Config {}
function  testQuery10() returns error? {
    // Usage of inline fragments in query field related remote operations
    string testQuery = string `query ($code: ID!) {
        country(code: $code) {
            name
            continent {
                name
            }
            ... on Country {
                capital
            }
        }
    }`;
    Country? response = check baseClient->getCountry(testQuery, "SL");
    log:printInfo(response.toString());
}

@test:Config {}
function  testQuery11() returns error? {
    // Usage of additional variables
    map<anydata> additionalVariables = {
        countryCode: "LK"
    };
    string testQuery = string `query ($countryCode: ID!) {
        countries {
            name
        }
        country(code: $countryCode) {
            name
        }
    }`;
    QueryResponse? response = check baseClient->query(testQuery, additionalVariables = additionalVariables);
    log:printInfo(response?.data?.country?.name.toString());
}

@test:Config {}
function  testQuery12() returns error? {
    // Usage of aliases with additional variables
    map<anydata> additionalVariables = {
        srilankaCode: "LK",
        indiaCode: "IN",
        australiaCode: "AU"
    };
    string testQuery = string `query ($srilankaCode: ID!, $indiaCode: ID!, $australiaCode: ID!) {
        srilanka: country(code: $srilankaCode) {
            name
            continent {
                name
            }
        }
        india: country(code: $indiaCode) {
            name
        }
        australia: country(code: $australiaCode) {
            name
        }
    }`;
    QueryResponse? response = check baseClient->query(testQuery, additionalVariables = additionalVariables);
    log:printInfo(response.toString());
}

@test:Config {}
function  testQuery13() returns error? {
    // Usage of directives with additional variables
    map<anydata> additionalVariables = {
        srilankaCode: "LK",
        indiaCode: "IN",
        australiaCode: "AU",
        canadaCode: "CA"
    };
    string testQuery = string `query ($srilankaCode: ID!, $indiaCode: ID!, $australiaCode: ID!, $canadaCode: ID!) {
        srilanka: country(code: $srilankaCode) {
            name
            continent @include(if: true) {
                name
            }
        }
        india: country(code: $indiaCode) {
            name
            continent @include(if: false) {
                name
            }
        }
        australia: country(code: $australiaCode) {
            name
            continent @skip(if: true) {
                name
            }
        }
        canada: country(code: $canadaCode) {
            name
            continent @skip(if: false) {
                name
            }
        }
        mexico: country(code: "ME") {
            name
            continent {
                name
            }
        }
    }`;
    QueryResponse? response = check baseClient->query(testQuery, additionalVariables = additionalVariables);
    log:printInfo(response.toString());
}

@test:Config {}
function  testQuery14() returns error? {
    // Usage of inline fragments with additional variables
    map<anydata> additionalVariables = {
        srilankaCode: "LK",
        indiaCode: "IN",
        australiaCode: "AU",
        canadaCode: "CA"
    };
    string testQuery = string `query ($srilankaCode: ID!, $indiaCode: ID!, $australiaCode: ID!, $canadaCode: ID!) {
        srilanka: country(code: $srilankaCode) {
            name
            continent {
                name
            }
            ... on Country {
                capital
            }
        }
        india: country(code: $indiaCode) {
            name
            continent {
                name
            }
            ... on Country {
                currency
                languages {
                    name
                }
            }
        }
        australia: country(code: $australiaCode) {
            name
            continent {
                name
            }
        }
        canada: country(code: $canadaCode) {
            name
            continent {
                name
            }
        }
    }`;
    QueryResponse? response = check baseClient->query(testQuery, additionalVariables = additionalVariables);
    // log:printInfo(response["srilanka"].toString());
    log:printInfo(response.toString());
}

@test:Config {}
function  testQuery15() returns error? {
    // Usage of fragments with additional variables
    map<anydata> additionalVariables = {
        srilankaCode: "LK",
        indiaCode: "IN",
        australiaCode: "AU",
        canadaCode: "CA"
    };
    string testQuery = string `query ($srilankaCode: ID!, $indiaCode: ID!, $australiaCode: ID!, $canadaCode: ID!) {
        srilanka: country(code: $srilankaCode) {
            name
            continent {
                name
            }
            ... currencyLaguageInfoCountry
        }
        india: country(code: $indiaCode) {
            name
            ... currencyLaguageInfoCountry
        }
        australia: country(code: $australiaCode) {
            name
            continent {
                name
            }
            ... on Country {
                currency
                languages {
                    name
                }
            }
        }
        canada: country(code: $canadaCode) {
            name
            continent {
                name
            }
        }
    }

    fragment currencyLaguageInfoCountry on Country {
        currency
        languages {
            name
        }
    }`;
    QueryResponse? response = check baseClient->query(testQuery, additionalVariables = additionalVariables);
    // log:printInfo(response["srilanka"].toString());
    log:printInfo(response.toString());
}