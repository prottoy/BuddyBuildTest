//
//  PlaylistDetailService.swift
//

import Foundation

typealias OnCompletion = (Result<Playlist, Error>) -> Void

protocol PlaylistDetailServiceProtocol {

    func retrievePlayList(onCompletion: @escaping OnCompletion)
}

struct PlaylistDetailService: PlaylistDetailServiceProtocol {

    static let endPoint = "https://api.soundcloud.com/playlists/79670980"
    static let clientId = "i71BoBoxTxlbVYvnt7O2reL86DynpqT3"
    static let clientSecret = "Mh6G90LOOuz1Vd04gBsNQMmHFwocWUzk"

    func retrievePlayList(onCompletion: @escaping OnCompletion) {

        var urlComponents = URLComponents(string: PlaylistDetailService.endPoint)!
        urlComponents.queryItems = [URLQueryItem(name: "client_id",
                                       value: PlaylistDetailService.clientId),
                          URLQueryItem(name: "client_secret",
                                       value: PlaylistDetailService.clientSecret)]
        
        let dataTask = URLSession.shared.dataTask(with: urlComponents.url!,
                                                  completionHandler: {
                                                    data, response, error in

                                                    guard let data = data else { return }

                                                    do {
                                                        let decoder = JSONDecoder()
                                                        let playlist = try decoder.decode(
                                                            Playlist.self,
                                                            from: data
                                                        )

                                                        DispatchQueue.main.async {
                                                            onCompletion(.success(playlist))
                                                        }
                                                    } catch let err {
                                                        DispatchQueue.main.async {
                                                            onCompletion(.failure(err))
                                                        }
                                                    }
        })

        dataTask.resume()
    }
}

