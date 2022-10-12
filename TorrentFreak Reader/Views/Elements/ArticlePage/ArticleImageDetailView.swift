//
//  ArticleImageDetailView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/12/22.
//

import SwiftUI
import WebKit

struct ArticleImageDetailView: UIViewRepresentable {
    
    typealias UIViewType = WKWebView
    
    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
}

//struct ArticleImageDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleImageDetailView()
//    }
//}
