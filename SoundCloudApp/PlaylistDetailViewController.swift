//
//  PlaylistDetailViewController.swift
//

import UIKit

final class PlaylistDetailViewController: UITableViewController {
    
    private static let estimatedHeaderHeight: CGFloat = 40

    let presenter = PlaylistDetailPresenter(service: PlaylistDetailService())

    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(
        frame: CGRect(x: 0, y: 0, width: 100, height: 100)
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewInterface = self
        presenter.retrievePlaylist()

        registerHeader()
        configureActivityIndicator()
    }
}


// MARK: - Table view data source

extension PlaylistDetailViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.trackCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PlaylistDetailCell.identifier,
            for: indexPath) as! PlaylistDetailCell

        cell.viewModel = presenter.viewModel.tracks[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProductDetailHeaderView.identifier) as? ProductDetailHeaderView else {
            return nil
        }

        headerView.viewModel = ProductDetailHeaderView.ViewModel(
            title: presenter.viewModel.playlistTitle
        )

        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {

        return PlaylistDetailViewController.estimatedHeaderHeight
    }
}


// MARK: - ViewInterface implementation

extension PlaylistDetailViewController: PlaylistDetialViewInterface {

    func reload() {
        tableView.reloadData()
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Acknowledged", style: .default, handler: nil))

        self.present(alert, animated: true)
    }

    func isLoading(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}


// MARK: - ViewModel declaration

extension PlaylistDetailViewController {

    struct ViewModel {
        let playlistTitle: String
        let tracks: [PlaylistDetailCell.ViewModel]

        static let initial = ViewModel(
            playlistTitle: "",
            tracks: [PlaylistDetailCell.ViewModel]()
        )
    }
}

extension PlaylistDetailViewController {

    private func registerHeader() {

        tableView.register(
            ProductDetailHeaderView.nib,
            forHeaderFooterViewReuseIdentifier: ProductDetailHeaderView.identifier
        )
    }

    private func configureActivityIndicator() {
        activityIndicator.backgroundColor = UIColor.black
        activityIndicator.layer.opacity = 0.5
        activityIndicator.center = view.center
        tableView.addSubview(activityIndicator)
    }
}

