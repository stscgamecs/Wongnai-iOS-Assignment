//
//  ApiService.swift
//  Wongnai-iOS-Assignment
//
//  Created by Z94me on 30/10/2562 BE.
//  Copyright © 2562 Z94me. All rights reserved.
//

import Foundation

class ApiService {
    
    func getApi(page: Int,_ completion: @escaping (Result<Model, Error>) -> Void) {
        guard let url = URL(string: "https://api.500px.com/v1/photos?feature=popular&page=\(page)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let urlError = error {
                DispatchQueue.main.async {
                    completion(Result.failure(urlError))
                }
            }
            else if let data = data, let response = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    if response.statusCode == 200 {
                        do {
                            let tableList: Model = try JSONDecoder().decode(Model.self, from: data)
                            completion(Result.success(tableList))
                        } catch(let error) {
                            completion(Result.failure(error))
                        }
                    }
                }
            }
        }
        task.resume()
    }
}

