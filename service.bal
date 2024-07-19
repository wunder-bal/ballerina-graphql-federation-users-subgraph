import user_subgraph.datasource;

import ballerina/graphql;
import ballerina/graphql.subgraph;
import ballerina/http;
import ballerina/log;

@subgraph:Subgraph
@graphql:ServiceConfig {
    contextInit
}
service "/users" on new graphql:Listener(9092) {

    # Returns the list of users
    # + return - List of users
    resource function get users() returns User[] => datasource:getUsers();
}

isolated function contextInit(http:RequestContext requestContext, http:Request request) returns graphql:Context|error {
    graphql:Context context = new;
    foreach string header in request.getHeaderNames() {
        log:printInfo(string `${header}: ${check request.getHeader(header)}`);
    }
    return context;
}