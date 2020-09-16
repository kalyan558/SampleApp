//
//  NetworkManager.swift
//  SampleApp
//
//  Created by Kalyan on 9/16/20.
//  Copyright © 2020 Kalyan. All rights reserved.
//

import Foundation

class NetworkManager {
    static var shared = NetworkManager()
    
    public func apiCall(url: String,completion:@escaping (Bool,Any?) -> ()){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: url) else {
            completion(false,nil)
            return
        }
        let task = session.dataTask(with: url) { (data, response, error) in
            if let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200 {
                completion(true,data)
            } else {
                completion(false,nil)
            }
        }
        task.resume()
    }
}
