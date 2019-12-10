//
//  PokemonTableViewController.swift
//  POKEAPI
//
//  Created by Lambda_School_Loaner_219 on 12/6/19.
//  Copyright © 2019 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    let apiController = APIController()

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return apiController.pokemonList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)

        let currentPokemon = apiController.pokemonList[indexPath.row]
        
        cell.textLabel?.text = currentPokemon.name
        cell.detailTextLabel?.text = "id: \(currentPokemon.id)"
        
        

        return cell
    }
    

//delete functionality
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            apiController.delete(apiController.pokemonList[indexPath.row])
            tableView.deleteRows(at:[indexPath], with: .automatic)
        }
    }
            

           
           

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetailSegue" {
            if let detailVC = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow{
                detailVC.apiController = apiController
                detailVC.pokemon = apiController.pokemonList[indexPath.row]
            }
        }
        
        if segue.identifier == "searchSegue" {
            if let searchVC = segue.destination as? DetailViewController {
                searchVC.apiController = apiController 
            }
        }
            }
        
       
}
    



