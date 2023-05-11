//
//  ImageDetailPageView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/12/22.
//

import SwiftUI

struct ImageDetailPageView: View {
    
    @StateObject
    private var viewModel = ImageDetailViewModel()
    
    public let articleSection: ArticleSection
    
    private let haptic = UIImpactFeedbackGenerator(style: .rigid)
    
    var body: some View {
        VStack {
            ArticleImageDetailView(webView: viewModel.webView)
                .onAppear {
                    viewModel.loadUrl(urlString: articleSection.content)
                }
        }
        .navigationTitle("Image")
        .onAppear {
            haptic.impactOccurred()
        }
    }
}

struct ImageDetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailPageView(articleSection: PlaceHolderData.section)
    }
}
