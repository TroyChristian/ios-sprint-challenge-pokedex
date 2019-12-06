//
//  APIController.swift
//  POKEAPI
//
//  Created by Lambda_School_Loaner_219 on 12/6/19.
//  Copyright © 2019 Lambda_School_Loaner_219. All rights reserved.
//

import Foundation
import UIKit
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
    var pokemonList:[Pokemon] = []
    
  func getPokemon(for pokemonName:String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
       
       let pokemonUrl = baseUrl.appendingPathComponent("pokemon/\(pokemonName)/")
       
       var request = URLRequest(url:pokemonUrl)
       request.httpMethod = HTTPMethod.get.rawValue
       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
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
    
    func fetchImage(at urlString:String, completion: @escaping (Result<UIImage, NetworkError>) -> Void ) {
         let imageURL = URL(string: urlString)!
         
         var request = URLRequest(url:imageURL)
         request.httpMethod = HTTPMethod.get.rawValue
         
         URLSession.shared.dataTask(with: request) { (data, _, error) in
             if let _ = error {
                 completion(.failure(.otherError))
                 return
             }
             
             guard let data = data else {
                 completion(.failure(.badData))
                 return
             }
             let image = UIImage(data: data)!
             completion(.success(image))
         }.resume()
         
     }
    
    func save(pokemon:Pokemon){
        pokemonList.append(pokemon)
    }
}
