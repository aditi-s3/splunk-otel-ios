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

import Foundation
import MRUMSharedProtocols

public struct NetworkInstrumentationConfiguration: ModuleConfiguration {}

public struct NetworkInstrumentationRemoteConfiguration: RemoteModuleConfiguration {

    // MARK: - Internal decoding

    struct NetworkTracing: Decodable {
        let enabled: Bool
    }

    struct MRUMRoot: Decodable {
        let networkTracing: NetworkTracing
    }

    struct Configuration: Decodable {
        let mrum: MRUMRoot
    }

    struct Root: Decodable {
        let configuration: Configuration
    }


    // MARK: - Protocol compliance

    public var enabled: Bool

    public init?(from data: Data) {
        guard let root = try? JSONDecoder().decode(Root.self, from: data) else {
            return nil
        }

        enabled = root.configuration.mrum.networkTracing.enabled
    }
}