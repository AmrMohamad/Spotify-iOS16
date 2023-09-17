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
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
}
