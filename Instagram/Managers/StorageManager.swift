//
//  StorageManager.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 30.10.2023.
//

import Foundation
import FirebaseStorage

public class StorageManager {
    
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum StorageManagerError: Error {
        case failedToDownload
    }
    
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, StorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL {
            url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            
            completion(.success(url))
        }
    }
    
}

public enum UserPostType {
    case photo, video
}


public struct UserPost {
    let postType: UserPostType
}
