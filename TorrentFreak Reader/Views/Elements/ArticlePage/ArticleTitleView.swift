//
//  ArticleTitleView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/2/22.
//

import SwiftUI

struct ArticleTitleView: View {
    
    let section: ArticleSection
    
    var body: some View {
        VStack (spacing: 15) {
            Text(section.article.title)
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(minHeight: 300)
                .padding(.trailing, 35)
                .background(
                    AsyncImage(url: URL(string: section.article.imageUrl)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .opacity(0.5)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                } placeholder: {
                    ProgressView()
                })
            
            HStack {
                Image(systemName: "line.3.horizontal.decrease")
                
                VStack {
                    Text(section.article.author)
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(section.article.date)
                        .font(.headline)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if !section.categories.isEmpty {
                HStack {
                    ForEach(section.categories, id: \.self) { category in
                        CategoryView(category: category)
                            .frame(alignment: .leading)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ArticleTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleTitleView(section: ArticleSection(article: Article(title: "This is the article title. Very cool. Maybe it could be a title with a lot of text and it goes on for a long time", author: "Andy", imageUrl: "https://torrentfreak.com/images/russia-kremlin.jpg", articleUrl: "null", category: "Lawsuit", date: "today", isLeading: false), content: "The RIAA has booked a landmark victory against YouTube-ripper Yout.com. The Connecticut District Court dismissed Yout's request to declare the service as non-infringing. In a detailed ruling, Judge Stefan Underhill concludes that the service failed to show that it doesn't circumvent YouTube's technological protection measures. Yout is disappointed and will appeal the verdict.", categories: ["Piracy", "Lawsuit"], sectionType: .image))
    }
}
