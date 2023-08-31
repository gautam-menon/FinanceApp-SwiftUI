//
//  TransactionView.swift
//  Finance_example
//
//  Created by Gautam on 09/12/22.
//

import SwiftUI

struct TransactionScreenView: View {
    let myId: String = StorageService.getUser()
    let  transactionModel: TransactionModel
    @Environment(\.presentationMode) var presentationMode
   
    var body: some View {
        let isMine = myId == transactionModel.name
        NavigationView {
            VStack(spacing: 20) {
                Circle()
                    .foregroundColor(isMine ? appColor : secondaryColor)
                    .frame(width: 100)
                    .overlay{
                        Text(transactionModel.name.uppercased()
                            .prefix(1))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(isMine ? .white : .black)
                    }
                DetailsTile(title: "Name", content: transactionModel.name);
                DetailsTile(title: "Amount", content: "\(transactionModel.amount.convertToPositive())");
                if let reason = transactionModel.reason {DetailsTile(title: "Reason", content: reason)}
                DetailsTile(title: "Date", content: "\(Date(timeIntervalSince1970:(transactionModel.timeStamp)).formatted(date: .abbreviated, time: .shortened))")
                if(myId == transactionModel.name){
                    Button(action: {
                        Task {
//                            await FirebaseServices().deleteTransaction(model: transactionModel)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }){
                        Text("Delete")
                            .padding(.horizontal)
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .tint(.red)}
            }
            // .navigationTitle("Transaction Details")
            //.font(.caption)
        }
        
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionScreenView(transactionModel: TransactionModel.samples.first!)
    }
}

struct DetailsTile: View {
    let title: String
    let content: String
    var body: some View {
        VStack{
            Text(title)
                .foregroundColor(.gray)
                .font(.title3)
            Text(content)
                .font(.title2)
                .fontWeight(.bold)
        }
    }
}
