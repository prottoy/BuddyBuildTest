//
//  PlaylistDetailCell.swift
//

import UIKit

final class PlaylistDetailCell: UITableViewCell, Reusable {

    @IBOutlet private weak var title: UILabel!

    var viewModel: ViewModel = ViewModel.initial {
        didSet {
            render()
        }
    }

    private func render() {
        title.text = viewModel.title
    }
}


// MARK: -

extension PlaylistDetailCell {
    struct ViewModel {
        let title: String

        static let initial = ViewModel(title: "")
    }
}


// MARK: -

protocol Reusable {
    static var identifier: String { get }
}

extension Reusable {

    static var identifier: String {
        return String(describing: self)
    }
}
