//
//  Service.swift
//  GitHub
//
//  Created by Joao Paulo Cavalcante dos Anjos on 4/4/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation


class Service {
    
    // MARK: - HttpMethod
    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
        case put = "PUT"
    }
    
    // MARK: -
    func request<T: Codable>(_ method: HttpMethod, urlString: String, parameters: Any? = nil, headers: [String: String]? = nil,
                             onSuccess: @escaping (_ data: T?) -> Void,
                             onFailure: @escaping (_ error: ErrorResponse) -> Void,
                             onCompleted: @escaping ()-> Void) -> Void {
        
        guard let encodeUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: encodeUrl) else {
         
            onFailure(ErrorResponse(message: "Json serialization error.", documentation_url: nil))
            onCompleted()
            return
        }
     
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let headers = headers{
            for header in headers {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch {
               onFailure(ErrorResponse(message: "Json serialization error.", documentation_url: nil))
                onCompleted()
            }
        }
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            
            var errorResponse: ErrorResponse?
            
            if error != nil {
                errorResponse = ErrorResponse(message: "Unknown error.", documentation_url: nil)
            }
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, !(statusCode >= 200 && statusCode <= 299) {
                if let data = data {
                    let errorResponse: ErrorResponse = JSON.decode(data: data)!
                    onFailure(errorResponse)
                } else {
                    errorResponse = ErrorResponse(message: "Unknown error.", documentation_url: nil)
                }
            }
            
            DispatchQueue.main.async {
                if let errorResponse = errorResponse {
                      onFailure(errorResponse)
                } else {
                    if let data = data, let obj:T = JSON.decode(data: data) {
                        onSuccess(obj)
                    } else {
                        onSuccess(nil)
                    }
                }
                onCompleted()
            }

            }.resume()

    }
}
