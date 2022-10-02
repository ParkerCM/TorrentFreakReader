//
//  LoadMoreView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 10/2/22.
//

import SwiftUI

struct LoadMoreView: View {
    var body: some View {
        Text("Load more...")
            .bold()
            .frame(maxWidth: .infinity)
            .frame(height: 50)
    }
}

struct LoadMoreView_Previews: PreviewProvider {
    static var previews: some View {
        LoadMoreView()
    }
}
