//
//  HomeContextMenuView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/24/22.
//

import SwiftUI
import UniformTypeIdentifiers

struct HomeContextMenuView: View {
    
    @Environment(\.openURL)
    private var openURL
    
    @EnvironmentObject
    private var alertViewModel: AlertViewModel
    
    @EnvironmentObject
    private var viewModel: BaseArticleViewModel
    
    private let articleDataStore = ArticleDataStore.shared
    
    public var article: Article
    
    var body: some View {
        Button {
            UIPasteboard.general.setValue(article.articleUrl,
                                          forPasteboardType: UTType.plainText.identifier)
        } label: {
            Label("Copy link", systemImage: "doc.on.doc")
        }
        
        ShareLink(item: URL(string: article.articleUrl)!) {
            Label("Share", systemImage: "square.and.arrow.up")
        }
        
        Button {
            openURL(URL(string: article.articleUrl)!)
        } label: {
            Label("Open in browser", systemImage: "link")
        }
        
        let articleSaved = articleDataStore.findArticle(article: article)
        
        Button {
            if articleSaved {
                let result = articleDataStore.deleteArticle(article: article)
                
                if result {
                    alertViewModel.toast = alertViewModel.successfullyDeletedArticleToast
                } else {
                    alertViewModel.toast = alertViewModel.errorDeletingArticleToast
                }
            } else {
                let result = articleDataStore.insertArticle(article: article)
                
                if result {
                    alertViewModel.toast = alertViewModel.successfullySavedArticleToast
                } else {
                    alertViewModel.toast = alertViewModel.errorSavingArticleToast
                }
            }
        } label: {
            Label(articleSaved ? "Unsave article" : "Save article", systemImage: "square.and.arrow.down")
        }
        
        let articleRead = articleDataStore.isInHistory(url: article.articleUrl)
        
        Button {
            if articleRead {
                let result = articleDataStore.removeFromHistory(url: article.articleUrl)
                
                if result {
                    viewModel.updateReadIndicator()
                    alertViewModel.toast = alertViewModel.successfullyMarkedAsUnreadToast
                } else {
                    alertViewModel.toast = alertViewModel.errorMarkingAsUnreadToast
                }
            } else {
                let result = articleDataStore.addToHistory(url: article.articleUrl)
                
                if result {
                    viewModel.updateReadIndicator()
                    alertViewModel.toast = alertViewModel.successfullyMarkedAsReadToast
                } else {
                    alertViewModel.toast = alertViewModel.errorMarkingAsReadToast
                }
            }
        } label: {
            Label(articleRead ? "Mark as unread" : "Mark as read", systemImage: "newspaper")
        }
    }
}

struct HomeContextMenuView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContextMenuView(article: PlaceHolderData.articles.first!)
    }
}
