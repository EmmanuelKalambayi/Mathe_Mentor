//
//  GameOverView.swift
//  MatheMentor
//
//  Created by Mark Eggebrecht on 06.06.24.
//

import SwiftUI

struct GameOverView: View {
    @StateObject private var viewModel = QuizViewModel()
    @State private var backToHome = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack{
            Image(systemName: "brain")
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .padding(.top, 30)
            
            Text("MatheMentor")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.bottom,40)
            Spacer()
            Text("Game Over")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
                .padding(.bottom,20)
            Text("\(viewModel.user.name)")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding()
            
            Text("Das sind deine Punkte")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            Text("\(viewModel.user.points)")
                .font(.title2)
            Spacer()
            Button("Zurück") {
                print(viewModel.user.points)
                dismiss()
                backToHome.toggle()
                
            }
            
            
            .tint(.black)
            .padding()
            .background(Color.green)
            .clipShape(Capsule())
            .bold()
            .shadow(radius: 10)
        }
        .onAppear{
            viewModel.loadUserData()
        }
    }
    
}


#Preview {
    GameOverView()
}
