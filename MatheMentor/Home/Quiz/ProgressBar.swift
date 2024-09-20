//
//  ProgressBar.swift
//  MatheMentor
//
//  Created by Mark Eggebrecht on 07.06.24.
//

import SwiftUI
// ProgressBar ist eine SwiftUI-View, die eine Fortschrittsleiste anzeigt.
struct ProgressBar: View {
    @Binding var value: Int // Gebundener Wert für den Fortschritt
    var maxValue: Int // Maximalwert für den Fortschritt
    
    var body: some View {
        GeometryReader { geometry in // Verwendet GeometryReader, um die Größe des übergeordneten Containers zu erhalten
            ZStack(alignment: .leading) { // Verwendet ZStack, um die beiden Rechtecke übereinander zu legen
                // Hintergrundrechteck mit einer Opazität von 0,3
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                // Fortschrittsrechteck, das seine Breite basierend auf dem aktuellen Wert anpasst
                if self.value > 5 {
                    // Fortschritt größer als 5, Blau anzeigen
                    Rectangle().frame(width: min(CGFloat(self.value) / CGFloat(self.maxValue) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .foregroundColor(Color(UIColor.systemBlue))
                        .animation(.linear, value: value) // Lineare Animation für den Fortschritt
                } else {
                    // Fortschritt 5 oder weniger, Rot anzeigen
                    Rectangle().frame(width: min(CGFloat(self.value) / CGFloat(self.maxValue) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .foregroundColor(Color(UIColor.systemRed))
                        .animation(.linear, value: value) // Lineare Animation für den Fortschritt
                }
            }
            .cornerRadius(45.0) // Abgerundete Ecken für die Fortschrittsleiste
        }
    }
}
