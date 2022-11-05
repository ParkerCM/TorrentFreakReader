//
//  SavedPageView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/26/22.
//

import SwiftUI

struct SavedPageView: View {
    
    @StateObject var viewModel = SavedViewModel()
    
    @State var isInitialLoad = true
    
    var body: some View {
        NavigationView {
            List {
                if !viewModel.articles.isEmpty {
                    ForEach(viewModel.articles, id: \.self) { article in
                        ArticleView(article: article, usePlaceHolderImage: false)
                    }
                    .onDelete(perform: delete)
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Saved Articles")
            .listStyle(PlainListStyle())
            .overlay {
                if viewModel.articles.isEmpty {
                    Text("You haven't saved any articles yet")
                }
            }
        }
        .onAppear {
            viewModel.getArticles()
        }
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
