//
//  Model.swift
//  RebelFoods
//
//  Created by Budhabhooshan Patil on 17/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import Foundation

public enum ModelType{
    case music
    case movie
    case show
    case book
    case none
}

class Model {
    
    var artistName: String? = nil
    var id: String? = nil
    var name: String? = nil
    var kind: String? = nil
    var artistId: String? = nil
    var artistUrl: String? = nil
    var artworkUrl100: String? = nil
    var url: String? = nil
    var geners:[String] = [String]();
    
    
    init(item:Result?) {
        
        self.artistName  = item?.artistName;
        self.id          = item?.id;
        self.name        = item?.name;
        self.kind           = item?.kind;
        self.artistId       = item?.artistId;
        self.artistUrl      = item?.artistUrl;
        self.artworkUrl100  = item?.artworkUrl100;
        self.url            = item?.url;
        if let geners = item?.genres {
            for gener in geners {
                self.geners.append((gener?.name)!);
            }
        }
    }
    
    var modelType: ModelType {
        switch self {
        case is Music:
            return ModelType.music;
        case is Movie:
            return ModelType.movie;
        case is Show:
            return ModelType.show;
        case is Book:
            return ModelType.book;
        default:
            return ModelType.none;
        }
    }
    
}

class Music:Model {
    
    override init(item:Result?) {
        super.init(item: item);
        
        self.id = item?.id;
        self.name = item?.name;
        self.kind = item?.kind;
        self.artworkUrl100 = item?.artworkUrl100;
        self.url = item?.url;
    }
}
class Movie:Model {
    
    var releaseDate: String? = nil
    var copyright: String? = nil
    
    override init(item:Result?) {
        super.init(item: item);
        
        self.artistName         = item?.artistName;
        self.id                 = item?.id;
        self.releaseDate        = item?.releaseDate;
        self.name               = item?.name;
        self.kind               = item?.kind;
        self.copyright          = item?.copyright;
        self.artworkUrl100      = item?.artworkUrl100;
        self.url                = item?.url;
    }
}
class Show:Model {
    
    var releaseDate: String? = nil
    var collectionName:String? = nil
    var copyright: String? = nil
    var contentAdvisoryRating: String? = nil
    
    override init(item:Result?) {
        super.init(item: item);
        
        self.artistName = item?.artistName;
        self.id         = item?.id;
        self.releaseDate    = item?.releaseDate;
        self.name           = item?.name;
        self.collectionName = item?.collectionName;
        self.kind           = item?.kind;
        self.copyright      = item?.copyright;
        self.artistId       = item?.artistId;
        self.artistUrl      = item?.artistUrl;
        self.artworkUrl100  = item?.artworkUrl100;
        self.url            = item?.url;
        self.contentAdvisoryRating  = item?.contentAdvisoryRating;
    }
}
class Book:Model {
    
    var releaseDate: String? = nil
    
    override init(item:Result?) {
        super.init(item: item);
        
        self.artistName = item?.artistName;
        self.id         = item?.id;
        self.releaseDate    = item?.releaseDate;
        self.name           = item?.name;
        self.kind           = item?.kind;
        self.artistId       = item?.artistId;
        self.artistUrl      = item?.artistUrl;
        self.artworkUrl100  = item?.artworkUrl100;
        self.url            = item?.url;
    }
}
