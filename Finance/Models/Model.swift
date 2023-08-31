//
//  transactionModel.swift
//  Finance_example
//
//  Created by Gautam on 29/11/22.
//

import Foundation
//import FirebaseFirestore

struct TransactionModel:Hashable, Codable{
    
    var amount:Int
    var timeStamp:Double
    var name:String
    var reason:String?
    var documentId:String?
    
    static var transactions: [TransactionModel] = []
    
    static func addTransaction(model: TransactionModel) async{
        Task {
            try await Task.sleep(for: .microseconds(500))
            print("\(model)")
            if let encoded = try? JSONEncoder().encode(model) {
                UserDefaults.standard.set(encoded, forKey: "SavedData")
            }
        }
    }
    
    static func getTransactions(myId: String) async ->[TransactionModel]? {
        if let data = UserDefaults.standard.data(forKey: "SavedData") {
            if let decoded = try? JSONDecoder().decode(TransactionModel.self, from: data) {
                print(decoded)
                return [decoded]
            }
        }
        return nil;
    }
}
