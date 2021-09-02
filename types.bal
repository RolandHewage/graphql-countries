// Error response

public type Error record {
    string message;
    Location[]? locations?;
    record {}? extensions?;
};

public type Location record {
    int line?;
    int column?;
};

// Country

public type CountryResponse record {
    CountryData? data?;
    Error[]? errors?;
    record {}? extensions?;
};

public type CountryData record {
    Country? country?;
};

public type Country record {
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

public type State record {
    string? code?;
    string name?;
    Country country?;
};

// Countries

public type CountriesResponse record {
    CountriesData? data?;
    Error[]? errors?;
    record {}? extensions?;
};

public type CountriesData record {
    Country[] countries;
};

// Continent

public type ContinentResponse record {
    ContinentData? data?;
    Error[]? errors?;
    record {}? extensions?;
};

public type ContinentData record {
    Continent? continent?;
};

public type Continent record {
    string code?;
    string name?;
    Country[] countries?;
};

// Continents

public type ContinentsResponse record {
    ContinentsData? data?;
    Error[]? errors?;
    record {}? extensions?;
};

public type ContinentsData record {
    Continent[] continents;
};

// Language

public type LanguageResponse record {
    LanguageData? data?;
    Error[]? errors?;
    record {}? extensions?;
};

public type LanguageData record {
    Language? language?;
};

public type Language record {
    string code?;
    string? name?;
    string? native?;
    boolean rtl?;
};

// Languages

public type LanguagesResponse record {
    LanguagesData? data?;
    Error[]? errors?;
    record {}? extensions?;
};

public type LanguagesData record {
    Language[] languages;
};

// Query

public type QueryResponse record {
    QueryData? data?;
    Error[]? errors?;
    record {}? extensions?;
};

public type QueryData record {
    Country? country?;
    Country[] countries?;
    Language? language?;
    Language[] languages?;
    Continent? continent?;
    Continent[] continentArray?;
};

// Input Types

public type StringQueryOperatorInput record {
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
