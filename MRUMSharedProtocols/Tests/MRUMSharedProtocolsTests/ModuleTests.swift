//
/*
Copyright 2024 Splunk Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

@testable import MRUMSharedProtocols
import XCTest

final class MRUMSharedProtocolsTests: XCTestCase {

    func testModuleProtocols() throws {
        // Constant Metadata, Data is generated at the start of the test.
        let testMetadata = TestEventMetadata(id: UUID().uuidString)
        let testData = TestEventData(value: UUID().uuidString)

        let testConfiguration = TestModuleConfiguration()
        let testRemoteConfiguration = TestModuleRemoteConfiguration(from: Data())

        let module = TestModule()
        module.install(
            with: testConfiguration,
            remoteConfiguration: testRemoteConfiguration
        )

        _ = TestAgent(module: module)

        // Trigger the module to emit the event.
        try module.emit(metadata: testMetadata, data: testData)
    }
}