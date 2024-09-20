//
//  QuizView.swift
//  MatheMentor
//
//  Created by Mark Eggebrecht on 03.06.24.
//

import SwiftUI

struct QuizView: View {
    @State var answer: String = ""
    @State var leben: Int = 3
    @State var score: Int = 0
    @State private var alertMessage = ""
    @State private var navigateToHome = true
    @StateObject private var viewModel = QuizViewModel()
    @State private var showOverlay = false
    @State private var overlayColor: Color = .clear
    @State private var gameIsOver = false
    @State private var timer: Timer? = nil
    @State private var timeRemaining: Int = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    ZStack {
                        Image(systemName: "brain")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                        Text("MatheMentor")
                            .font(.title)
                            .background(Color.white)
                    }
                    Text("Soviel Leben hast du noch")
                    HStack{
                        ForEach(0..<viewModel.hearts, id:\.self){ _ in
                            Image("herz")
                                .resizable()
                                .frame(width: 70, height: 50)
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                    
                    if viewModel.hearts != 0 {
                        Text("Löse die Aufgabe:")
                            .font(.title3)
                        
                        HStack {
                            Text(String(viewModel.quiz.number1))
                                .font(.title)
                            Text(String(viewModel.quiz.formel))
                                .font(.title)
                            Text(String(viewModel.quiz.number2))
                                .font(.title)
                            Text("=")
                        }
                        TextField("Deine Antwort", text: $answer)
                            .keyboardType(.numberPad)
                            .font(.title)
                            .cornerRadius(20.0)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .shadow(radius: 5)
                            .frame(width: 200)
                        
                        Button("Bestätigen") {
                            if viewModel.checkAnswer(answer: Int(answer) ?? 0) {
                                overlayColor = .green
                                showOverlay = true
                                viewModel.getQuiz()
                                answer = ""
                                score += 1
                                viewModel.addPoints(points: score)
                                print(String(viewModel.user.points))
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    showOverlay = false
                                }
                            } else {
                                viewModel.hearts -= 1
                                overlayColor = .red
                                showOverlay = true
                                answer = ""
                                
                                if viewModel.hearts == 0 {
                                    viewModel.userToHighScore()
                                    gameIsOver = true
                                } else {
                                    viewModel.getQuiz()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    showOverlay = false
                                }
                            }
                        }
                        .tint(.black)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .bold()
                        .shadow(radius: 10)
                        .padding()
                    } else {
                        Text("Deine letzten 5 Rechnungen")
                    }
                    
                    VStack {
                        ForEach(viewModel.archive.suffix(5).reversed()) { archiv in
                            HStack {
                                Text(String(archiv.number1))
                                    .font(.title)
                                    .foregroundColor(archiv.color.opacity(0.5))
                                Text(String(archiv.formel))
                                    .font(.title)
                                    .foregroundColor(archiv.color.opacity(0.5))
                                Text(String(archiv.number2))
                                    .font(.title)
                                    .foregroundColor(archiv.color.opacity(0.5))
                                Text("=")
                                    .foregroundColor(archiv.color.opacity(0.5))
                                if archiv.result == archiv.answer {
                                    Text(String(archiv.answer))
                                        .font(.title)
                                        .foregroundColor(archiv.color.opacity(0.5))
                                } else {
                                    Text(String(archiv.answer))
                                        .font(.title)
                                        .foregroundColor(archiv.color.opacity(0.5))
                                    Text("Richtig:")
                                        .foregroundColor(.green.opacity(0.5))
                                    Text(String(archiv.result))
                                        .font(.title)
                                        .foregroundColor(.green.opacity(0.5))
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // Timer-Fortschrittsbalken hinzufügen
                    if viewModel.selectedtimerOn{
                        ProgressBar(value: $timeRemaining, maxValue: viewModel.newtimerDuration)
                            .frame(height: 20)
                            .padding()
                    }
                }
                .onAppear {
                    viewModel.loadUserSettings()
                    if viewModel.selectedtimerOn {
                        timeRemaining = viewModel.newtimerDuration
                        startTimer()
                    }
                    viewModel.getQuiz()
                }
                if showOverlay {
                    overlayColor
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.5)
                        .transition(.opacity)
                }
            }
        }
        .fullScreenCover(isPresented: $gameIsOver) {
            GameOverView()
        }
        Text("Richtige Aufgaben")
        Text(String(score))
        Spacer()
    }
    
    // Timer-Logik hinzufügen
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if viewModel.hearts != 0{
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timer?.invalidate()
                    viewModel.hearts = 0
                    viewModel.userToHighScore()
                    gameIsOver = true
                }} else{
                    timer?.invalidate()
                }
        }
    }
}

#Preview {
    QuizView()
}
