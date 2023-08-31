//
//  TransactionView.swift
//  Finance
//
//  Created by Gautam Menon on 26/08/23.
//

import SwiftUI

struct HomeView: View {
    @State private var filter = SortTypes.Latest
    @State private var addTransactionSheet = false
    @State private var isLoading = false
    @State private var onlyMyTransactions = false
    @State private var isSettingsActive = false
    @ObservedObject private var viewModel = FirebaseServices()
    
    var body: some View {
        
        ZStack{
            Color(.systemGroupedBackground)
                .edgesIgnoringSafeArea([.bottom])
            LoadingView (isLoading: $isLoading) {
                VStack (spacing: 10) {
                    ProfitTitle(totalAmount: viewModel.totalBalance)
                    FilterView(filter: $filter, reloadWithLoader: reloadWithLoader)
                    TransactionList(viewModel: viewModel, filter: filter, reloadWithLoader: reloadWithLoader)
                }
            }
        }
        .refreshable {
            await viewModel.downloadData(filter, with: onlyMyTransactions)
        }
        .task{
            await reloadWithLoader()
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    withAnimation {
                        isSettingsActive.toggle()
                    }
                } label: {
                    Image(systemName: "gear")
                        .foregroundColor(.primary)
                }
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    addTransactionSheet.toggle()
                }   label: {
                    Image(systemName: "plus")
                        .foregroundColor(.primary)
                }
                
            }
        })
        .navigationTitle("\(appName)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $addTransactionSheet, onDismiss: {
            Task{
                await reloadWithLoader()
            }
        }) {
            NavigationStack{
                UpdateTransactionView()
            }
        }
        .sheet(isPresented: $isSettingsActive, onDismiss: {
            Task{
                await reloadWithLoader()
            }
        }) {
            SettingsView(onlyMyTransactions: $onlyMyTransactions)
        }
    }
    
    private func reloadWithLoader() async {
        isLoading = true
        await viewModel.downloadData(filter, with: onlyMyTransactions)
        isLoading = false
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
    }
}

struct LoadingView<Content>: View where Content: View {
    @Binding var isLoading: Bool
    var content: () -> Content
    var body: some View {
        self.content()
            .disabled(self.isLoading)
            .blur(radius: self.isLoading ? 3 : 0)
        if isLoading {
            VStack {
                Text("Loading...")
                ProgressView()
            }
        }
    }
}
