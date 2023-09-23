//
//  AuthResponse.swift
//  Spotify-iOS16
//
//  Created by Amr Mohamad on 21/09/2023.
//

import Foundation

struct AuthResponse: Codable {
    let access_token : String
    let token_type   : String
    let scope        : String
    let expires_in   : Int
    let refresh_token: String?
}
