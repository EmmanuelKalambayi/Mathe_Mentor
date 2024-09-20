//
//  HomeView.swift
//  MatheMentor
//
//  Created by Mark Eggebrecht on 03.06.24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var name: String = ""
    @State private var gameSettings: Bool = false
    @State private var gameIsStartet: Bool = false
    
    @StateObject private var viewmodel =  QuizViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack{
                Image(systemName: "brain")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    .padding(.top, 30)
                
                Text("MatheMentor")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Text("Herzlich Willkomen")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                    .padding(.bottom,40)
                
                Text("Zitate von MatheMentoren:")
                    .font(.title2)
                Text(viewmodel.myQuotes)
                    .padding()
                    .font(.title3)
                    .italic()
                    .padding(.bottom,50)
                
                TextField("Trage dein Namen ein", text: $name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .cornerRadius(20.0)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .shadow(radius: 5)
                    .frame(width: 280)
                    .keyboardType(.namePhonePad)
                    .padding(.bottom,50)
                
                
                Button("Einstellungen") {
                    viewmodel.addName(newName: name)
                    gameSettings = true
                    
                    
                }
                .sheet(isPresented: $gameSettings, content: {
                    HomeSheetView()
                })
                .tint(.black)
                .padding()
                .background(Color.blue)
                .clipShape(Capsule())
                .bold()
                .shadow(radius: 10)
                .padding(.bottom,10)
                
                Button("Start") {
                    viewmodel.addName(newName: name)
                    gameIsStartet = true
                }
                .navigationDestination(isPresented: $gameIsStartet, destination: {
                    QuizView()
                })
                .tint(.black)
                .padding()
                .background(Color.green)
                .clipShape(Capsule())
                .bold()
                .shadow(radius: 10)
            }
            Spacer()
            
            
        }
        .onAppear{
            viewmodel.loadUserSettings()
            viewmodel.loadMyQuotes()
            viewmodel.loadUserData()
        }
    }
    
}

#Preview {
    HomeView()
}
