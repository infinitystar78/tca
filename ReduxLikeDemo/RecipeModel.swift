//
//  RecipeModel.swift
//  ReduxLikeDemo
//
//  Created by M W on 09/11/2022.
//
import Foundation
import SwiftUI

enum Cuisine: String, CaseIterable {
    case british
    case spanish
    case indian
    case italian
    case chinese
    case healthy
    case quick
}


struct Recipe: Identifiable, Codable{
    var name: String
    var ingredients: String
    var timeToCook: String
    var rating: String
    var instructions: String
    var photoData: Data
    var portionSize: Int
    var nutritionalInformation: String
    var cuisine: Cuisine
    var date: Date
    var id = UUID()
    
    func getImage(from data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case cuisine = 
        
        
    }

    
    
    
    
}
