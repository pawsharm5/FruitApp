//
//  APIRouterStructer.swift
//  FruitApp
//
//  Created by Pawan Sharma on 11/08/23.
//

import Foundation
import Alamofire

struct APIRouterStructer: URLRequestConvertible {
    
    let apiRouter: APIRouter
    
    func headers() -> HTTPHeaders {
        var headersDictionary = [
            "Accept": "application/json"
        ]
        /* for future use if any other requirements
        if let additionalHeaders = apiRouter.additionalHeaders {
            let additionalHeadersDictionary = additionalHeaders.dictionary
            additionalHeadersDictionary.forEach { (key, value) in
                headersDictionary[key] = value
            }
        }*/
        return HTTPHeaders(headersDictionary)
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try apiRouter.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(apiRouter.path))
        urlRequest.httpMethod = apiRouter.method.rawValue
        urlRequest.timeoutInterval = apiRouter.timeout
        urlRequest.headers = headers()
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        /* For Post Api. Right now we are supporting get apis only
        if let body = apiRouter.body {
            do {
                let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                urlRequest.httpBody = data
            } catch {
                print("Fail to generate JSON data")
            }
        }
        if let parameters = apiRouter.paramters {
            urlRequest = try apiRouter.encoding.encode(urlRequest, with: parameters)
        }*/
        //print("urlRequest: \(urlRequest)")
        return urlRequest
    }
}
