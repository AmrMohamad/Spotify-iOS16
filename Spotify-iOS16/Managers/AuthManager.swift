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
