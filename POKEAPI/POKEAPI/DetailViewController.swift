//
//  DetailViewController.swift
//  POKEAPI
//
//  Created by Lambda_School_Loaner_219 on 12/6/19.
//  Copyright © 2019 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    
    
    @IBOutlet weak var typeLabel: UILabel!
    
   
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var apiController:APIController?
    var pokemon:Pokemon? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        hideSearchAndSave()
        updateViews()

      
    }
    
    
    


    @IBAction func onSavePressed(_ sender: Any) {
        guard let pokemon = pokemon else {return}
        
        apiController?.save(pokemon: pokemon)
        
        self.navigationController?.popViewController(animated: true)
    }
    





func hideViews() {
    if pokemon != nil {
        imageView.isHidden = false
        idLabel.isHidden = false
        typeLabel.isHidden = false
        abilitiesLabel.isHidden = false
    }
        
    if pokemon == nil {
        imageView.isHidden = true
        idLabel.isHidden = true
        typeLabel.isHidden = true
        abilitiesLabel.isHidden = true
    }
    
    
}
    
    func hideSearchAndSave(){
        if pokemon != nil {
            saveButton.isHidden = false
            searchBar.isHidden = false 
        }
    }
    
   func updateViews() {
        hideViews()
    guard let pokemon = pokemon else {return}
    apiController?.fetchImage(at: pokemon.sprites.frontDefault, completion: { result in
        if let pokemonImage = try? result.get() {
            self.imageView.image = pokemonImage 
        }
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
