//
//  HomeSheetView.swift
//  MatheMentor
//
//  Created by Mark Eggebrecht on 04.06.24.
//

import SwiftUI

struct HomeSheetView: View {
    @StateObject private var viewmodel = QuizViewModel()
    
    
    
    
    @Environment(\.dismiss) private var dismiss
    @State private var showNewView = false
    
    var body: some View {
        NavigationStack {
            Form {
                Text("Hallo \(viewmodel.user.name), jetzt kannst du noch deine Einstellung anpassen:")
                
                Picker("Schwierigkeit", selection: $viewmodel.selectLevel) {
                    Text("Leicht").tag(1)
                    Text("Mittel").tag(2)
                    Text("Schwer").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Toggle("Addition", isOn: $viewmodel.additionIsOn)
                Toggle("Subtraktion", isOn: $viewmodel.subtractionIsOn)
                Toggle("Multiplikation", isOn: $viewmodel.multiplicationIsOn)
                Toggle("Division", isOn: $viewmodel.divisionIsOn)
                
                Toggle("Timer", isOn: $viewmodel.selectedtimerOn)
                
                if viewmodel.selectedtimerOn {
                    Picker("Timer (in Sekunden)", selection: $viewmodel.newtimerDuration) {
                        ForEach((30..<301).filter { $0.isMultiple(of: 30) }, id: \.self) { index in
                            Text("\(index) sek").tag(index)
                            
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .onChange(of: viewmodel.newtimerDuration){
                        newValue in 
                        print("newtimerDuration change to \(newValue)")
                        
                    }
                }
                
            }
            Button("Speichern") {
                viewmodel.settings(settings: SettingsModel(level: viewmodel.selectLevel, formeln: ["+","-","*","/"], additionIsOn: viewmodel.additionIsOn, subtractionIsOn: viewmodel.subtractionIsOn, multiplicationIsOn: viewmodel.multiplicationIsOn, divisionIsOn: viewmodel.divisionIsOn, timerIsOn: viewmodel.selectedtimerOn, timerDuration: viewmodel.newtimerDuration))
                dismiss() // Dismiss the sheet
                showNewView.toggle()
            }
            .tint(.black)
            .padding()
            .background(Color.green)
            .clipShape(Capsule())
            .bold()
            .shadow(radius: 10)
        }
        .onAppear {
            viewmodel.loadUserData()
            viewmodel.loadUserSettings()
        }
    }
}

#Preview {
    //HomeSheetView()
}





