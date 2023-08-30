//
//  TransactionList.swift
//  Finance
//
//  Created by Gautam Menon on 27/08/23.
//

import SwiftUI

struct TransactionList: View {
    @ObservedObject var viewModel: FirebaseServices
    let filter: SortTypes
    
    let myId = StorageService.getUser()
    @State private var showDeleteAlert:TransactionModel?
    
    var body: some View {
        List{
            Text("Transactions")
                .font(.title2)
                .fontWeight(.semibold)
            ForEach(viewModel.transactions, id: \.self) { transaction in
                let isMine = transaction.name == myId
                NavigationLink(destination:  TransactionView( transactionModel: transaction)
                ) {
                    TransactionTile(transaction: transaction, isMine: isMine)
                      
                }
                .deleteDisabled(!isMine)
            }
            .onDelete{(indexPath) in
                print(indexPath.first!)
                showDeleteAlert = viewModel.transactions[indexPath.first!]
            }
            .font(.callout)
            .alert("Delete transaction?", isPresented: Binding(get: {showDeleteAlert != nil}, set: {newVal in
                       print(newVal)
                   })) {
                       Button("Yes") {
                           Task{
                               if showDeleteAlert != nil {
                                   await viewModel.deleteTransaction(model: showDeleteAlert!)}
                               showDeleteAlert = nil
                               await viewModel.downloadData(filter)
                           }
                           
                       }
                       Button("No") { showDeleteAlert = nil }
                   }
        }
    }
}


struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionList(viewModel: FirebaseServices(), filter: SortTypes.Latest)
    }
}
