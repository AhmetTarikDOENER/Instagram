//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 30.10.2023.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    /// Check if username and email is available
    /// - Parameters:
    ///   - email: representing email
    ///   - username: representing username
    public func canCreateNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    /// Insert new user data to database
    /// - Parameters:
    ///   - email: representing email
    ///   - username: representing username
    ///   - completion: Async callback for result if database entry succeded.
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username": username]) {
            error, _ in
            if error == nil {
                completion(true)
                return // So that it doesnt fallthrough even is just simple if else. Not necessery
            } else {
                completion(false)
                return
            }
        }
    }
    
}
