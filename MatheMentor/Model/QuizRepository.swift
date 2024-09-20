//
//  QuizRepository.swift
//  MatheMentor
//
//  Created by Emmanuel Freitas Kalambayi on 04.06.24.
//
import Foundation

class QuizRepository {
    
    // Singleton-Instanz
    static let shared = QuizRepository()
    
    var userSettings: SettingsModel  = SettingsModel(level: 1, formeln: ["+"], additionIsOn: true, subtractionIsOn: false, multiplicationIsOn: false, divisionIsOn: false, timerIsOn: false, timerDuration: 7)
    var user: UserDataModel = UserDataModel(name: "")
    
    
    // API-Implementieren
    let mathQuotes = [
        "Mathematik ist die Musik der Vernunft. - James Joseph Sylvester",
        "Ohne Mathematik kann man nichts wirklich begreifen. - Roger Bacon",
        "Mathematik ist nicht nur eine veritable Wissenschaft, sondern auch eine Kunst. - Paul Dirac",
        "Das Buch der Natur ist mit mathematischen Symbolen geschrieben. - Galileo Galilei",
        "In der Mathematik gibt es keine Ignoranz. - Carl Friedrich Gauss",
        "Die Mathematik ist die Königin der Wissenschaften. - Carl Friedrich Gauss",
        "Mathematik ist die Sprache, in der Gott das Universum geschrieben hat. - Galileo Galilei",
        "Mathematik ist die Wissenschaft von Mustern und Strukturen. - Hermann Weyl",
        "Mathematik ist das Alphabet, mit dessen Hilfe Gott das Universum beschrieben hat. - Galileo Galilei",
        "Mathematik ist das Tor und der Schlüssel zu den Wissenschaften. - Roger Bacon"
    ]
    
    //Datenbank einbauen
    var highscore: [UserDataModel] = [
        UserDataModel(name: "Max", points: 102),
        UserDataModel(name: "Flo", points: 22),
        UserDataModel(name: "Martin", points: 3)
    ]
    
    init() {
        
    }
    
    private var number1: Int = 0
    private var number2: Int = 0
    private var answer = 0
    
    //Mit diesen 3 Funktionen wird die Schwierigkeit variert
    func easyNumbers() -> Int { return Int.random(in: 1...10) }
    func mediumNumbers() -> Int { return Int.random(in: 50...100) }
    func hardNumbers() -> Int { return Int.random(in: 100...1000) }
    
    // Diese Funktion weist die schwierigkeit zu
    func getNumber(level: Int) -> Int {
        if level == 1 {
            return easyNumbers()
        } else if level == 2 {
            return mediumNumbers()
        } else {
            return hardNumbers()
        }
    }
    
    // Fügt einen neuen Benutzernamen hinzu
    func addUserName (newName: String) {
        user = UserDataModel(name: newName)
    }
    
    // Fügt einem Benutzer Punkte hinzu
    func addPointsToUser(points: Int){
        user.points = points
    }
    
    // Fügt den aktuellen Benutzer zur Highscore-Liste hinzu und sortiert diese
    func userAddHighscore() {
        highscore.append(user)
        highscore.sort { $0.points > $1.points}
    }
    
    
    // Funktion getQuiz erstellt unsere Rechenoperationen
    func getQuiz() -> RechnungsModel {
        var number1: Int = getNumber(level: userSettings.level)
        var number2: Int = getNumber(level: userSettings.level)
        let formel = getOperation(formel: userSettings.formeln)
        
        // Sicherstellen, dass die Subtraktion nicht zu negativen Ergebnissen führt
        while number1 <= number2 && formel == "-" {
            number1 = getNumber(level: userSettings.level)
            number2 = getNumber(level: userSettings.level)
        }
   
        // Sicherstellen, dass die Division ohne Rest durchgeführt wird
        while number1 % number2 != 0 && formel == "/" {
            number1 = getNumber(level: userSettings.level)
            // Damit man Rechnen aufgaben bekommt die nicht 912 / 912 sind sondern der divisor immer ein kleine Zahl ist
            number2 = getNumber(level: 1)
        }
        
        let result: Int = calculateAnswer(number1: number1, number2: number2, operation: formel)
        
        return RechnungsModel(number1: number1, number2: number2, result: result, formel: formel)
    }
    
    // Wählt eine zufällige Rechenoperation aus den verfügbaren aus
    func getOperation(formel: [String]) -> String {
        return formel.randomElement() ?? "+"
    }
    // Funktioin calculateAnswer stellt das Rechenzeichen zu verfügung
    func calculateAnswer(number1: Int, number2: Int, operation: String) -> Int {
        switch operation {
        case "+": return number1 + number2
        case "-": return number1 - number2
        case "*": return number1 * number2
        case "/": return number1 / number2
        default: return 0
        }
    }
    
    // Lädt die Benutzerdaten
    func loadUserName() -> UserDataModel{
        return UserDataModel(name: user.name, points: user.points)
    }
    
    // Überprüft, ob die Antwort korrekt ist
    func checkResult(rechnungModel: RechnungsModel, answer: Int) -> Bool {
        return rechnungModel.result == answer
    }
    
    // Speichert die Benutzereinstellungen
    func saveSettings(_ newSettingsModel: SettingsModel) {
        userSettings = newSettingsModel
    }
    
    // Lädt die Benutzereinstellungen
    func loadSettings() -> SettingsModel {
        return userSettings
    }
    
    // Fügt neue Einstellungen hinzu und aktualisiert die Formel-Liste basierend auf den Booleans
        func addSettings(settings: SettingsModel) -> SettingsModel {
           var formeln: [String] = []
        
        
        if settings.additionIsOn { formeln.append("+") }
        if settings.subtractionIsOn { formeln.append("-") }
        if settings.multiplicationIsOn { formeln.append("*") }
        if settings.divisionIsOn { formeln.append("/") }
        
        
        
        /*self.userSettings = SettingsModel(level: level, formeln: formeln, additionIsOn: settings.additionIsOn, subtractionIsOn: settings.subtractionIsOn, multiplicationIsOn: settings.multiplicationIsOn, divisionIsOn: settings.divisionIsOn, timerIsOn: settings.timerIsOn, timerDuration: settings.timerDuration)*/
        self.userSettings = SettingsModel(level: settings.level,
                                          formeln: formeln,
                                          additionIsOn: settings.additionIsOn ,
                                          subtractionIsOn: settings.subtractionIsOn,
                                          multiplicationIsOn: settings.multiplicationIsOn,
                                          divisionIsOn: settings.divisionIsOn,
                                          timerIsOn: settings.timerIsOn,
                                          timerDuration: settings.timerDuration)
        return userSettings
    }
}
