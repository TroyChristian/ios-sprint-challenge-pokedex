//
//  Pokemon.swift
//  POKEAPI
//
//  Created by Lambda_School_Loaner_219 on 12/6/19.
//  Copyright © 2019 Lambda_School_Loaner_219. All rights reserved.
//

import Foundation
struct Pokemon:Codable {
    var name: String
    var abilities: [Ability]
    var id: Int
    let sprites: Sprite
    let types: [Type]
    
    
}

struct Ability:Codable {
    var ability:Species 
    
}

struct Sprite: Codable {
    var frontDefault: String
}


struct Type: Codable {
    var type: Species
}

struct Species: Codable {
    var name: String
}
