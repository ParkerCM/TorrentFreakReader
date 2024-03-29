//
//  SavedPageView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/26/22.
//

import SwiftUI

struct SavedPageView: View {
    
    @StateObject
    private var viewModel = SavedViewModel()
    
    @State
    private var isInitialLoad = true
    
    var body: some View {
        NavigationStack {
            List {
                if !viewModel.articles.isEmpty {
                    ForEach(viewModel.articles, id: \.self) { article in
                        ArticleView(article: article, usePlaceHolderImage: false)
                    }
                    .onDelete(perform: delete)
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Saved")
            .listStyle(PlainListStyle())
            .overlay {
                if viewModel.articles.isEmpty {
                    ErrorTextView(main: "You don't have any saved articles", secondary: nil)
                }
            }
        }
        .onAppear {
            viewModel.getArticles()
            viewModel.updateReadIndicator()
        }
        .environmentObject(viewModel as BaseArticleViewModel)
    }
    
    private func delete(at offsets: IndexSet) {
        if let index = offsets.first {
            viewModel.deleteArticle(article: viewModel.articles[index])
        }
    }
}

struct SavedPageView_Previews: PreviewProvider {
    static var previews: some View {
        SavedPageView()
    }
}
