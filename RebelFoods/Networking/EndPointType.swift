//
//  EndPointType.swift
//  RebelFoods
//
//  Created by Budhabhooshan Patil on 17/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import Foundation
internal protocol EndPointType {
    
    var baseURL: Routes { get }
    var httpMethod: HTTPMethod { get }
}
internal struct API:EndPointType {
    
    public var baseURL: Routes;
    public var page = 10;
    public var httpMethod: HTTPMethod;
    
    
    init(baseUrl:Routes , httpMethod:HTTPMethod , page:Int) {
        
        self.baseURL = baseUrl;
        self.httpMethod = httpMethod;
        self.page = page;
    }
    
    var buildRequest:URLRequest {
        
        var url:String {
            
            switch self.baseURL {
                
            case .music:
                return String(format: Routes.music.value, page);
            case .movies:
                return String(format: Routes.movies.value, page);
            case .shows:
                return String(format: Routes.shows.value, page);
            case .books:
                return String(format: Routes.books.value, page);
            }
        }
        
        var request = URLRequest(url: URL(string: url)!,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 60.0);
        
        request.httpMethod = self.httpMethod.rawValue;
        
        return request;
    }
}
