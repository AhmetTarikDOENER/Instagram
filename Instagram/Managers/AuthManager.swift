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
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        // TODO: -Check if username is available, -Check if email is available
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) {
            canCreate in
            if canCreate {
                //  -Create account
                Auth.auth().createUser(withEmail: email, password: password) {
                    result, error in
                    guard error == nil, result != nil else {
                        // Firebase auth could not create account
                        completion(false)
                        return
                    }
                    // Insert to database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) {
                        inserted in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            completion(false)
                            return
                        }
                    }
                    
                }
            } else {
                // either username or email does not exist
                completion(false)
            }
        }
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
