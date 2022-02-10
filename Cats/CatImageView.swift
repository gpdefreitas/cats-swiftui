//
//  CatImageView.swift
//  Cats
//
//  Created by Gui Freitas on 2022-02-10.
//

import SwiftUI

struct CatImageView: View {
    let location: String
    
    var body: some View {
        if location.contains("http"), let url = URL(string: location) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
        } else {
            Image(location)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
