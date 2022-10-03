//
//  ContentView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/27/22.
//

import SwiftUI

struct HomePageView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    @State private var page = 1
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.articles, id: \.self) { article in
                    if article.isLeading {
                        LeadingArticleView(title: article.title, imageUrl: article.imageUrl)
                            .background(NavigationLink("", destination: ArticlePageView(article: article))
                                .opacity(0.0))
                    } else {
                        NavigationLink(destination: ArticlePageView(article: article)) {
                            ArticleView(article: article)
                        }
                    }
                }
                .listRowSeparator(.hidden)
                
                LoadMoreView()
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        getArticles()
                    }
            }
            .navigationTitle("Home")
            .listStyle(PlainListStyle())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .refreshable {
            viewModel.fetchRefreshedArticles()
        }
        .onAppear {
            getArticles()
        }
    }
    
    private func getArticles() {
        viewModel.fetchNewArticles(page: page)
        self.page += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
