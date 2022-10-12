//
//  ImageDetailPageView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/12/22.
//

import SwiftUI

struct ImageDetailPageView: View {
    
    @StateObject var viewModel = ImageDetailViewModel()
    
    let articleSection: ArticleSection
    
    var body: some View {
        VStack {
            ArticleImageDetailView(webView: viewModel.webView)
                .onAppear {
                    viewModel.loadUrl(urlString: articleSection.content)
                }
        }
        .navigationTitle("Image")
    }
}

struct ImageDetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailPageView(articleSection: PlaceHolderData.section)
    }
}
