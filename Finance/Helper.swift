//
//  Helper.swift
//  Finance
//
//  Created by Gautam Menon on 26/08/23.
//

import Foundation

struct StorageService {
   static func getUser() -> String {
//        let userDefaults = UserDefaults()
//        let user = userDefaults.string(forKey: "selectedUser")
//        return user ?? ""
       return true ? "Khushee" : "Gautam"
    }
    static func getTheme(){
        let userDefaults = UserDefaults()
        let theme = userDefaults.integer(forKey: "theme")
        
    }
}

public let currencyy = {let num = NumberFormatter()
    num.numberStyle = .currency
    num.maximumFractionDigits = 0
    num.currencyCode = "INR"
    return num
}()

extension Int {
    func convertToPositive()->Int{
        var amt = self
        if(amt < 0){
            amt.negate()
        }
        return amt;
    }
}
