//
//  AlertViewModel.swift
//  TorrentFreak Reader
//
//  Created by Parker Madel on 11/6/22.
//

import AlertToast
import Foundation

class AlertViewModel: ObservableObject {
    
    @Published
    public var show = false
    
    @Published
    public var toast = AlertToast(type: .error(.red), title: "Error", subTitle: "Error saving article") {
        didSet {
            show.toggle()
        }
    }
    
    public let successToast = AlertToast(displayMode: .alert,
                                         type: .regular,
                                         title: "Success!",
                                         subTitle: "Successfully saved article",
                                         style: .style(backgroundColor: .green, titleColor: .white, subTitleColor: .white))
    
    public let errorToast = AlertToast(displayMode: .alert,
                                       type: .regular,
                                       title: "Error",
                                       subTitle: "Article has already been saved",
                                       style: .style(backgroundColor: .red, titleColor: .white, subTitleColor: .white))
    
    
}
