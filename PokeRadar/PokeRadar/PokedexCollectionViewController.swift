//
//  PokedexCollectionViewController.swift
//  PokeRadar
//
//  Created by Roger Florat on 07/02/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PokemonCell"

class PokedexCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return PokemonFactory.shared.pokemons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokemonCollectionViewCell
        
        let pokemon = PokemonFactory.shared.getPokemon(with: indexPath.row + 1)
        
        cell.pokemonIdLabel.text = "\(pokemon.id)"
        cell.pokemonImageView.image = pokemon.image
        cell.pokemonLabel.text = pokemon.name
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = PokemonFactory.shared.getPokemon(with: indexPath.row + 1)
    
        let alert = UIAlertController(title: "\(pokemon.name)", message: "Quieres notificar la presencia de este Pokemon?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (alert) in
                        
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotifyPokemon"), object: pokemon)
            
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
