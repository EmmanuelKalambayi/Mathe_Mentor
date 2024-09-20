//
//  UserDataModel.swift
//  MatheMentor
//
//  Created by Mark Eggebrecht on 06.06.24.
//

import Foundation

struct UserDataModel: Identifiable{
    var id: UUID = UUID()
    var name: String
    var points: Int = 0
}
