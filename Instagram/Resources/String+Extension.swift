//
//  String+Extension.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 31.10.2023.
//

import Foundation

extension String {
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
}
