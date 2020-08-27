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

HelloWorld7BlockingClient helloWorld7BlockingEp = new ("http://localhost:9097");

//type ResponseTypedesc typedesc<Response>;

@test:Config {}
function testUnaryBlockingClient() {
    string name = "WSO2";
    [string, Headers]|Error unionResp = helloWorld7BlockingEp->hello(name);
    if (unionResp is Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        io:println("Client Got Response : ");
        string result = "";
        [result, _] = unionResp;
        io:println(result);
        test:assertEquals(result, "Hello WSO2");
    }
}

@test:Config {}
function testUnaryBlockingIntClient() {
    int age = 10;
    [int, Headers]|Error unionResp = helloWorld7BlockingEp->testInt(age);
    if (unionResp is Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        io:println("Client got response : ");
        int result = 0;
        [result, _] = unionResp;
        io:println(result);
        test:assertEquals(result, 8);
    }
}

@test:Config {}
function testUnaryBlockingFloatClient() {
    float salary = 1000.5;
    [float, Headers]|Error unionResp = helloWorld7BlockingEp->testFloat(salary);
    if (unionResp is Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        io:println("Client got response : ");
        float result = 0.0;
        [result, _] = unionResp;
        io:println(result);
        test:assertEquals(result, 880.44);
    }
}

@test:Config {}
function testUnaryBlockingBoolClient() {
    boolean isAvailable = false;
    [boolean, Headers]|Error unionResp = helloWorld7BlockingEp->testBoolean(isAvailable);
    if (unionResp is Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        io:println("Client got response : ");
        boolean result = false;
        [result, _] = unionResp;
        io:println(result);
        test:assertTrue(result);
    }
}

@test:Config {}
function testUnaryBlockingReceiveRecord() {
    string msg = "WSO2";
    [Response, Headers]|Error unionResp = helloWorld7BlockingEp->testResponseInsideMatch(msg);
    if (unionResp is Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        io:println("Client got response : ");
        Response result = {};
        [result, _] = unionResp;
        io:println(result);
        test:assertEquals(result.resp, "Acknowledge WSO2");
    }
}

@test:Config {}
function testUnaryBlockingStructClient() {
    Request req = {name:"Sam", age:10, message:"Testing."};
    [Response, Headers]|Error unionResp = helloWorld7BlockingEp->testStruct(req);
    if (unionResp is Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        io:println("Client got response : ");
        Response result = {};
        [result, _] = unionResp;
        io:println(result);
        test:assertEquals(result.resp, "Acknowledge Sam");
    }
}

public type HelloWorld7BlockingClient client object {

    *AbstractClientEndpoint;

    private Client grpcClient;

    public function init(string url, ClientConfiguration? config = ()) {
        // initialize client endpoint.
        self.grpcClient = new(url, config);
        checkpanic self.grpcClient.initStub(self, "blocking", ROOT_DESCRIPTOR_7, getDescriptorMap7());
    }

    public remote function hello(string req, Headers? headers = ()) returns ([string, Headers]|Error) {
        var unionResp = check self.grpcClient->blockingExecute("grpcservices.HelloWorld100/hello", req, headers);
        any result = ();
        Headers resHeaders = new;
        [result, resHeaders] = unionResp;
        return [result.toString(), resHeaders];
    }

    public remote function testInt(int req, Headers? headers = ()) returns ([int, Headers]|Error) {
        var unionResp = check self.grpcClient->blockingExecute("grpcservices.HelloWorld100/testInt", req, headers);
        anydata result = ();
        Headers resHeaders = new;
        [result, resHeaders] = unionResp;
        var value = result.cloneWithType(IntTypedesc);
        if (value is int) {
            return [value, resHeaders];
        } else {
            return InternalError("Error while constructing the message", value);
        }
    }

    public remote function testFloat(float req, Headers? headers = ()) returns ([float, Headers]|Error) {
        var unionResp = check self.grpcClient->blockingExecute("grpcservices.HelloWorld100/testFloat", req, headers);
        anydata result = ();
        Headers resHeaders = new;
        [result, resHeaders] = unionResp;
        var value = result.cloneWithType(FloatTypedesc);
        if (value is float) {
            return [value, resHeaders];
        } else {
            return InternalError("Error while constructing the message", value);
        }
    }

    public remote function testBoolean(boolean req, Headers? headers = ()) returns ([boolean, Headers]|Error) {
        var unionResp = check self.grpcClient->blockingExecute("grpcservices.HelloWorld100/testBoolean", req, headers);
        anydata result = ();
        Headers resHeaders = new;
        [result, resHeaders] = unionResp;
        var value = result.cloneWithType(BooleanTypedesc);
        if (value is boolean) {
            return [value, resHeaders];
        } else {
            return InternalError("Error while constructing the message", value);
        }
    }

    public remote function testStruct(Request req, Headers? headers = ()) returns ([Response, Headers]|Error) {
        var unionResp = check self.grpcClient->blockingExecute("grpcservices.HelloWorld100/testStruct", req, headers);
        anydata result = ();
        Headers resHeaders = new;
        [result, resHeaders] = unionResp;
        var value = result.cloneWithType(ResponseTypedesc);
        if (value is Response) {
            return [value, resHeaders];
        } else {
            return InternalError("Error while constructing the message", value);
        }
    }

    public remote function testResponseInsideMatch(string req, Headers? headers = ()) returns [Response, Headers]|Error {
        var unionResp = check self.grpcClient->blockingExecute("grpcservices.HelloWorld100/testResponseInsideMatch", req, headers);
        anydata result = ();
        Headers resHeaders = new;
        [result, resHeaders] = unionResp;
        var value = result.cloneWithType(ResponseTypedesc);
        if (value is Response) {
            return [value, resHeaders];
        } else {
            return InternalError("Error while constructing the message", value);
        }
    }
};

//const string ROOT_DESCRIPTOR = "0A1348656C6C6F576F726C643130302E70726F746F120C6772706373657276696365731A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F22490A075265717565737412120A046E616D6518012001280952046E616D6512180A076D65737361676518022001280952076D65737361676512100A036167651803200128035203616765221E0A08526573706F6E736512120A047265737018012001280952047265737032B5030A0D48656C6C6F576F726C6431303012430A0568656C6C6F121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512430A0774657374496E74121B2E676F6F676C652E70726F746F6275662E496E74363456616C75651A1B2E676F6F676C652E70726F746F6275662E496E74363456616C756512450A0974657374466C6F6174121B2E676F6F676C652E70726F746F6275662E466C6F617456616C75651A1B2E676F6F676C652E70726F746F6275662E466C6F617456616C756512450A0B74657374426F6F6C65616E121A2E676F6F676C652E70726F746F6275662E426F6F6C56616C75651A1A2E676F6F676C652E70726F746F6275662E426F6F6C56616C7565123B0A0A7465737453747275637412152E6772706373657276696365732E526571756573741A162E6772706373657276696365732E526573706F6E7365124F0A1774657374526573706F6E7365496E736964654D61746368121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A162E6772706373657276696365732E526573706F6E7365620670726F746F33";
//function getDescriptorMap() returns map<string> {
//    return  {
//        "HelloWorld100.proto":
//        "0A1348656C6C6F576F726C643130302E70726F746F120C6772706373657276696365731A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F22490A075265717565737412120A046E616D6518012001280952046E616D6512180A076D65737361676518022001280952076D65737361676512100A036167651803200128035203616765221E0A08526573706F6E736512120A047265737018012001280952047265737032B5030A0D48656C6C6F576F726C6431303012430A0568656C6C6F121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512430A0774657374496E74121B2E676F6F676C652E70726F746F6275662E496E74363456616C75651A1B2E676F6F676C652E70726F746F6275662E496E74363456616C756512450A0974657374466C6F6174121B2E676F6F676C652E70726F746F6275662E466C6F617456616C75651A1B2E676F6F676C652E70726F746F6275662E466C6F617456616C756512450A0B74657374426F6F6C65616E121A2E676F6F676C652E70726F746F6275662E426F6F6C56616C75651A1A2E676F6F676C652E70726F746F6275662E426F6F6C56616C7565123B0A0A7465737453747275637412152E6772706373657276696365732E526571756573741A162E6772706373657276696365732E526573706F6E7365124F0A1774657374526573706F6E7365496E736964654D61746368121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A162E6772706373657276696365732E526573706F6E7365620670726F746F33"
//        ,
//        "google/protobuf/wrappers.proto":
//        "0A0E77726170706572732E70726F746F120F676F6F676C652E70726F746F62756622230A0B446F75626C6556616C756512140A0576616C7565180120012801520576616C756522220A0A466C6F617456616C756512140A0576616C7565180120012802520576616C756522220A0A496E74363456616C756512140A0576616C7565180120012803520576616C756522230A0B55496E74363456616C756512140A0576616C7565180120012804520576616C756522220A0A496E74333256616C756512140A0576616C7565180120012805520576616C756522230A0B55496E74333256616C756512140A0576616C756518012001280D520576616C756522210A09426F6F6C56616C756512140A0576616C7565180120012808520576616C756522230A0B537472696E6756616C756512140A0576616C7565180120012809520576616C756522220A0A427974657356616C756512140A0576616C756518012001280C520576616C756542570A13636F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"
//        ,
//        "google/protobuf/empty.proto":
//        "0A0B656D7074792E70726F746F120F676F6F676C652E70726F746F62756622070A05456D70747942540A13636F6D2E676F6F676C652E70726F746F627566420A456D70747950726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"
//    };
//}

//public type Request record {
//    string name = "";
//    string message = "";
//    int age = 0;
//};
//
//public type Response record {
//    string resp = "";
//};