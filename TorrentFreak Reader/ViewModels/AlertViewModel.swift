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
                                         subTitle: "Action completed successfully",
                                         style: .style(backgroundColor: .green, titleColor: .white, subTitleColor: .white))
    
    public let successfullySavedArticleToast = AlertToast(displayMode: .alert,
                                         type: .regular,
                                         title: "Success!",
                                         subTitle: "Successfully saved article",
                                         style: .style(backgroundColor: .green, titleColor: .white, subTitleColor: .white))
    
    public let successfullyDeletedArticleToast = AlertToast(displayMode: .alert,
                                         type: .regular,
                                         title: "Success!",
                                         subTitle: "Successfully deleted article",
                                         style: .style(backgroundColor: .green, titleColor: .white, subTitleColor: .white))
    
    public let successfullyMarkedAsReadToast = AlertToast(displayMode: .alert,
                                         type: .regular,
                                         title: "Success!",
                                         subTitle: "Successfully marked as read",
                                         style: .style(backgroundColor: .green, titleColor: .white, subTitleColor: .white))
    
    public let successfullyMarkedAsUnreadToast = AlertToast(displayMode: .alert,
                                         type: .regular,
                                         title: "Success!",
                                         subTitle: "Successfully marked as unread",
                                         style: .style(backgroundColor: .green, titleColor: .white, subTitleColor: .white))
    
    public let errorToast = AlertToast(displayMode: .alert,
                                       type: .regular,
                                       title: "Error",
                                       subTitle: "Action did not complete successfully",
                                       style: .style(backgroundColor: .red, titleColor: .white, subTitleColor: .white))
    
    public let errorSavingArticleToast = AlertToast(displayMode: .alert,
                                       type: .regular,
                                       title: "Error",
                                       subTitle: "Article was not saved - an error occurred",
                                       style: .style(backgroundColor: .red, titleColor: .white, subTitleColor: .white))
    
    public let errorDeletingArticleToast = AlertToast(displayMode: .alert,
                                       type: .regular,
                                       title: "Error",
                                       subTitle: "Article was not deleted - an error occurred",
                                       style: .style(backgroundColor: .red, titleColor: .white, subTitleColor: .white))
    
    public let errorMarkingAsReadToast = AlertToast(displayMode: .alert,
                                       type: .regular,
                                       title: "Error",
                                       subTitle: "Article was not marked as read - an error occurred",
                                       style: .style(backgroundColor: .red, titleColor: .white, subTitleColor: .white))
    
    public let errorMarkingAsUnreadToast = AlertToast(displayMode: .alert,
                                       type: .regular,
                                       title: "Error",
                                       subTitle: "Article was not marked as unread - an error occurred",
                                       style: .style(backgroundColor: .red, titleColor: .white, subTitleColor: .white))
    
    
}
