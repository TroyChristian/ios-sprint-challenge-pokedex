//
//  APIController.swift
//  POKEAPI
//
//  Created by Lambda_School_Loaner_219 on 12/6/19.
//  Copyright © 2019 Lambda_School_Loaner_219. All rights reserved.
//

import Foundation
enum HTTPMethod: String {
    case get = "GET"
    
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

class APIController {
       private let baseUrl = URL(string: "https://pokeapi.co/api/v2/")!
    
  func getPokemon(for pokemonName:String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
       
       let pokemonUrl = baseUrl.appendingPathComponent("pokemon/\(pokemonName)/")
       
       var request = URLRequest(url:pokemonUrl)
       request.httpMethod = HTTPMethod.get.rawValue
       //request.setValue("", forHTTPHeaderField: "Authorization")
       
       URLSession.shared.dataTask(with: request) { data, response, error in
           if let response = response as? HTTPURLResponse,
               response.statusCode == 401 {
               completion(.failure(.badAuth))
               return
           }
           
           if let error = error {
               print("Error receiving pokemon \(pokemonName) details data: \(error)")
               completion(.failure(.otherError))
               return
           }
           
           guard let data = data else {
               completion(.failure(.badData))
               return
           }
           
           let decoder = JSONDecoder()
          
           do {
               let pokemon = try decoder.decode(Pokemon.self, from: data)
            completion(.success(pokemon))
           } catch {
               print("Error decoding animal object: \(error)")
               completion(.failure(.noDecode))
               return
           }
           
       }.resume()
       
       
}
}
