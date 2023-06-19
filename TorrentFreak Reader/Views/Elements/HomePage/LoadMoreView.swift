//
//  LoadMoreView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/2/22.
//

import SwiftUI

struct LoadMoreView: View {
    
    private let loadMore = "Load more..."
    
    private let fetchingArticles = "Fetching articles..."
    
    @Binding
    var isGettingNextPage: Bool
        
    var body: some View {
        Text(self.isGettingNextPage ? fetchingArticles : loadMore)
            .bold()
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .listRowSeparator(.hidden)
    }
    
}

struct LoadMoreView_Previews: PreviewProvider {
    static var previews: some View {
        LoadMoreView(isGettingNextPage: .constant(true))
    }
}
