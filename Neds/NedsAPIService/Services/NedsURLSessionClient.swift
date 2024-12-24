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
        guard let url = constructURL(from: endpoint) else {
            return Fail(error: NedsAPIError.urlFormatError).eraseToAnyPublisher()
        }
        
        let request = createRequest(from: endpoint, with: url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response in
                try self.validateResponse(data: data, response: response)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                self.mapError(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: - Helper Methods
    private func constructURL(from endpoint: EndpointType) -> URL? {
        guard let baseURL = endpoint.baseURL,
              var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.parameters?.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        return urlComponents.url
    }
    
    private func createRequest(from endpoint: EndpointType, with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }
    
    private func validateResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NedsAPIError.responseError
        }
        return data
    }
    
    private func mapError(_ error: Error) -> Error {
        if let decodingError = error as? DecodingError {
            return NedsAPIError.decodingError(decodingError)
        }
        return NedsAPIError.unknown(error)
    }
}
