//
//  RechnungsModel.swift
//  MatheMentor
//
//  Created by Mark Eggebrecht on 06.06.24.
//

import Foundation
import SwiftUI

struct RechnungsModel: Identifiable{
    var id: UUID = UUID()
    var number1: Int
    var number2: Int
    var result: Int
    var formel: String
    var answer: Int = 0
    var color: Color = .black
}
