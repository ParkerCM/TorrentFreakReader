//
//  ArticleExcerptView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/2/22.
//

import SwiftUI

struct ArticleExcerptView: View {
    
    let section: ArticleSection
    
    var body: some View {
        Text(.init(section.content))
            .italic()
            .fontWeight(.medium)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ArticleExcerptView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleExcerptView(section: ArticleSection(article: Article(title: "This is the article title. Very cool. Maybe it could be a title with a lot of text and it goes on for a long time", author: "Andy", imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg", articleUrl: "null", category: "Lawsuit", date: "today", isLeading: false), content: "The RIAA has booked a landmark victory against YouTube-ripper Yout.com. The Connecticut District Court dismissed Yout's request to declare the service as non-infringing. In a detailed ruling, Judge Stefan Underhill concludes that the service failed to show that it doesn't circumvent YouTube's technological protection measures. Yout is disappointed and will appeal the verdict.", categories: ["Piracy"], sectionType: .exerpt))
    }
}
