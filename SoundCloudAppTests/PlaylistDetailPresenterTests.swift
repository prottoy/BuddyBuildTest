//
//  SoundCloudAppTests.swift
//

import XCTest
@testable import SoundCloudApp

class PlaylistDetailPresenterTests: XCTestCase {

    func test_givenRetrievePlayListisCalled_thanRetrievesPlaylist() {
        // Given
        let mock = PlaylistDetailServiceMock()
        let sut = PlaylistDetailPresenter(service: mock)

        // When
        sut.retrievePlaylist()

        // Than
        XCTAssertTrue(mock.isPlayListRetrieved)
    }

    func test_whenRetrievePlayListisCalled_thanIsLoadingIsTrue() {
        // Given
        let mock = PlaylistDetailServiceMock()
        let viewMock = PlaylistDetailViewMock()
        let sut = PlaylistDetailPresenter(service: mock)
        sut.viewInterface = viewMock

        // When
        sut.retrievePlaylist()

        // Than
        XCTAssertTrue(viewMock.isLoading)
    }

    func test_givenRetrievePlayListisCalled_whenSuccess_thanIsLoadingIsFalse() {
        // Given
        let mock = PlaylistDetailServiceMock()
        mock.callNetwork = true
        mock.isSuccess = true

        let viewMock = PlaylistDetailViewMock()
        let sut = PlaylistDetailPresenter(service: mock)
        sut.viewInterface = viewMock

        // When
        sut.retrievePlaylist()

        // Than
        XCTAssertFalse(viewMock.isLoading)
    }

    func test_givenRetrievePlayListisCalled_whenSuccess_thanViewModelIsPopulated() {
        // Given
        let mock = PlaylistDetailServiceMock()
        mock.callNetwork = true
        mock.isSuccess = true

        let viewMock = PlaylistDetailViewMock()
        let sut = PlaylistDetailPresenter(service: mock)
        sut.viewInterface = viewMock

        // When
        sut.retrievePlaylist()
        
        // Than
        XCTAssertEqual(sut.viewModel.playlistTitle, "Sometitle")
    }

    func test_givenRetrievePlayListisCalled_whenSuccess_thanViewIsReloaded() {
        // Given
        let mock = PlaylistDetailServiceMock()
        mock.callNetwork = true
        mock.isSuccess = true

        let viewMock = PlaylistDetailViewMock()
        let sut = PlaylistDetailPresenter(service: mock)
        sut.viewInterface = viewMock
        
        // When
        sut.retrievePlaylist()
        
        // Than
        XCTAssertEqual(viewMock.isReloadCalled, true)
    }

    func test_givenRetrievePlayListisCalled_whenFailure_thanErrorIsShown() {
        // Given
        let mock = PlaylistDetailServiceMock()
        mock.callNetwork = true
        mock.isSuccess = false
        
        let viewMock = PlaylistDetailViewMock()
        let sut = PlaylistDetailPresenter(service: mock)
        sut.viewInterface = viewMock
        
        // When
        sut.retrievePlaylist()
        
        // Than
        XCTAssertTrue(viewMock.errorShown)
    }
}


class PlaylistDetailServiceMock: PlaylistDetailServiceProtocol {

    var callNetwork = false
    var isSuccess = true

    var isPlayListRetrieved = false

    func retrievePlayList(onCompletion: @escaping OnCompletion) {
        isPlayListRetrieved = true

        if callNetwork {
            let playlist = Playlist(title: "Sometitle", tracks: [Track]())
            isSuccess ? onCompletion(.success(playlist)) : onCompletion(.failure(MockError.test))
        }
    }
}


class PlaylistDetailViewMock: PlaylistDetialViewInterface {

    var isLoading = false
    var isReloadCalled = false
    var errorShown = false

    func reload() {
        isReloadCalled = true
    }

    func showError(message: String) {
        errorShown = true
    }

    func isLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
    }
}

enum MockError: Error {
    case test
}
