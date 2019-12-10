//
//  DetailViewController.swift
//  POKEAPI
//
//  Created by Lambda_School_Loaner_219 on 12/6/19.
//  Copyright © 2019 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    
    
    @IBOutlet weak var typeLabel: UILabel!
    
   
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var apiController:APIController!
    var pokemon:Pokemon? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        hideSearchAndSave()
        updateViews()

      
    }
    
    
    


    @IBAction func onSavePressed(_ sender: Any) {
        guard let pokemon = pokemon else {return}
        
        //apiController?.pokemonList.append(pokemon)
        apiController?.save(pokemon:pokemon)
        print("Pokemon saved! You saved: \(pokemon.name) there is \(apiController?.pokemonList.count) pokemon saved!")
        
        self.navigationController?.popViewController(animated: true)
    }
    





func hideViews() {
    if pokemon != nil {
        imageView.isHidden = false
        idLabel.isHidden = false
        typeLabel.isHidden = false
        abilitiesLabel.isHidden = false
        nameLabel.isHidden = false
    }
        
    if pokemon == nil {
        nameLabel.isHidden = true
        imageView.isHidden = true
        idLabel.isHidden = true
        typeLabel.isHidden = true
        abilitiesLabel.isHidden = true
    }
    
    
}
    
    func hideSearchAndSave(){
        if pokemon != nil {
            saveButton.isHidden = true
            searchBar.isHidden = true
        }
    }
    
   func updateViews() {
        hideViews()
    guard let pokemon = pokemon else {return}
    apiController?.fetchImage(at: pokemon.sprites.frontDefault, completion: { result in
        if let pokemonImage = try? result.get() {
            self.imageView.image = pokemonImage 
        }
        self.nameLabel.text = pokemon.name.capitalized
        
        var typesString = ""
        for type in pokemon.types {
            typesString += type.type.name + " , "
        }
        self.typeLabel.text =  "Type(s): \(typesString)"
        
        var abilities = ""
        for ability in pokemon.abilities {
            abilities += ability.ability.name + " , "
            
        }
        self.abilitiesLabel.text = abilities
        
        self.idLabel.text = "\(pokemon.id)"
        print(self.apiController.pokemonList.count)
        
        
    })
        
    
    
    
    
    
    }

}



extension DetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchedPokemon = searchBar.text, !searchedPokemon.isEmpty else {return}
        
        apiController?.getPokemon(for: searchedPokemon, completion: { result in
            let pokemon = try? result.get()
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.updateViews()
            }
        })
    }
}
