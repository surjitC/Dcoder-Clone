//
//  ServiceHandler.swift
//  Dcoder Clone
//
//  Created by Hemant Gore on 01/02/20.
//  Copyright © 2020 Dream Big. All rights reserved.
//

import Foundation

// MARK: - REST Verbs
enum RequestType: String {
    case GET
    case POST
    case PUT
    case DELETE
}

// MARK: - APPError enum which shows all possible errors
public enum APPError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
}

//MARK: - Result enum to show success or failure
public enum CustomResult<T> {
    case success(T)
    case failure(APPError)
}

class ServiceHandler {
    
    static let sharedInstance = ServiceHandler()
    
    private init() {}
    
    func getAPIData<T: Decodable>(URLString: String, method: RequestType = .GET, objectType: T.Type, completion: @escaping ((CustomResult<T>) -> Void)) {
        
        guard let dataURL = URL(string: URLString) else { return }
        
        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        var request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.httpMethod = method.rawValue

        //adding headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(CustomResult.failure(.networkError(error!)))
                return
            }
            guard let data = data else {
                completion(CustomResult.failure(.dataNotFound))
                return
            }
            do {
                let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                completion(CustomResult.success(decodedObject))
                debugPrint(decodedObject)
            } catch {
                debugPrint("fail to parse json")
            }
            debugPrint(data)
        }
        task.resume()
    }
    
    func downloadImage(imageURL: String, completion: @escaping ((Data?) -> Void)) {
        
        guard let dataURL = URL(string: imageURL) else { return }
        
        //create the session object
            let session = URLSession.shared
        
            let task = session.dataTask(with: dataURL) { (data, response, error) in
                guard error == nil else {
                    completion(nil)
                    return
                }
                guard let data = data else {
                    completion(nil)
                    return
                }
                completion(data)
            }
            task.resume()
    }
}
