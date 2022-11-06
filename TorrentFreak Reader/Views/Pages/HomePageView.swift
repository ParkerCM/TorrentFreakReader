//
//  ContentView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 9/27/22.
//

import SwiftUI
import UniformTypeIdentifiers

struct HomePageView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    @State private var initialLoad = true
    
    @State private var page = 1
    
    private let haptic = UIImpactFeedbackGenerator(style: .rigid)
        
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.articles, id: \.self) { article in
                    if article.isLeading {
                        LeadingArticleView(article: article, usePlaceHolderImage: viewModel.isPlaceHolder)
                            .disabled(viewModel.isPlaceHolder)
                    } else {
                        ArticleView(article: article, usePlaceHolderImage: viewModel.isPlaceHolder)
                            .disabled(viewModel.isPlaceHolder)
                    }
                }
                .listRowSeparator(.hidden)
                .redacted(when: viewModel.isPlaceHolder)
                
                LoadMoreView(isGettingNextPage: $viewModel.isGettingNextPage)
                    .onTapGesture {
                        getArticles()
                    }
                    .hidden(viewModel.isPlaceHolder)
            }
            .refreshable {
                self.page = 1
                await viewModel.fetchRefreshedArticles()
                self.page += 1
                
                haptic.impactOccurred()
            }
            .navigationTitle("News")
            .listStyle(PlainListStyle())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            if self.initialLoad {
                getArticles()
                self.initialLoad = false
            }
        }
    }
    
    private func getArticles() {
        haptic.impactOccurred()
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
