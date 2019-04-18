//
//  EntitysViewController.swift
//  RebelFoods
//
//  Created by Budhabhooshan Patil on 18/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import UIKit

class EntityInfoViewController: UIViewController {
    
    var loadingMoreView:ActivityIndicatorView?;
    var collectionViewBackground:ActivityIndicatorView?;
    var numberOfCellsPerRow = 2;
    var modelType:ModelType! ;
    var models = [Model]();
    var loading = false
    var page = 10;
    let decoder = JSONDecoder();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.collectionView);
        
        // remove autoLayout constraints
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // horizontal constraints for UICollectionView
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|",
                                                        options: [],
                                                        metrics: nil,
                                                        views: ["collectionView":collectionView]);
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["collectionView":collectionView]);
        self.view.addConstraints(horizontal);
        self.view.addConstraints(vertical);
        loadDetails();
    }
    /// UICollectionView
    lazy var collectionView: UICollectionView = {
        
        // setup the collection view
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout());
        collectionview.dataSource = self;
        collectionview.delegate = self;
        collectionview.alwaysBounceVertical = true;
        collectionview.backgroundColor = .white;
        collectionview.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "Cell");
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRect(x: 0, y: collectionview.contentSize.height, width: collectionview.bounds.size.width, height: ActivityIndicatorView.defaultHeight)
        loadingMoreView = ActivityIndicatorView(frame: frame)
        loadingMoreView!.isHidden = true
        collectionview.addSubview(loadingMoreView!)
        
        var insets = collectionview.contentInset
        insets.bottom += ActivityIndicatorView.defaultHeight
        collectionview.contentInset = insets
        
        collectionViewBackground = ActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60));
        collectionViewBackground?.startAnimating();
        collectionViewBackground?.center = self.view.center;
        collectionview.backgroundView = collectionViewBackground;
        
        return collectionview;
    }()
    
    func loadDetails() -> Void {
        
        loading = true;
        page = page + 10 ;
        switch modelType! {
            
        case .music:
            ApiConnections.getMusics(path: Routes.music, page: page) { (data, error) in
                
                if let data = data{
                    
                    do{
                        
                        let music = try self.decoder.decode(dataCodable.self, from: data);
                        guard let results = music.feed.results else { return };
                        self.models.removeAll();
                        for item in results {
                            self.models.append(Music(item: item));
                        }
                        DispatchQueue.main.async {
                            self.collectionView.reloadData();
                            self.loading = false;
                            self.loadingMoreView?.stopAnimating();
                        }
                    }catch{
                        Logger.print(items: error.localizedDescription);
                        self.loading = false;
                        self.loadingMoreView?.stopAnimating();
                    }
                }else{
                    if let error = error {
                        Logger.print(items: error.localizedDescription);
                        self.loading = false;
                        self.loadingMoreView?.stopAnimating();
                    }
                }
            }
            break;
        case .movie:
            ApiConnections.getMusics(path: Routes.movies, page: page) { (data, error) in
                
                if let data = data{
                    
                    do{
                        
                        let movies = try self.decoder.decode(dataCodable.self, from: data);
                        guard let results = movies.feed.results else { return };
                        self.models.removeAll();
                        for item in results {
                            self.models.append(Movie(item: item));
                            
                        }
                        DispatchQueue.main.async {
                            self.collectionView.reloadData();
                            self.loading = false;
                            self.loadingMoreView?.stopAnimating();
                        }
                    }catch{
                        Logger.print(items: error.localizedDescription);
                        self.loading = false;
                        self.loadingMoreView?.stopAnimating();
                    }
                }else{
                    if let error = error {
                        Logger.print(items: error.localizedDescription);
                        self.loading = false;
                        self.loadingMoreView?.stopAnimating();
                    }
                }
            }
            break;
        case .show:
            ApiConnections.getMusics(path: Routes.shows, page: page) { (data, error) in
                
                if let data = data{
                    
                    do{
                        
                        let shows = try self.decoder.decode(dataCodable.self, from: data);
                        guard let results = shows.feed.results else { return };
                        self.models.removeAll();
                        for item in results {
                            self.models.append(Show(item: item));
                        }
                        DispatchQueue.main.async {
                            self.collectionView.reloadData();
                            self.loading = false;
                            self.loadingMoreView?.stopAnimating();
                        }
                    }catch{
                        Logger.print(items: error.localizedDescription);
                        self.loading = false;
                        self.loadingMoreView?.stopAnimating();
                    }
                }else{
                    if let error = error {
                        Logger.print(items: error.localizedDescription);
                        self.loading = false;
                        self.loadingMoreView?.stopAnimating();
                    }
                }
            }
            break;
        case .book:
            ApiConnections.getMusics(path: Routes.books, page: page) { (data, error) in
                
                if let data = data{
                    
                    do{
                        
                        let books = try self.decoder.decode(dataCodable.self, from: data);
                        guard let results = books.feed.results else { return };
                        self.models.removeAll();
                        for item in results {
                            self.models.append(Book(item: item));
                        }
                        DispatchQueue.main.async {
                            self.collectionView.reloadData();
                            self.loading = false;
                            self.loadingMoreView?.stopAnimating();
                        }
                    }catch{
                        Logger.print(items: error.localizedDescription);
                        self.loading = false;
                        self.loadingMoreView?.stopAnimating();
                    }
                }else{
                    if let error = error {
                        Logger.print(items: error.localizedDescription);
                        self.loading = false;
                        self.loadingMoreView?.stopAnimating();
                    }
                }
            }
            break;
        case .none:
            break;
        }
        collectionViewBackground?.isHidden = true;
    }
    
}
extension EntityInfoViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalwidth = collectionView.bounds.size.width;
        let dimensions = CGFloat(Int(totalwidth) / numberOfCellsPerRow)
        
        return CGSize(width: dimensions - 8.0, height: dimensions*2 - 16.0);
    }
    func collectionView(_ collectionView: UICollectionView,  layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
}
extension EntityInfoViewController :UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count ;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ListCollectionViewCell {
            cell.tag = indexPath.row;
            cell.bind(model: (models[indexPath.row]), indexPath: indexPath);
            return cell;
        }
        
        return UICollectionViewCell();
    }
}
extension EntityInfoViewController :UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let infoPage = infoPageViewController();
        infoPage.detailedModel = models[indexPath.row];
        self.navigationController?.pushViewController(infoPage, animated: true);
    }
}
extension EntityInfoViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let scrollViewContentHeight = self.collectionView.contentSize.height;
        let scrollOffsetThreshold = scrollViewContentHeight - self.collectionView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.collectionView.isDragging) {
            if !loading{
                
                let frame = CGRect(x: 0, y: self.collectionView.contentSize.height, width: self.collectionView.bounds.size.width, height: ActivityIndicatorView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                loadDetails();
            }
        }
    }
}
