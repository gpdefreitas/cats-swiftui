//
//  Cat.swift
//  Cats
//
//  Created by Gui Freitas on 2022-02-09.
//

import Foundation

struct Cat: Decodable, Identifiable {
    let id: String
    let url: URL
    let breeds: [Breed]
}

extension Cat {
    struct Breed: Decodable, Identifiable {
        let id: String
        let name: String
    }
}
