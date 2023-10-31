//
//  AuthManager.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 30.10.2023.
//

import Foundation
import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    
    //MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String) {
        // TODO: -Check if username is available, -Check if email is available, -Create account, -Insert account to database
        
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        #warning("@escaping marked because we use completion inside of another clousure. As a result scope needs to escape.")
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) {
                authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let username = username {
            print(username)
        }
    }
    
}
