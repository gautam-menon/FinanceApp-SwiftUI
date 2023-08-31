//
//  Extensions.swift
//  Finance
//
//  Created by Gautam Menon on 31/08/23.
//

import Foundation

extension Int {
    func convertToPositive()->Int{
        var amt = self
        if(amt < 0){
            amt.negate()
        }
        return amt;
    }
}

extension TransactionModel{
    static let samples = [
        TransactionModel(amount: 100, timeStamp: 234, name: "Gautam", reason: "Movie", documentId: ""),
        TransactionModel(amount: 150, timeStamp: 324, name: "Bob", documentId: ""),
        TransactionModel(amount: 120, timeStamp:234, name: "You",reason: "Food", documentId: ""),
        TransactionModel(amount: 120, timeStamp: 23432, name: "You",reason: "Food", documentId: ""),
    ]
}
