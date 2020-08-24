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

HelloWorld2BlockingClient HelloWorld2BlockingEp = new ("http://localhost:9092");

// Enable when you need to test locally.
//public function main() {
//
//    TestInt testInt = {values: [1, 2, 3]};
//    var resp1 = testIntArrayInput(testInt);
//    io:println(resp1);
//
//    TestString testbol = {values: ["A", "B", "S"]};
//    var resp2 = testStringArrayInput(testbol);
//    io:println(resp2);
//
//    TestFloat testFloat = {values: [1.1, 1.2, 1.3, 1.4]};
//    var resp3 = testFloatArrayInput(testFloat);
//    io:println(resp3);
//
//    TestBoolean testBol = {values: [true, false, true]};
//    var resp4 = testBooleanArrayInput(testBol);
//    io:println(resp4);
//
//    TestStruct testStruct = {values: [{name: "A"}, {name: "B"}, {name: "C"}]};
//    var resp5 = testStructArrayInput();
//    io:println(resp5);
//
//    var resp6 = testIntArrayOutput();
//    io:println(resp6);
//
//    var resp7 = testStringArrayOutput();
//    io:println(resp7);
//
//    var resp8 = testFloatArrayOutput();
//    io:println(resp8);
//
//    var resp9 = testBooleanArrayOutput();
//    io:println(resp9);
//
//    var resp10 = testStructArrayOutput();
//    io:println(resp10);
//}

@test:Config {}
function testSendIntArray() {
    TestInt req = {values: [1, 2, 3, 4, 5]};
    io:println("testIntArrayInput: input:");
    io:println(req);
    [int, Headers]|Error unionResp = HelloWorld2BlockingEp->testIntArrayInput(req);
    io:println(unionResp);
    if (unionResp is Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        io:println("Client Got Response : ");
        int result = 0;
        [result, _] = unionResp;
        io:println(result);
        test:assertEquals(result, 15);
    }
}

@test:Config {}
function testSendStringArray() {
    TestString req = {values:["A", "B", "C"]};
    io:println("testStringArrayInput: input:");
    io:println(req);
    [string, Headers]|Error unionResp = HelloWorld2BlockingEp->testStringArrayInput(req);
    io:println(unionResp);
    if (unionResp is Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        io:println("Client Got Response : ");
        string result;
        [result, _] = unionResp;
        io:println(result);
        test:assertEquals(result, ",A,B,C");
    }
}

@test:Config {}
function testSendFloatArray() {
    TestFloat req = {values:[1.1, 1.2, 1.3, 1.4, 1.5]};
    io:println("testFloatArrayInput: input:");
    io:println(req);
    [float, Headers]|Error unionResp = HelloWorld2BlockingEp->testFloatArrayInput(req);
    io:println(unionResp);
    if (unionResp is Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        io:println("Client Got Response : ");
        float result;
        [result, _] = unionResp;
        io:println(result);
        test:assertEquals(result, 6.5);
    }
}

@test:Config {}
function testSendBooleanArray() {
    TestBoolean req = {values:[true, false, true]};
    io:println("testBooleanArrayInput: input:");
    io:println(req);
    [boolean, Headers]|Error unionResp = HelloWorld2BlockingEp->testBooleanArrayInput(req);
    io:println(unionResp);
    if (unionResp is Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        io:println("Client Got Response : ");
        boolean result;
        [result, _] = unionResp;
        io:println(result);
        test:assertTrue(result);
    }
}

@test:Config {}
function testSendStructArray() {
    TestStruct testStruct = {values: [{name: "Sam"}, {name: "John"}]};
    io:println("testStructArrayInput: input:");
    io:println(testStruct);
    [string, Headers]|Error unionResp = HelloWorld2BlockingEp->testStructArrayInput(testStruct);
    io:println(unionResp);
    if (unionResp is Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        io:println("Client Got Response : ");
        string result;
        [result, _] = unionResp;
        io:println(result);
        test:assertEquals(result, ",Sam,John");
    }
}

@test:Config {}
function testReceiveIntArray() {
    io:println("testIntArrayOutput: No input:");
    [TestInt, Headers]|Error unionResp = HelloWorld2BlockingEp->testIntArrayOutput();
    io:println(unionResp);
    if (unionResp is Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        io:println("Client Got Response : ");
        TestInt result;
        [result, _] = unionResp;
        io:println(result);
        test:assertEquals(result.values.length(), 5);
        test:assertEquals(result.values[0], 1);
        test:assertEquals(result.values[1], 2);
        test:assertEquals(result.values[2], 3);
        test:assertEquals(result.values[3], 4);
        test:assertEquals(result.values[4], 5);
    }
}

@test:Config {}
function testReceiveStringArray() {
    io:println("testStringArrayOutput: No input:");
    [TestString, Headers]|Error unionResp = HelloWorld2BlockingEp->testStringArrayOutput();
    io:println(unionResp);
    if (unionResp is Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        io:println("Client Got Response : ");
        TestString result;
        [result, _] = unionResp;
        io:println(result);
        test:assertEquals(result.values.length(), 3);
        test:assertEquals(result.values[0], "A");
        test:assertEquals(result.values[1], "B");
        test:assertEquals(result.values[2], "C");
    }
}

@test:Config {}
function testReceiveFloatArray() {
    io:println("testFloatArrayOutput: No input:");
    [TestFloat, Headers]|Error unionResp = HelloWorld2BlockingEp->testFloatArrayOutput();
    io:println(unionResp);
    if (unionResp is Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        io:println("Client Got Response : ");
        TestFloat result;
        [result, _] = unionResp;
        io:println(result);
        test:assertEquals(result.values.length(), 5);
        test:assertEquals(result.values[0], 1.1);
        test:assertEquals(result.values[1], 1.2);
        test:assertEquals(result.values[2], 1.3);
    }
}

@test:Config {}
function testReceiveBooleanArray() {
    io:println("testBooleanArrayOutput: No input:");
    [TestBoolean, Headers]|Error unionResp = HelloWorld2BlockingEp->testBooleanArrayOutput();
    io:println(unionResp);
    if (unionResp is Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        io:println("Client Got Response : ");
        TestBoolean result;
        [result, _] = unionResp;
        io:println(result);
        test:assertEquals(result.values.length(), 3);
        test:assertTrue(result.values[0]);
        test:assertFalse(result.values[1]);
        test:assertTrue(result.values[2]);
    }
}

@test:Config {}
function testReceiveStructArray() {
    io:println("testStructArrayOutput: No input:");
    [TestStruct, Headers]|Error unionResp = HelloWorld2BlockingEp->testStructArrayOutput();
    io:println(unionResp);
    if (unionResp is Error) {
        test:assertFail(io:sprintf(ERROR_MSG_FORMAT, unionResp.message()));
    } else {
        io:println("Client Got Response : ");
        TestStruct result;
        [result, _] = unionResp;
        io:println(result);
        test:assertEquals(result.values.length(), 2);
        test:assertEquals(result.values[0].name, "Sam");
    }
}

public type HelloWorld2BlockingClient client object {

    *AbstractClientEndpoint;

    private Client grpcClient;

    public function init(string url, ClientConfiguration? config = ()) {
        // initialize client endpoint.
        self.grpcClient = new(url, config);
        checkpanic self.grpcClient.initStub(self, "blocking", ROOT_DESCRIPTOR_2, getDescriptorMap2());
    }

    public remote function testIntArrayInput(TestInt req, Headers? headers = ()) returns ([int, Headers]|Error) {
        [anydata, Headers] payload = check self.grpcClient->blockingExecute("grpcservices.HelloWorld3/testIntArrayInput", req, headers);
        anydata result = ();
        Headers resHeaders = new;
        [result, resHeaders] = payload;
        var value = result.cloneWithType(IntTypedesc);
        if (value is int) {
            return [value, resHeaders];
        } else {
            return InternalError("Error while constructing the message", value);
        }
    }

    public remote function testStringArrayInput(TestString req, Headers? headers = ()) returns ([string, Headers]|Error) {
        [anydata, Headers] payload = check self.grpcClient->blockingExecute("grpcservices.HelloWorld3/testStringArrayInput", req, headers);
        anydata result = ();
        Headers resHeaders = new;
        [result, resHeaders] = payload;
        return [result.toString(), resHeaders];
    }

    public remote function testFloatArrayInput(TestFloat req, Headers? headers = ()) returns ([float, Headers]|Error) {
        [anydata, Headers] payload = check self.grpcClient->blockingExecute("grpcservices.HelloWorld3/testFloatArrayInput", req, headers);
        anydata result = ();
        Headers resHeaders = new;
        [result, resHeaders] = payload;
        var value = result.cloneWithType(FloatTypedesc);
        if (value is float) {
            return [value, resHeaders];
        } else {
            return InternalError("Error while constructing the message", value);
        }
    }

    public remote function testBooleanArrayInput(TestBoolean req, Headers? headers = ()) returns ([boolean, Headers]|Error) {
        [anydata, Headers] payload = check self.grpcClient->blockingExecute("grpcservices.HelloWorld3/testBooleanArrayInput", req, headers);
        anydata result = ();
        Headers resHeaders = new;
        [result, resHeaders] = payload;
        var value = result.cloneWithType(BooleanTypedesc);
        if (value is boolean) {
            return [value, resHeaders];
        } else {
            return InternalError("Error while constructing the message", value);
        }
    }

    public remote function testStructArrayInput(TestStruct req, Headers? headers = ()) returns ([string, Headers]|Error) {
        [anydata, Headers] payload = check self.grpcClient->blockingExecute("grpcservices.HelloWorld3/testStructArrayInput", req, headers);
        anydata result = ();
        Headers resHeaders = new;
        [result, resHeaders] = payload;
        return [result.toString(), resHeaders];
    }

    public remote function testIntArrayOutput(Headers? headers = ()) returns ([TestInt, Headers]|Error) {
        Empty req = {};
        [anydata, Headers] payload = check self.grpcClient->blockingExecute("grpcservices.HelloWorld3/testIntArrayOutput", req, headers);
        anydata result =();
        Headers resHeaders = new;
        [result, resHeaders] = payload;
        var value = result.cloneWithType(TestIntTypedesc);
        if (value is TestInt) {
            return [value, resHeaders];
        } else {
            return InternalError("Error while constructing the message", value);
        }
    }

    public remote function testStringArrayOutput(Headers? headers = ()) returns ([TestString, Headers]|Error) {
        Empty req = {};
        [anydata, Headers] payload = check self.grpcClient->blockingExecute("grpcservices.HelloWorld3/testStringArrayOutput", req, headers);
        anydata result = ();
        Headers resHeaders = new;
        [result, resHeaders] = payload;
        var value = result.cloneWithType(TestStringTypedesc);
        if (value is TestString) {
            return [value, resHeaders];
        } else {
            return InternalError("Error while constructing the message", value);
        }
    }

    public remote function testFloatArrayOutput(Headers? headers = ()) returns ([TestFloat, Headers]|Error) {
        Empty req = {};
        [anydata, Headers] payload = check self.grpcClient->blockingExecute("grpcservices.HelloWorld3/testFloatArrayOutput", req, headers);
        anydata result = ();
        Headers resHeaders = new;
        [result, resHeaders] = payload;
        var value = result.cloneWithType(TestFloatTypedesc);
        if (value is TestFloat) {
            return [value, resHeaders];
        } else {
            return InternalError("Error while constructing the message", value);
        }
    }

    public remote function testBooleanArrayOutput(Headers? headers = ()) returns ([TestBoolean, Headers]|Error) {
        Empty req = {};
        [anydata, Headers] payload = check self.grpcClient->blockingExecute("grpcservices.HelloWorld3/testBooleanArrayOutput", req, headers);
        anydata result = ();
        Headers resHeaders = new;
        [result, resHeaders] = payload;
        var value = result.cloneWithType(TestBooleanTypedesc);
        if (value is TestBoolean) {
            return [value, resHeaders];
        } else {
            return InternalError("Error while constructing the message", value);
        }
    }

    public remote function testStructArrayOutput(Headers? headers = ()) returns ([TestStruct, Headers]|Error) {
        Empty req = {};
        [anydata, Headers] payload = check self.grpcClient->blockingExecute("grpcservices.HelloWorld3/testStructArrayOutput", req, headers);
        anydata result = ();
        Headers resHeaders = new;
        [result, resHeaders] = payload;
        var value = result.cloneWithType(TestStructTypedesc);
        if (value is TestStruct) {
            return [value, resHeaders];
        } else {
            return InternalError("Error while constructing the message", value);
        }
    }
};

public type HelloWorld2Client client object {

    *AbstractClientEndpoint;

    private Client grpcClient;

    public function init(string url, ClientConfiguration? config = ()) {
        // initialize client endpoint.
        self.grpcClient = new(url, config);
        checkpanic self.grpcClient.initStub(self, "non-blocking", ROOT_DESCRIPTOR_2, getDescriptorMap2());
    }

    public remote function testIntArrayInput(TestInt req, service msgListener, Headers? headers = ()) returns (Error?) {
        return self.grpcClient->nonBlockingExecute("grpcservices.HelloWorld3/testIntArrayInput", req, msgListener, headers);
    }

    public remote function testStringArrayInput(TestString req, service msgListener, Headers? headers = ()) returns (Error?) {
        return self.grpcClient->nonBlockingExecute("grpcservices.HelloWorld3/testStringArrayInput", req, msgListener, headers);
    }

    public remote function testFloatArrayInput(TestFloat req, service msgListener, Headers? headers = ()) returns (Error?) {
        return self.grpcClient->nonBlockingExecute("grpcservices.HelloWorld3/testFloatArrayInput", req, msgListener, headers);
    }

    public remote function testBooleanArrayInput(TestBoolean req, service msgListener, Headers? headers = ()) returns (Error?) {
        return self.grpcClient->nonBlockingExecute("grpcservices.HelloWorld3/testBooleanArrayInput", req, msgListener, headers);
    }

    public remote function testStructArrayInput(TestStruct req, service msgListener, Headers? headers = ()) returns (Error?) {
        return self.grpcClient->nonBlockingExecute("grpcservices.HelloWorld3/testStructArrayInput", req, msgListener, headers);
    }

    public remote function testIntArrayOutput(service msgListener, Headers? headers = ()) returns (Error?) {
        Empty req = {};
        return self.grpcClient->nonBlockingExecute("grpcservices.HelloWorld3/testIntArrayOutput", req, msgListener, headers);
    }

    public remote function testStringArrayOutput(service msgListener, Headers? headers = ()) returns (Error?) {
        Empty req = {};
        return self.grpcClient->nonBlockingExecute("grpcservices.HelloWorld3/testStringArrayOutput", req, msgListener, headers);
    }

    public remote function testFloatArrayOutput(service msgListener, Headers? headers = ()) returns (Error?) {
        Empty req = {};
        return self.grpcClient->nonBlockingExecute("grpcservices.HelloWorld3/testFloatArrayOutput", req, msgListener, headers);
    }

    public remote function testBooleanArrayOutput(service msgListener, Headers? headers = ()) returns (Error?) {
        Empty req = {};
        return self.grpcClient->nonBlockingExecute("grpcservices.HelloWorld3/testBooleanArrayOutput", req, msgListener, headers);
    }

    public remote function testStructArrayOutput(service msgListener, Headers? headers = ()) returns (Error?) {
        Empty req = {};
        return self.grpcClient->nonBlockingExecute("grpcservices.HelloWorld3/testStructArrayOutput", req, msgListener, headers);
    }
};

