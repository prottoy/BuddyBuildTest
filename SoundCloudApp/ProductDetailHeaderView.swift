//
//  ProductDetailHeaderView.swift
//

import UIKit

final class ProductDetailHeaderView: UITableViewHeaderFooterView, Reusable {

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


extension ProductDetailHeaderView {

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

// MARK: -

extension ProductDetailHeaderView {
    struct ViewModel {
        let title: String
        
        static let initial = ViewModel(title: "")
    }
}
