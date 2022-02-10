//
//  CatListViewModel.swift
//  Cats
//
//  Created by Gui Freitas on 2022-02-09.
//

import Foundation

protocol CatListViewModelProtocol: ObservableObject {
    var cats: [Cat] { get }
    var isLoading: Bool { get }
    func fetch() async
}

class CatListViewModel: CatListViewModelProtocol {
    @Published var cats: [Cat] = []
    @Published var isLoading: Bool = true
    
    private let dataProvider: DataProviding
    private let url: URL
    
    init(dataProvider: DataProviding, url: URL = URL(string: "https://api.thecatapi.com/v1/images/search?limit=20&size=thumb")!) {
        self.dataProvider = dataProvider
        self.url = url
    }
    
    func fetch() async {
        isLoading = true
        do {
            let result: Result<[Cat], DataProviderError> = try await dataProvider.fetch(from: url)
            var fetchedCats: [Cat] = []
            if case .success(let cats) = result {
                fetchedCats = cats
            }
            self.update(cats: fetchedCats)
        } catch {
            print(error)
            self.update(cats: [])
        }
    }
    
    func update(cats: [Cat]) {
        DispatchQueue.main.async {
            self.cats = cats
            self.isLoading = false
        }
    }
}

