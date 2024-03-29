//
//  Parser.swift
//  RebelFoods
//
//  Created by Budhabhooshan Patil on 17/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import Foundation

struct dataCodable: Codable {
    let feed: Feed
    
    enum CodingKeys: String, CodingKey {
        case feed = "feed"
    }
}

struct Feed: Codable {
    let title: String?
    let id: String?
    let author: Author?
    let links: [Link]?
    let copyright: String?
    let country: String?
    let icon: String?
    let updated: String?
    let results: [Result]?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case id = "id"
        case author = "author"
        case links = "links"
        case copyright = "copyright"
        case country = "country"
        case icon = "icon"
        case updated = "updated"
        case results = "results"
    }
}

struct Author: Codable {
    let name: String?
    let uri: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case uri = "uri"
    }
}

struct Link: Codable {
    let linkSelf: String?
    let alternate: String?
    
    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
        case alternate = "alternate"
    }
}

struct Result: Codable {
    let artistName: String?
    let id: String?
    let releaseDate: String?
    let name: String?
    let collectionName: String?
    let kind: String?
    let copyright: String?
    let artistId: String?
    let artistUrl: String?
    let artworkUrl100: String?
    let genres: [Genre?]?
    let url: String?
    let contentAdvisoryRating: String?
    
    enum CodingKeys: String, CodingKey {
        case artistName = "artistName"
        case id = "id"
        case releaseDate = "releaseDate"
        case name = "name"
        case collectionName = "collectionName"
        case kind = "kind"
        case copyright = "copyright"
        case artistId = "artistId"
        case artistUrl = "artistUrl"
        case artworkUrl100 = "artworkUrl100"
        case genres = "genres"
        case url = "url"
        case contentAdvisoryRating = "contentAdvisoryRating"
    }
}
struct Genre: Codable {
    let genreId: String?
    let name: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case genreId = "genreId"
        case name = "name"
        case url = "url"
    }
}
