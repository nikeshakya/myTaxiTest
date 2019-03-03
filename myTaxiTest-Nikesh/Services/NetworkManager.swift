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
    fileprivate func parseSuccessResultData(serverData: Any, completion: @escaping responseBlock) {
        if let data = serverData as? NSDictionary {
            completion(data, nil)
        }
        else if let data = serverData as? NSArray {
            completion(data, nil)
        }
        else if let data = serverData as? Int {
            completion(data, nil)
        }
        else {
            let parseError = NSError(domain: "NikeshAppError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid Server Data format."])
            completion(nil, parseError)
        }
    }
    
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
