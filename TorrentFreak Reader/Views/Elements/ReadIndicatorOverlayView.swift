//
//  ReadIndicatorOverlay.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 6/19/23.
//

import SwiftUI

struct ReadIndicatorOverlayView: View {
    
    @AppStorage(UserDefaultsKeys.displayReadIndicator)
    private var displayReadIndicator = false
    
    public let article: Article
    
    public let cornerRadius: CGFloat
    
    var body: some View {
        if article.read && displayReadIndicator {
            VStack {
                Spacer()
                ReadIndicatorView()
                    .scaleEffect(0.70)
                    .padding(.leading, -8)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.6))
            .cornerRadius(cornerRadius)
        }
    }
}

struct ReadIndicatorOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        let article = Article(title: "This is the article title. Very cool. Maybe it could be a title with a lot of text and it goes on for a long time", author: "Andy", imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg", articleUrl: "null", category: "Lawsuits", date: "today", isLeading: false, read: true)
        ReadIndicatorOverlayView(article: article, cornerRadius: 15)
    }
}
