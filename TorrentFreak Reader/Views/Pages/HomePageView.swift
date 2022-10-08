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
                        LeadingArticleView(title: article.title, imageUrl: article.imageUrl, usePlaceHolderImage: viewModel.isPlaceHolder)
                            .background(NavigationLink("", destination: ArticlePageView(article: article))
                                .opacity(0.0))
                    } else {
                        NavigationLink(destination: ArticlePageView(article: article)) {
                            ArticleView(article: article, usePlaceHolderImage: viewModel.isPlaceHolder)
                        }
                    }
                }
                .listRowSeparator(.hidden)
                .redacted(when: viewModel.isPlaceHolder)
                
                LoadMoreView(isGettingNextPage: $viewModel.isGettingNextPage)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        getArticles()
                    }
                    .hidden(viewModel.hideLoadMore)
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

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
    
    @ViewBuilder
    func redacted(when condition: Bool) -> some View {
        if !condition {
            unredacted()
        } else {
            redacted(reason: .placeholder)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
