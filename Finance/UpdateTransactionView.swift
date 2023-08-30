//
//  AddTransactionView.swift
//  Finance
//
//  Created by Gautam Menon on 27/08/23.
//

import SwiftUI

struct UpdateTransactionView: View {
    let myId: String = StorageService.getUser()
    let otherId: String = StorageService.getOtherUser()
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State var mode = 0
    @State var amount = ""
    @State var reason = ""
    @State var alertMessage = "";
    @State var selectedId: String = ""
    
    var body: some View {
        VStack (spacing: 40){
            Picker("", selection: $mode) {
                Text("Pay Bill").tag(0)
                Text("Add Transaction").tag(1)
            }
            .pickerStyle(.segmented)
            if mode == 0 {
                PayBillView(myId: myId, otherId: otherId, closeSheet: closeFunction, reason: $reason, amount: $amount, selectedId: $selectedId, alertMessage: $alertMessage)
            } else {
                AddTransactionView(myId: myId, otherId: otherId, amount: $amount, reason: $reason, alertMessage: $alertMessage, closeSheet: closeFunction)
            }
        }
        .padding()
        .alert("\(alertMessage)", isPresented: Binding(get: {!alertMessage.isEmpty}, set: {
            newValue in
            self.alertMessage = ""
        })) {
            Button("OK", role: .cancel) { }
        }
        .onAppear{
            selectedId = myId
        }
        .navigationBarItems(trailing: Button("Cancel",
                                             action: closeFunction))
    }
    
    private func closeFunction(){
        presentationMode.wrappedValue.dismiss()
    }
}

struct UpdateTransaction_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTransactionView()
    }
}
