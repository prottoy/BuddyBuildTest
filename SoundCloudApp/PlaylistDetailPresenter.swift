//
//  PlaylistPresenter.swift
//

import Foundation

final class PlaylistDetailPresenter {

    weak var viewInterface: PlaylistDetialViewInterface?

    var viewModel: PlaylistDetailViewController.ViewModel =
        PlaylistDetailViewController.ViewModel.initial {
        didSet {
            viewInterface?.reload()
        }
    }

    private let service: PlaylistDetailServiceProtocol

    init(service: PlaylistDetailServiceProtocol) {
        self.service = service
    }

    func retrievePlaylist()  {
        viewInterface?.isLoading(true)

        service.retrievePlayList(onCompletion: {
            [weak self] result in
            
            self?.viewInterface?.isLoading(false)

            switch result {
                case .success(let playlist):

                    if let self = self {
                        self.viewModel = self.prepareViewModels(playlist: playlist)
                    }
                
                case .failure(let error):
                    self?.viewInterface?.showError(message: error.localizedDescription)
                
            }
        })
    }

    func trackCount() -> Int {
        return viewModel.tracks.count
    }
}


// MARK: - Data transformation logic

extension PlaylistDetailPresenter {

    private func prepareViewModels(playlist: Playlist) -> PlaylistDetailViewController.ViewModel {

        var cellViewModels = [PlaylistDetailCell.ViewModel]()
        cellViewModels = playlist.tracks.map(trackToViewModel)

        return PlaylistDetailViewController.ViewModel(
            playlistTitle: playlist.title,
            tracks: cellViewModels
        )
    }

    private func trackToViewModel(track: Track) -> PlaylistDetailCell.ViewModel {

        return PlaylistDetailCell.ViewModel(
            title: "\(track.title) 🎶  \(track.user.username)"
        )
    }
}

