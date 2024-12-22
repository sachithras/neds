//
//  NedsURLSessionClient.swift
//  Neds
//
//  Created by Sachithra Udayanga on 20/12/24.
//

import Foundation
import Combine

class NedsURLSessionClient<EndpointType: APIEndpoint>: APIProtocol {
    
    func request<T: Codable>(endpoint: EndpointType) -> AnyPublisher<T, Error> {
        
        guard let baseURL = endpoint.baseURL else {
            return Fail(error: NedsAPIError.urlFormatError).eraseToAnyPublisher()
        }
        
        let queryItems = endpoint.parameters?.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        // endpoint.parameters?.forEach { url.append(queryItems: [URLQueryItem(name: $0.key, value: $0.value)]) }
        
        var url = baseURL
        
        if let queryItems = queryItems {
            url = url.appendingPathComponent(endpoint.path).appending(queryItems: queryItems)
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw NedsAPIError.responseError
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({ error in
                if let decodingError = error as? DecodingError {
                    return decodingError
                }
                return error
            })
            .eraseToAnyPublisher()
    }
}
