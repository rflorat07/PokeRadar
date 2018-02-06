//
//  PokemonFactory.swift
//  PokeRadar
//
//  Created by Roger Florat on 06/02/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class PokemonFactory {
    
    static let shared = PokemonFactory()
    
    var pokemons : [Pokemon] = []
    
    init() {
        let data = self.readDataFromCSV(filename: "pokemon", fileType: "csv")
        let csvRow = self.csv(data: data!)
        
        for row in csvRow {
            if let id = Int(row[0]) {
                if id > 151 { break }
                let name = row[1].capitalized
                let pokemon = Pokemon(id: id, name: name)
                self.pokemons.append(pokemon)
            }
            
        }
    }
    
    func getPokemon(with pokemonId: Int ) -> Pokemon {
        return self.pokemons[pokemonId - 1]
    }
    
    func csv(data: String) -> [[String]] {
        var resul :  [[String]] = []
        
        let rows  = data.components(separatedBy: "\n")
        
        for row in rows {
            let columns = row.components(separatedBy: ",")
            resul.append(columns)
        }
        
        return resul
    }
    
    func readDataFromCSV(filename: String, fileType: String) -> String! {
        guard let filepath = Bundle.main.path(forResource: filename, ofType: fileType) else { return nil }
        
        do {
            let contents = try String(contentsOfFile: filepath, encoding: .utf8)
            return contents
        }  catch {
            print("Ha habido un error procesando el fichero \(filename)")
            return nil
        }
    }
    
}
