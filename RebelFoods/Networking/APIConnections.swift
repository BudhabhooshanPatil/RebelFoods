//
//  APIConnections.swift
//  RebelFoods
//
//  Created by Budhabhooshan Patil on 17/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import Foundation
import UIKit

class ApiConnections {
    
    class func getData(path:Routes ,page:Int = 10, completionHandler:@escaping AppConstants.Response) {
        
        let api = API(baseUrl: path, httpMethod: .get, page: page).buildRequest;
        
        httpRequest(request: api) { (data, error) in
            completionHandler(data,error);
        }
    }
    
    class func getMusics(path:Routes ,page:Int , completionHandler:@escaping AppConstants.Response) {
        
        ApiConnections.getData(path: path, page: page) { (data, error) in
            completionHandler(data,error);
        }
    }
    class func getMovies(path:Routes ,page:Int , completionHandler:@escaping AppConstants.Response) {
       
        ApiConnections.getData(path: path, page: page) { (data, error) in
            completionHandler(data,error);
        }
    }
    
    class func getShows(path:Routes ,page:Int , completionHandler:@escaping AppConstants.Response) {
        
        ApiConnections.getData(path: path, page: page) { (data, error)  in
            completionHandler(data,error);
        }
    }
    
    class func getBooks(path:Routes ,page:Int , completionHandler:@escaping AppConstants.Response) {
        
        ApiConnections.getData(path: path, page: page) { (data, error) in
            completionHandler(data,error);
        }
    }
    
    
    class func downloadMoviePoster(path:String ,onImage:@escaping ( _ image:UIImage?)-> Void) -> Void {
        
        if let imageURL = URL(string: path) {
            
            let task = URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) in
                
                if error != nil {
                    return
                }
                if let imageData = data {
                    onImage(UIImage(data: imageData));
                }
                
            });
            task.resume();
        }
    }
}
