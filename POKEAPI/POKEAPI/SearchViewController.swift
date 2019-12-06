//
//  SearchViewController.swift
//  POKEAPI
//
//  Created by Lambda_School_Loaner_219 on 12/6/19.
//  Copyright © 2019 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBAction func onSaveTapped(_ sender: Any) {
        
        
    }
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var pokemon:Pokemon? {
        didSet {
            updateViews()
        }
    }

    
  
        
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //searchBar.delegate = self
       updateViews()
        }
        
        
    func updateViews() {
    guard let pokemon = pokemon else {return}
        nameLabel.text? = pokemon.name
        idLabel.text? = String(pokemon.id)
        
        var allTypes =  ""
        for type in pokemon.types {
            allTypes += type.type.name + " "
        }
        typesLabel.text = allTypes
        
        
        
        }
       
    }


    

 


