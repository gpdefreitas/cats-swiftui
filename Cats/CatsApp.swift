//
//  CatsApp.swift
//  Cats
//
//  Created by Gui Freitas on 2022-02-09.
//

import SwiftUI

@main
struct CatsApp: App {
    var body: some Scene {
        WindowGroup {
            let dataProvider = DataProvider()
            let viewModel = CatListViewModel(dataProvider: dataProvider)
            CatListView(viewModel: viewModel)
        }
    }
}
