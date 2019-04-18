//
//  Routes.swift
//  RebelFoods
//
//  Created by Budhabhooshan Patil on 17/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import Foundation

internal enum Routes {
    
    case music
    case movies
    case shows
    case books
    
    var value:String {
        
        switch self {
            
        case .music:
            return "https://rss.itunes.apple.com/api/v1/in/apple-music/hot-tracks/all/%d/explicit.json";
        case .movies:
            return "https://rss.itunes.apple.com/api/v1/in/movies/top-movies/all/%d/explicit.json"
        case .shows:
            return "https://rss.itunes.apple.com/api/v1/us/tv-shows/top-tv-episodes/all/%d/explicit.json"
        case .books:
            return "https://rss.itunes.apple.com/api/v1/in/books/top-free/all/%d/explicit.json"
        }
    }
}
