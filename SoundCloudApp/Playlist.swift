//
//  PlayList.swift
//

import Foundation

struct Playlist: Codable {
    let title: String
    var tracks: [Track]
}


struct Track: Codable {
    let id: Int
    let title: String
    let user: User
}


struct User: Codable {
    let id: Int
    let username: String
}
