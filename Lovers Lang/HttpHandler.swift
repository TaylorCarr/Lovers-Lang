//
//  HttpHandler.swift
//  Lovers Lang
//
//  Created by Taylor Carr on 10/17/24.
//

import Foundation

class httpHandler {
    var apiUrl: URL
    var const: Constants
    var request: URLRequest
//    @ObservedObject var userInfo: UserInfo
    
    init () {
        self.const = Constants()
        self.apiUrl = URL(string: const.API_URL)!
        self.request = URLRequest(url: apiUrl)
        request.allowsCellularAccess = true
        request.addValue(const.API_KEY, forHTTPHeaderField: "x-api-key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    func createUser(userId: String, username: String, firstName: String, lastName: String, userScore: QuizScoreStruct) {
        let json: [String: Any] = [ "message": ["userId":userId, "email":username, "name":"\(firstName) \(lastName)", "score": userScore]]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
//        var request = URLRequest(url: self.apiUrl)
        request.httpMethod = "POST"
//        request.allowsCellularAccess = true
//        request.addValue(const.API_KEY, forHTTPHeaderField: "x-api-key")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }

        task.resume()
    }
    
    func attachUser(userId: String, username: String, partnerId: String, partnerUsername: String) {
        let json: [String: Any] = [ "message": ["userId":userId, "username":username, "partnerId":partnerId, "partnerUsername": partnerUsername]]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpMethod = "PUT"
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }

        task.resume()
    }
    
    func getScore(userId: String, username: String) -> [String: Any] {
        var scoreResponse: [String: Any] = [:]
        let sem = DispatchSemaphore.init(value: 0)
        
        request.httpMethod = "GET"
        request.addValue(userId, forHTTPHeaderField: "X-User-Id")
        request.addValue(username, forHTTPHeaderField: "X-User-Email")

        let task = URLSession.shared.dataTask(with: self.request, completionHandler: { (data, response, error) in
            print("inside url session")
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("response json below")
                print(responseJSON)
                scoreResponse = responseJSON
                sem.signal()
            }
            
        })
        task.resume()
        sem.wait()
        
        return scoreResponse
    }
}
