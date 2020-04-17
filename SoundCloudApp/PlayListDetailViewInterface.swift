//
//  PlayListDetailViewInterface.swift
//

import Foundation

protocol PlaylistDetialViewInterface: AnyObject {

    func reload()

    func showError(message: String)

    func isLoading(_ isLoading: Bool)
}

