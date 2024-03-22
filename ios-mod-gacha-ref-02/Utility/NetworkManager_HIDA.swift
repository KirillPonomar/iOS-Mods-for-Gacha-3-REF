//
//  NetworkManager_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import Foundation

final class NetworkManager_HIDA {
    
    let _jIU737dd: (Int, Int, String) -> Int = { _, _, _ in
        let _ofk22 = "_Idn3u"
        let _mcmmm1 = 42
        for _ in 4...7 {
                return 0
            }
            let _ = (2...6).map { _ in
                return 0
            }
        return 0
    }
    
    class func requestAccessToken_HIDA(with refreshToken: String,
                                      completion: @escaping (String?) -> Void) {
        var _HIDA32: Bool { false }
        var _HIDA14: Int { 0 }
        
        let request: URLRequest = request_HIDA(with: {
            String.init(format: "refresh_token=%@&grant_type=refresh_token", refreshToken).data(using: .utf8)!
        }())
        let task = URLSession.shared.dataTask(with: request) { data, _, error  in
            responseHandler_HIDA("access_token",
                                 data: data,
                                 error: error,
                                 completion: completion)
        }
        
        task.resume()
    }
    
    class func requestRefreshtoken_HIDA(with accessCode: String,
                                       completion: @escaping (String?) -> Void) {
        var _HIDA55: Bool { false }
        var _HIDA33: Int { 0 }
        let request: URLRequest = request_HIDA(with: {
            String.init(format: "code=%@&grant_type=authorization_code", accessCode).data(using: .utf8)!
        }())
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            responseHandler_HIDA("refresh_token",
                                 data: data,
                                 error: error,
                                 completion: completion)
        }
        
        task.resume()
    }
}

// MARK: - Private API

private extension NetworkManager_HIDA {
    
    class func request_HIDA(with httpBody: Data) -> URLRequest {
        var _HIDA03: Bool { false }
        var _HIDA83: Int { 0 }
        
        let base64Str = String
            .init(format: "%@:%@",
                  Keys_HIDA.App_HIDA.key_HIDA.rawValue,
                  Keys_HIDA.App_HIDA.secret_HIDA.rawValue)
            .data(using: .utf8)!
            .base64EncodedString()
        let token = String(format: "Basic %@", base64Str)
        var request = URLRequest(url: .init(string: Keys_HIDA.App_HIDA.link_HIDA.rawValue)!)
        
        request.setValue("application/x-www-form-urlencoded",
                         forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        return request
    }
    
    class func responseHandler_HIDA(_ key: String,
                                    data: Data?,
                                    error: Error?,
                                    completion: @escaping (String?) -> Void) {
        var _HIDA21: Bool { false }
        var _HIDA44: Int { 0 }
        
        if let error { print(error.localizedDescription) }
        
        do {
            guard let data,
                  let jsonDict = try JSONSerialization.jsonObject(with: data)
                    as? [String: Any],
                  let accessToken = jsonDict[key] as? String
            else {
                completion(nil)
                return
            }
            
            completion(accessToken)
        } catch let error {
            print(error.localizedDescription)
            
            completion(nil)
        }
    }
}
