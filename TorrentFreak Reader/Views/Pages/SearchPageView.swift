//
//  SearchPageView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/25/22.
//

import SwiftUI

struct SearchPageView: View {
    
    @StateObject
    private var viewModel = SearchViewModel()
    
    @State
    private var query = ""
    
    @State
    private var submittedQuery = ""
    
    @State
    private var page = 1
    
    @State
    private var hasSearchBeenRan = false
    
    private let haptic = UIImpactFeedbackGenerator(style: .rigid)
        
    var body: some View {
        NavigationView {
            List {
                if !viewModel.popularArticles.isEmpty {
                    Section(content: {
                        ForEach(viewModel.popularArticles, id: \.self) { article in
                            ArticleView(article: article, usePlaceHolderImage: false)
                        }
                        .listRowSeparator(.hidden)
                    }, header: {
                        Text("Popular Articles in \(submittedQuery)")
                    })
                }
                
                if !viewModel.otherArticles.isEmpty {
                    Section(content: {
                        ForEach(viewModel.otherArticles, id: \.self) { article in
                            ArticleView(article: article, usePlaceHolderImage: false)
                        }
                        .listRowSeparator(.hidden)
                    }, header: {
                        Text("Other Articles in \(submittedQuery)")
                    })
                }
                
                if viewModel.doesNextPageExist {
                    LoadMoreView(isGettingNextPage: $viewModel.isGettingNextPage)
                        .onTapGesture {
                            haptic.impactOccurred()
                            
                            self.page += 1
                            viewModel.performSearch(page: page, query: query)
                        }
                        .hidden(viewModel.popularArticles.isEmpty && viewModel.otherArticles.isEmpty)
                }
            }
            .navigationTitle("Search")
            .listStyle(PlainListStyle())
            .searchable(text: $query, prompt: "Find an article")
            .onSubmit(of: .search) {
                viewModel.removeArticles()
                
                self.page = 1
                self.submittedQuery = query
                self.hasSearchBeenRan = true
                
                viewModel.performSearch(page: page, query: query)
            }
            .overlay {
                if viewModel.isGettingNextPage && viewModel.otherArticles.isEmpty {
                    ProgressView()
                }
                
                if self.hasSearchBeenRan && !viewModel.isGettingNextPage && viewModel.popularArticles.isEmpty && viewModel.otherArticles.isEmpty {
                    ErrorTextView(main: "No results", secondary: "for \"\(submittedQuery.trimmingCharacters(in: .whitespaces))\"")
                }
            }
        }
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
    }
}
