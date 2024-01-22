//
//  LoginManager.swift
//  OAuthApp
//
//  Created by Wonji Ha on 1/22/24.
//

import UIKit

class LoginManager {
    static let shared = LoginManager()
    weak var delegate: LoginManagerDelegate? // 2. 만든 프로토콜을 델리게이트로 불러준다.
    
    static var name: String?
    static var imgUrl: String?
    
    init () {}
    
    private let client_id = ""
    private let client_secret = ""
    
    func requestCodeToGithub() {
        let scope = "repo, user"
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(client_id)&scope=\(scope)"
            if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                // redirect to scene(_:openURLContexts:) if user authorized
            }
    }
                
     func requestAccessTokenToGitHub(with code: String) {
        guard let url = URL(string: "https://github.com/login/oauth/access_token") else { return }
        let parameters = ["client_id": client_id,
                          "client_secret": client_secret,
                          "code": code]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(
            with: request as URLRequest, completionHandler: { data, response, error in
                guard let data = data else { return }
                print("data: ",data)
                guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print(String(data: data, encoding: .utf8) ?? "Not String!")
                    return
                }
                self.getUser(accessToken: json["access_token"] as! String)
            })
        task.resume()
    }
    
    func getUser(accessToken: String) {
        print("My AccessToken = \(accessToken)")
        guard let url = URL(string: "https://api.github.com/user") else { return }
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(
            with: request as URLRequest, completionHandler: { data, response, error in
                guard let data = data else { return }
                guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print(String(data: data, encoding: .utf8) ?? "Not String!!")
                    return
                }
            print(json["avatar_url"] as Any)
            print(json["name"] as Any)
                
                guard let name = json["name"] as? String else {return}
                guard let url = json["avatar_url"] as? String else {return}
                self.delegate?.loadData(self, name: name, imageURL: url) // 3. 담을 정보를 델리게이트를 호출에 정보를 넘겨준다.
         })
        task.resume()
    }

    
}


