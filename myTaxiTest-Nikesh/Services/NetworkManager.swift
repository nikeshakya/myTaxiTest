//
//  NetworkManager.swift
//  myTaxiTest-Nikesh
//
//  Created by Nikesh Shakya on 3/1/19.
//  Copyright © 2019 Nikesh Shakya. All rights reserved.
//

import Foundation
import Alamofire

class NetworkRequestManager {
    
    /// Maps Response data from server into matching object or data types otherwise throws error
    ///
    /// - Parameters:
    ///   - serverData: data response from successful server request
    ///   - completion: clousure object containing mapped object or error
    fileprivate func parseSuccessResultData(serverData: Any, completion: @escaping responseBlock) {
        if let data = serverData as? NSDictionary {
            completion(data, nil)
            return
        }
        else if let data = serverData as? NSArray {
            completion(data, nil)
            return
        }
        else if let data = serverData as? Int {
            completion(data, nil)
            return
        }
        else {
            let parseError = NSError(domain: "NikeshAppError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid Server Data format."])
            completion(nil, parseError)
            return
        }
    }
    
    /// Hits data request to given server link with specified parameters, request method and headers.
    ///
    /// - Parameters:
    ///   - urlLink: url link of api server
    ///   - parameters: parameters to be sent to api
    ///   - method: request method to the link
    ///   - headers: header value to be attached in the request
    ///   - completion: closure object containing server response result
    func processApiRequest(urlLink: String, parameters: Parameters, method: HTTPMethod,  headers: HTTPHeaders, completion: @escaping responseBlock) {
        let ApiRequest = Alamofire.request(urlLink, method: method, parameters: parameters, encoding: URLEncoding(destination: .methodDependent) , headers: headers)
        ApiRequest.validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                self.parseSuccessResultData(serverData: data, completion: completion)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
