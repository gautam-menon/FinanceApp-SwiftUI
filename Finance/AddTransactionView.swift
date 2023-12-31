//
//  AddTransactionView.swift
//  Finance
//
//  Created by Gautam Menon on 30/08/23.
//

import SwiftUI

struct AddTransactionView: View {
    let myId: String
    let otherId: String
    //    @State var amount = ""
    //    @State var reason = ""
    //    @State var alertMessage = "";
    @State var animation = false
    @Binding var amount: String
    @Binding var reason: String
    @Binding var alertMessage: String
    let closeSheet: ()->()
    var body: some View {
        VStack(spacing: 40){
            Text("How much do you owe \(otherId)?")
                .font(.headline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack{
                Text(otherId.uppercased().prefix(1))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.black)
                    .background(secondaryColor)
                    .clipShape(Circle())
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(otherId.capitalized)
                    .fontWeight(.bold)
                    .foregroundColor(secondaryColor)
            }
            .scaleEffect(1.2)
            Image(systemName: "arrow.up.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.green)
                .scaleEffect(animation ? 1.2 : 1.1)
            
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
            if let amount = Int(amount){
                let text = "You Owe \(otherId): "
                Text("\(text)\(rupeeSign)\(amount)")
                    .font(.title2)
            }
            
            Spacer()
            Button {
                Task {
                    var finalAmount = Int(amount) ?? 0
                    if(amount.isEmpty){
                        alertMessage = "No amount entered"
                        return;
                    } else if (finalAmount < 1){
                        alertMessage = "Incorrect Amount entered"
                        return;
                    }
                    finalAmount.negate()
                    let timeStamp:Double = Date().timeIntervalSince1970
                    let model = TransactionModel(amount: finalAmount, timeStamp: timeStamp, name: otherId, reason: reason)
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
        .onAppear{
            startAnimation()
        }
    }
    
    func startAnimation(){
        withAnimation(.easeInOut(duration: 1).repeatForever()) {
            animation = true
        }
    }
}
