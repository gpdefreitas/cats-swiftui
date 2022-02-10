//
//  CatListView.swift
//  Cats
//
//  Created by Gui Freitas on 2022-02-09.
//

import SwiftUI

struct CatListView<ViewModel: CatListViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView(.vertical) {
                    let columns = [GridItem(.adaptive(minimum: 150, maximum: 150))]
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.cats) { cat in
                            CatImageView(location: cat.url.absoluteString)
                                .frame(width: 150, height: 150)
                        }
                    }
                }
            }
        }
        .onAppear {
            Task.init {
                await viewModel.fetch()
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let mock = CatsDataProviderMock()
        let viewModel = CatListViewModel(dataProvider: mock)
        Group {
            CatListView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
//                .environment(\.colorScheme, .dark)
            CatListView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            CatListView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: "iPad (9th generation)"))
        }
    }
}
#endif
