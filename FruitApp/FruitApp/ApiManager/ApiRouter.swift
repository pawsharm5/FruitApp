//
//  APIRouterStructer.swift
//  FruitApp
//
//  Created by Pawan Sharma on 11/08/23.
//

import Foundation

// MARK: - API Request Router -
final class APIRouter<EndPoint: EndPointType> {
    private var task: URLSessionTask?
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    /// `initializer`
    init() {
    }
    
    /// Build API Request
    /// - Parameters:
    ///   - route: End Point
    ///   - decode: T (custom model class) as Decodable
    ///   - completion: data, response & error
    func request<T: Decodable>(_ route: EndPoint,
                               decode: @escaping (Decodable) -> T?,
                               completion: @escaping (Result<T, APIError>) -> Void) {
        
        guard ConnectionSettings.isConnected else {
            completion(.failure(.unreachable))
            return
        }
        
        var components = URLComponents()
        components.scheme = route.scheme
        components.host = route.baseURL
        components.path = route.path
        components.queryItems = route.parameters
        
        guard let url = components.url else {
            completion(.failure(.somethingWentWrong))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = route.httpMethod.rawValue
        urlRequest.httpBody = route.data
        
        var headers = route.headers ?? []
        
        headers.forEach { urlRequest.addValue($0.header.value, forHTTPHeaderField: $0.header.field) }
#if DEBUG
        print(urlRequest)
#endif
        self.task = decodingTask(with: urlRequest, decodingType: T.self) { [weak self] (json, error) in
            
            DispatchQueue.main.async {
                if error != nil && error == APIError.unauthorized {
                    
                    return
                }
                guard let json = json else {
                    completion(error != nil ?
                        .failure(.responseUnsuccessful(description: error!.description)) :
                            .failure(.somethingWentWrong))
                    return
                }
                guard let value = decode(json) else {
                    completion(.failure(.jsonDecodingFailure))
                    return
                }
                completion(.success(value))
            }
        }
        
        self.task?.resume()
    }
    
    /// Request cancellation
    func cancel() {
        self.task?.cancel()
    }
    
    // MARK: - Parsing response
    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed(description: error?.localizedDescription ?? "## Request Fail"))
                return
            }
            
            if httpResponse.statusCode == 401 {
                completion(nil, .unauthorized)
                return
            }
            
            if httpResponse.statusCode == 204 ||
                httpResponse.statusCode == 202 {
                completion(EmptyData(), nil)
                return
            }
            
            guard let data = data else {
                completion(nil, .somethingWentWrong)
                return
            }
#if DEBUG
            print(request.url as Any)
#endif
            var errorData: APIErrorResponseModel?
            do {
                errorData = try JSONDecoder().decode(APIErrorResponseModel.self, from: data)
            } catch {}
            
            if errorData != nil {
                completion(nil, .custom(model: errorData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
#if DEBUG
                
                let genericModel = try! decoder.decode(decodingType, from: data)
                
#else
                let genericModel = try decoder.decode(decodingType, from: data)
#endif
                
                completion(genericModel, nil)
                
            }
        }
        return task
    }
}
