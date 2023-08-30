//
//  Helper.swift
//  Finance
//
//  Created by Gautam Menon on 26/08/23.
//

import Foundation

struct StorageService {
   static func getUser() -> String {
       return "Gautam"
    }
    
    static func getOtherUser() -> String {
        return "Khushee"
    }
}

public let currencyy: NumberFormatter = {
    let num = NumberFormatter()
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
