// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/test;

@test:Config {}
isolated function testSendAndReceiveEnum() {
    testEnumServiceBlockingClient blockingEp = new ("http://localhost:9102");

    orderInfo orderReq = { id:"100500", mode:r };
    var addResponse = blockingEp->testEnum(orderReq);
    if (addResponse is Error) {
        test:assertFail(io:sprintf("Error from Connector: %s", addResponse.message()));
    } else {
        string result = "";
        [result, _] = addResponse;
        test:assertEquals(result, "r");
    }
}

public client class testEnumServiceBlockingClient {

    *AbstractClientEndpoint;

    private Client grpcClient;

    public isolated function init(string url, ClientConfiguration? config = ()) {
        // initialize client endpoint.
        self.grpcClient = new(url, config);
        checkpanic self.grpcClient.initStub(self, "blocking", ROOT_DESCRIPTOR_12, getDescriptorMap12());
    }

    public isolated remote function testEnum (orderInfo req, Headers? headers = ()) returns ([string, Headers]|Error) {
        var unionResp = check self.grpcClient->blockingExecute("grpcservices.testEnumService/testEnum", req, headers);
        Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = unionResp;
        return [result.toString(), resHeaders];
    }
}

public client class testEnumServiceClient {

    *AbstractClientEndpoint;

    private Client grpcClient;

    public isolated function init(string url, ClientConfiguration? config = ()) {
        // initialize client endpoint.
        self.grpcClient = new(url, config);
        checkpanic self.grpcClient.initStub(self, "non-blocking", ROOT_DESCRIPTOR_12, getDescriptorMap12());
    }

    public isolated remote function testEnum (orderInfo req, service msgListener, Headers? headers = ()) returns (Error?) {
        return self.grpcClient->nonBlockingExecute("grpcservices.testEnumService/testEnum", req, msgListener, headers);
    }
}
