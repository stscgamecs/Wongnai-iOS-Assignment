//
//  ApiService.swift
//  Wongnai-iOS-Assignment
//
//  Created by Z94me on 30/10/2562 BE.
//  Copyright © 2562 Z94me. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class ApiService {
    func getApi(_ completion: @escaping (Result<Model, Error>) -> Void) {
        guard let url = URL(string: "https://api.500px.com/v1/photos?feature=popular&page=1") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                print("error")
            }
            else if let data = data, let response = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    if response.statusCode == 200 {
                        do {
                            let mobileList: Model = try JSONDecoder().decode(Model.self, from: data)
                            completion(Result.success(mobileList))
                        } catch(let error) {
                            print(error)
                            completion(Result.failure(error))
                        }
                    }
                }
            }
        }
        task.resume()
    }
}

