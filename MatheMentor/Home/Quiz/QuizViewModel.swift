//
//  QuizViewModel.swift
//  MatheMentor
//
//  Created by Emmanuel Freitas Kalambayi on 04.06.24.
//

import Foundation

class QuizViewModel: ObservableObject {
    @Published var quiz: RechnungsModel = RechnungsModel(number1: 0, number2: 0, result: 0, formel: "+")
    @Published var myQuotes: String = ""
    @Published var archive: [RechnungsModel] = []
    //@Published var timer: Int = 7
    @Published var gameIsOn = true
    @Published var hearts = 3
    @Published var user: UserDataModel = UserDataModel(name: "",points: 0)
    @Published var highscoreSortedList: [UserDataModel] = []
    //@Published var userSettings: SettingsModel = SettingsModel(level: 1, formeln:["+", "-", "*", "/"] , additionIsOn: true, subtractionIsOn: true, multiplicationIsOn: true, divisionIsOn: true, timerIsOn: true, timerDuration: 30)
    
    
    
    @Published var additionIsOn: Bool = true
    @Published var subtractionIsOn: Bool = false
    @Published var multiplicationIsOn: Bool = false
    @Published var divisionIsOn: Bool = false
    
    @Published var selectLevel = 1
    @Published var selectedtimerOn: Bool = true
    @Published var newtimerDuration = 30  // Timer-Dauer in Sekunden
    
    
    
    private var repository: QuizRepository = QuizRepository.shared
    
    func getQuiz() {
        quiz = repository.getQuiz()
    }
    func addPoints(points: Int) {
        repository.addPointsToUser(points: points)
        user = repository.user
    }
    func addName(newName: String) {
        repository.addUserName(newName: newName)
        user = repository.user
    }
    func userToHighScore() {
        repository.userAddHighscore()
        
    }
    // Checkt ob die Anwort Richtig oder Falsch ist
    func checkAnswer(answer: Int) -> Bool {
        if answer == quiz.result{
            quiz.color = .green
            quiz.answer = answer
            archive.append(quiz)
            return true
        }else {
            quiz.color = .red
            quiz.answer = answer
            archive.append(quiz)
            return false
        }
    }
    func loadHighscore(){
        highscoreSortedList = repository.highscore
        
    }
    
    func settings(settings: SettingsModel) {
        repository.addSettings(settings: settings)
    }
    
    
    func loadUserSettings() {
        
        let settings = repository.loadSettings()
        self.selectLevel = settings.level
        self.additionIsOn = settings.additionIsOn
        self.subtractionIsOn = settings.subtractionIsOn
        self.multiplicationIsOn = settings.multiplicationIsOn
        self.divisionIsOn = settings.divisionIsOn
        self.selectedtimerOn = settings.timerIsOn
        self.newtimerDuration = settings.timerDuration
        
    }
    
    func loadMyQuotes() {
        let randomNumber = Int.random(in: 0...9)
        myQuotes = repository.mathQuotes[randomNumber]
    }
    func loadUserData() {
        user = repository.loadUserName()
    }
}



