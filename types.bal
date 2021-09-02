type ObjectParameters record {|
    string query;
    json? variables;
|};

// Error response

type Error record {
    string message;
    Location[]? locations?;
    record {}? extensions?;
    (string|int)[]? path?;
};

type Location record {
    int line?;
    int column?;
};

// Country

type CountryResponse record {
    CountryData? data?;
    Error[]? errors?;
    record {}? extensions?;
};

type CountryData record {
    Country? country?;
};

type Country record {
    string code?;
    string name?;
    string native?;
    string phone?;
    Continent continent?;
    string? capital?;
    string? currency?;
    Language[] languages?;
    string emoji?;
    string emojiU?;
    State[] states?;
};

// State

type State record {
    string? code?;
    string name?;
    Country country?;
};

// Countries

type CountriesResponse record {
    CountryData? data?;
    Error[]? errors?;
    record {}? extensions?;
};

type CountriesData record {
    Country[] countries;
};

// Continent

type ContinentResponse record {
    ContinentData? data?;
    Error[]? errors?;
    record {}? extensions?;
};

type ContinentData record {
    Continent? continent?;
};

type Continent record {
    string code?;
    string name?;
    Country[] countries?;
};

// Continents

type ContinentsResponse record {
    ContinentsData? data?;
    Error[]? errors?;
    record {}? extensions?;
};

type ContinentsData record {
    Continent[] continents;
};

// Language

type LanguageResponse record {
    LanguageData? data?;
    Error[]? errors?;
    record {}? extensions?;
};

type LanguageData record {
    Language? language?;
};

type Language record {
    string code?;
    string? name?;
    string? native?;
    boolean rtl?;
};

// Languages

type LanguagesResponse record {
    LanguagesData? data?;
    Error[]? errors?;
    record {}? extensions?;
};

type LanguagesData record {
    Language[] languages;
};

// Query

type QueryResponse record {
    QueryData? data?;
    Error[]? errors?;
    record {}? extensions?;
};

type QueryData record {
    Country? country?;
    Country[] countries?;
    Language? language?;
    Language[] languages?;
    Continent? continent?;
    Continent[] continentArray?;
};

// Input Types

type StringQueryOperatorInput record {
    string? eq?;
    string? ne?;
    string?[]? 'in?;
    string?[]? nin?;
    string? regex?;
    string? glob?;
};

public type CountryFilterInput record {
    StringQueryOperatorInput? code?;
    StringQueryOperatorInput? currency?;
    StringQueryOperatorInput? continent?;
};

public type LanguageFilterInput record {
    StringQueryOperatorInput? code?;
};

public type ContinentFilterInput record {
    StringQueryOperatorInput? code?;
};
