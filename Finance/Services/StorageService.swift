//
//  StorageService.swift
//  Finance
//
//  Created by Gautam Menon on 31/08/23.
//

import Foundation

struct StorageService {
    static private let swapUsers = true
    static private let userOne = "Gautam"
    static private let userTwo = "Khushee"
    
   static func getUser() -> String {
       return !swapUsers ? userOne : userTwo
    }
    
    static func getOtherUser() -> String {
        return swapUsers ? userOne : userTwo
    }
}
