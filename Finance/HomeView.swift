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
    @ObservedObject private var viewModel = FirebaseServices()
    
    var body: some View {
        
        ZStack{
            Color(.systemGroupedBackground)
                .edgesIgnoringSafeArea([.bottom])
            LoadingView (isLoading: $isLoading) {
                VStack (spacing: 10) {
                    ProfitTitle(totalAmount: viewModel.totalBalance)
                    FilterView(filter: $filter, reloadWithLoader: reloadWithLoader)
                    TransactionList(viewModel: viewModel, filter: filter)
                }
            }
        }
        .refreshable {
            await viewModel.downloadData(filter)
        }
        .task{
            await reloadWithLoader()
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    withAnimation {
                    }
                } label: {
                    Image(systemName: "gear")
                        .foregroundColor(.black)
                }
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    addTransactionSheet.toggle()
                }   label: {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
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
    }

    private func reloadWithLoader() async {
        isLoading = true
        await viewModel.downloadData(filter)
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
