//
//  SettingsView.swift
//  Finance
//
//  Created by Gautam Menon on 31/08/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var onlyMyTransactions: Bool
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some View {
        NavigationStack {
            List{
                Section(header: Text("Theme")){
                    Toggle("Dark Theme", isOn: $isDarkMode)
                        .background(backgroundColor)
                }
                
                Section(header: Text("Transactions")){
                    Toggle("Only my transactions", isOn: $onlyMyTransactions)
                        .background(backgroundColor)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                    }

                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(onlyMyTransactions: Binding(get: {false}, set: { x, y in
            
        }))
    }
}
