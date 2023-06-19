//
//  ReadIndicatorView.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 6/13/23.
//

import SwiftUI

struct ReadIndicatorView: View {
    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(.black)
            Text("Read")
                .foregroundColor(.black)
        }
        .padding(.top, 5)
        .padding(.leading, 5)
        .padding(.bottom, 5)
        .padding(.trailing, 9)
        .background(.white)
        .cornerRadius(20)
    }
}

struct ReadIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ReadIndicatorView()
    }
}
