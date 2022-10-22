//
//  ArticleVideoView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/22/22.
//

import SwiftUI
import WebKit

struct ArticleVideoView: UIViewRepresentable {
    
    let section: ArticleSection
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let url = URL(string: section.content) else { return }
        
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: url))
    }
}
