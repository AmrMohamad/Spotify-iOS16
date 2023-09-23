//
//  AuthManager.swift
//  Spotify-iOS16
//
//  Created by Amr Mohamad on 13/09/2023.
//

import Foundation

///The Auth Manager is responsible for handling all the authentication logics
final class AuthManager {
    static let shared = AuthManager()
    
    private init(){}
    
    public var signInURL : URL? {
        let baseURL   = "https://accounts.spotify.com/authorize?"
        let clientID  = "client_id=\(Constants.clientID)"
        let response  = "response_type=code"
        let redirect  = "redirect_uri=https://github.com/AmrMohamad/Spotify-iOS16"
        let scopes    = "scope=user-read-private"
        let dialog    = "show_dialog=TRUE"
        let urlString = "\(baseURL)\(clientID)&\(response)&\(redirect)&\(scopes)&\(dialog)"
        return URL(string: urlString)
    }
    var isSignedIn: Bool{
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        let currentDate = Date()
        let fiveMins: TimeInterval = 300
        
        return currentDate.addingTimeInterval(fiveMins) >= expirationDate
    }
    
    public func exchangeCodeForToken (
        code: String,
        completion: @escaping ((Bool) -> Void)
    ) {
        // Get Token
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "authorization_code"),
            URLQueryItem(name: "code",
                         value: code),
            URLQueryItem(name: "redirect_uri",
                         value: "https://github.com/AmrMohamad/Spotify-iOS16")
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody   = components.query?.data(using: .utf8)
        
        let basicToken    =  Constants.clientID+":"+Constants.clientSecret
        let data          = basicToken.data(using: .utf8)
        guard let basic64String = data?.base64EncodedString() else {
            completion(false)
            return
        }
        request.setValue("Basic \(basic64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data,
                  error == nil else {
                completion(false)
                return
            }
            
            do {
                let json = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: json)
                completion(true)
                
            }catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
     
    public func refreshIfNeeded(completion: @escaping (Bool)-> Void) {
//        guard shouldRefreshToken else {
//            completion(true)
//            return
//        }
        guard let refreshToken = self.refreshToken else {
            return
        }
        
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "refresh_token"),
            URLQueryItem(name: "refresh_token",
                         value: refreshToken)
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody   = components.query?.data(using: .utf8)
        
        let basicToken    =  Constants.clientID+":"+Constants.clientSecret
        let data          = basicToken.data(using: .utf8)
        guard let basic64String = data?.base64EncodedString() else {
            completion(false)
            return
        }
        request.setValue("Basic \(basic64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data,
                  error == nil else {
                completion(false)
                return
            }
            
            do {
                let json = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: json)
                completion(true)
                
            }catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.access_token,
                                       forKey: "access_token")
        if let refreshToken = result.refresh_token {
            UserDefaults.standard.setValue(refreshToken,
                                           forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)),
                                       forKey: "expirationDate")
    }
}
