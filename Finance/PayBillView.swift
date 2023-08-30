//
//  PayBillView.swift
//  Finance
//
//  Created by Gautam Menon on 30/08/23.
//

import SwiftUI


struct PayBillView: View {
    let myId: String
    let otherId: String
    let closeSheet: ()->()
    @Binding var reason: String
    @Binding var amount: String
    @Binding var selectedId: String
    @Binding var alertMessage: String
    
    var body: some View {
        VStack(spacing: 40){
            Text("Who's Paying?")
                .font(.headline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack (spacing: 20) {
                PersonTile(selectedId: $selectedId, color: appColor, name: myId)
                PersonTile(selectedId: $selectedId, color: secondaryColor, name: otherId)
            }
            
            HStack {
                if !amount.isEmpty {
                    Text("\(rupeeSign)")
                }
                TextField("\(rupeeSign)", text: $amount).lineLimit(2)
                    .multilineTextAlignment(.center)
                    .frame(width: CGFloat(amount.count == 0 ? 2 : amount.count) * 20, alignment: .center)
                    .keyboardType(.numberPad)
            }
            .font(.title)
            .fontWeight(.semibold)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.blue, lineWidth: 1)
            )
            TextField("Reason (Optional)", text: $reason, axis: .vertical)
                .lineLimit(2...10)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.blue, lineWidth: 1))
            if(Int(amount) != nil){
                let text = selectedId == myId ? "\(otherId) Owes You: " : "You Owe \(otherId): "
                Text("\(text)\(rupeeSign)\(Int(amount)!/2)")
                    .font(.title2)
            }
            
            Spacer()
            Button
            {
                Task {
                    if(amount.isEmpty){
                        alertMessage = "No amount entered"
                        return;
                    }
                    //                    isLoading = true;
                    var finalAmount = Int(amount) ?? 0
                    finalAmount.negate()
                    let timeStamp:Double = Date()
                        .timeIntervalSince1970
                    let model = TransactionModel(amount: finalAmount/2, timeStamp: timeStamp, name: selectedId == myId ? otherId  : myId, reason: reason)
                    await FirebaseServices().uploadTransaction(model: model)
                closeSheet()
                }
            }
        label: {
            HStack {
                Image(systemName: "plus")
                    .fontWeight(.bold)
                Text("Add transaction")
            }
            .foregroundColor(.white)
            .frame(width: 200, height: 40)
            .background(Color.blue)
            .cornerRadius(15)
            .padding()
        }.frame(maxWidth: .infinity, alignment: .center)
            
        }
    }
}
