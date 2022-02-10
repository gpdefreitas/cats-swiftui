//
//  DataProvider.swift
//  Cats
//
//  Created by Gui Freitas on 2022-02-09.
//

import Foundation

enum DataProviderError: Error {
    case invalidResponse
}

protocol DataProviding {
    func fetch<T: Decodable>(from url: URL) async throws -> Result<T, DataProviderError>
}

struct DataProvider: DataProviding {
    func fetch<T: Decodable>(from url: URL) async throws -> Result<T, DataProviderError> {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else { return .failure(.invalidResponse) }

        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return .success(decodedData)
    }
}

#if DEBUG
struct CatsDataProviderMock: DataProviding {
    func fetch<T: Decodable>(from url: URL) async throws -> Result<T, DataProviderError> {
        if let url = Bundle.main.url(forResource: "cats", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let decodedData = try? JSONDecoder().decode(T.self, from: data) {
                return .success(decodedData)
        } else {
            return .failure(.invalidResponse)
        }
    }
}
#endif
