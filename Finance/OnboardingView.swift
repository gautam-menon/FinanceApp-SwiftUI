//
//  ContentView.swift
//  Finance
//
//  Created by Gautam Menon on 26/08/23.
//

import SwiftUI

struct OnboardingView: View {
    @State private var user = StorageService.getUser()
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("cat")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(
                           Circle()
                            .stroke(appColor, lineWidth: 4)
                       )
               
           Spacer()
                NavigationLink {
                    HomeView()
//                    Toggle(isOn: $isDarkMode, label: {
//                                    Text("Dark Mode")
//                                })
//                        .navigationBarBackButtonHidden(true)
                }
            label: {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(appColor)
                    .frame(height: 40)
                    .overlay{
                        Text("Let's go!")
                            .font(.headline)
                              .foregroundColor(.white)
                    }
                
            }

            }
            .padding()
            .navigationTitle("Hi \(user)!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
