//
//  HomeContextMenuView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/24/22.
//

import SwiftUI
import UniformTypeIdentifiers

struct HomeContextMenuView: View {
    
    @Environment(\.openURL) var openURL
    
    var article: Article
    
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
    }
}

struct HomeContextMenuView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContextMenuView(article: PlaceHolderData.articles.first!)
    }
}