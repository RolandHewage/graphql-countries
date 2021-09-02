isolated function getGraphqlPayload(string query, map<anydata> definedVariables, map<anydata>? additionalVariables = ()) 
                                    returns json|error {
    json variables = definedVariables.toJson();
    if (additionalVariables != ()) {
        variables = check variables.mergeJson(additionalVariables.toJson());
    }
    json graphqlPayload = {
        query: query,
        variables: variables
    };
    return graphqlPayload;
}
