//
//  ImageDetailViewModel.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/12/22.
//

import Foundation
import WebKit

class ImageDetailViewModel: ObservableObject {
        
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
    }
    
    func loadUrl(urlString: String) {
        if let url = URL(string: urlString) {
            DispatchQueue.main.async {
                self.webView.load(URLRequest(url: url))
            }
        }
    }
    
    func back() {
        webView.goBack()
    }
    
}
