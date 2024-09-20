//
//  HighscoreView.swift
//  MatheMentor
//
//  Created by Mark Eggebrecht on 06.06.24.
//

import SwiftUI

struct HighscoreView: View {
    @StateObject private var viewmodel = QuizViewModel()
    var body: some View {
        VStack {
            Image(systemName: "brain")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.top, 50) // Abstand oben hinzufügen
            Text("MatheMentor")
                .font(.largeTitle)
                .foregroundColor(.blue) // Textfarbe hinzufügen
                .padding(.bottom, 20)
            Text("HighScore")
                .font(.title)
                .foregroundColor(.blue) // Textfarbe hinzufügen
                .padding(.bottom, 30)
            ForEach(Array(viewmodel.highscoreSortedList.enumerated()), id: \.element.id) { index, user in
                HStack {
                    Text("\(index + 1). Platz")
                        .fontWeight(.bold) // Fettdruck hinzufügen
                    Spacer()
                    Text("\(user.name)")
                        .foregroundColor(.gray) // Textfarbe hinzufügen
                    Spacer()
                    Text("\(user.points) Pkt.")
                        .foregroundColor(.green) // Textfarbe hinzufügen
                }
                .padding(.vertical, 8) // Zusätzlicher vertikaler Abstand hinzufügen
                .padding(.horizontal, 20) // Horizontale Abstände hinzufügen
            }
            Spacer()
        }
        .background(Color.white) // Hintergrundfarbe hinzufügen
        .onAppear {
            viewmodel.loadHighscore()
        }
    }
}

#Preview {
    HighscoreView()
}
