//
//  PokemonAnnotation.swift
//  PokeRadar
//
//  Created by Roger Florat on 06/02/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var pokemon: Pokemon
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, pokemonId: Int) {
        self.coordinate = coordinate
        self.pokemon = PokemonFactory.shared.getPokemon(with: pokemonId)
        self.title = self.pokemon.name
    }
    
}
