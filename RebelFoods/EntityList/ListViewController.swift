//
//  ListViewController.swift
//  RebelFoods
//
//  Created by Budhabhooshan Patil on 17/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    let decoder = JSONDecoder();
    var musicModels = [Music]();
    var moviesModels = [Movie]();
    var showsModels = [Show]();
    var booksModels = [Book]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView);
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // horizontal/vertical constraints for UITableView
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: [], metrics: nil, views: ["tableView":tableView]);
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: [], metrics: nil, views: ["tableView":tableView]);
        self.view.addConstraints(horizontal);
        self.view.addConstraints(vertical);
        
        queuesWithQos();
    }
    
    
    func queuesWithQos() ->Void {
        
        let queue1 = DispatchQueue(label: "com.fassos.musicQueue", qos: .utility, attributes: .concurrent)
        let queue2 = DispatchQueue(label: "com.fassos.movieQueue", qos: .utility, attributes: .concurrent)
        let queue3 = DispatchQueue(label: "com.fassos.showQueue", qos: .utility, attributes: .concurrent)
        let queue4 = DispatchQueue(label: "com.fassos.bookQueue", qos: .utility, attributes: .concurrent)
        
        queue1.async {
            
            ApiConnections.getMusics(path: Routes.music, page: 10) { (data, error) in
                
                if let data = data{
                    
                    do{
                        
                        let music = try self.decoder.decode(dataCodable.self, from: data);
                        guard let results = music.feed.results else { return };
                        for item in results {
                            self.musicModels.append(Music(item: item));
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData();
                        }
                    }catch{
                        Logger.print(items: error.localizedDescription);
                    }
                }else{
                    if let error = error {
                        Logger.print(items: error.localizedDescription);
                    }
                }
            }
        }
        
        queue2.async {
            
            ApiConnections.getMovies(path: Routes.movies, page: 10) { (data, error) in
                
                if let data = data{
                    
                    do{
                        
                        let movies = try self.decoder.decode(dataCodable.self, from: data);
                        guard let results = movies.feed.results else { return };
                        for item in results {
                            self.moviesModels.append(Movie(item: item));
                            
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData();
                        }
                    }catch{
                        Logger.print(items: error.localizedDescription);
                    }
                }else{
                    if let error = error {
                        Logger.print(items: error.localizedDescription);
                    }
                }
            }
        }
        queue3.async {
            
            ApiConnections.getShows(path: Routes.shows, page: 10) { (data, error) in
                
                if let data = data{
                    
                    do{
                        
                        let shows = try self.decoder.decode(dataCodable.self, from: data);
                        guard let results = shows.feed.results else { return };
                        for item in results {
                            self.showsModels.append(Show(item: item));
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData();
                        }
                    }catch{
                        Logger.print(items: error.localizedDescription);
                    }
                }else{
                    if let error = error {
                        Logger.print(items: error.localizedDescription);
                    }
                }
            }
        }
        
        queue4.async {
            
            ApiConnections.getBooks(path: Routes.books, page: 10) { (data, error) in
                
                if let data = data{
                    
                    do{
                        
                        let books = try self.decoder.decode(dataCodable.self, from: data);
                        guard let results = books.feed.results else { return };
                        for item in results {
                            self.booksModels.append(Book(item: item));
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData();
                        }
                    }catch{
                        Logger.print(items: error.localizedDescription);
                    }
                }else{
                    if let error = error {
                        Logger.print(items: error.localizedDescription);
                    }
                }
            }
        }
    }
    
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: UITableView.Style.plain)
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        return tableView;
    }()
    func headerView(text:String ,section:Int) -> UIView {
        
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: 44.0));
        view.backgroundColor = .white;
        
        let label = UILabel(frame: CGRect(x: 8.0, y: 0.0, width: view.frame.size.width*60/100, height: 44.0));
        label.text = text;
        label.font = UIFont.boldSystemFont(ofSize: 25);
        view.addSubview(label);
        
        let button = UIButton(frame: CGRect(x: label.frame.size.width, y: 0.0, width: view.frame.size.width*40/100 - 16.0, height: 44.0));
        button.setTitle("see all", for: UIControl.State.normal);
        button.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1), for: UIControl.State.normal);
        button.titleLabel?.textAlignment = .right;
        button.addTarget(self, action: #selector(showAll(sender:)), for: UIControl.Event.touchUpInside);
        button.tag = section;
        view.addSubview(button);
        return view;
    }
    @objc func showAll(sender:UIButton) -> Void {
        
        let enityView = EntityInfoViewController();
        switch sender.tag {
        case 0:
            enityView.modelType = .music;
            break;
        case 1:
            enityView.modelType = .movie;
            break;
        case 2:
            enityView.modelType = .show;
            break;
        case 3:
            enityView.modelType = .book;
            break;
        default:
            break;
        }
        self.navigationController?.pushViewController(enityView, animated: true);
    }
}
extension ListViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height*0.40;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0;
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return headerView(text: "Musics", section: section);
        case 1:
            return headerView(text: "Movies", section: section);
        case 2:
            return headerView(text: "Shows", section: section);
        case 3:
            return headerView(text: "Books", section: section);
        default:
            break;
        }
        return UIView();
    }
}
extension ListViewController:UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell {
            cell.delegate = self;
            cell.tag = indexPath.row;
            switch indexPath.section {
            case 0:
                cell.bind(models: musicModels);
                break;
            case 1:
                cell.bind(models: moviesModels);
                break;
            case 2:
                cell.bind(models: showsModels);
                break;
            case 3:
                cell.bind(models: booksModels);
                break;
            default:
                break;
            }
            return cell;
        }
        return UITableViewCell();
    }
}
extension ListViewController : ModelDelegate {
    
    func didSelectModel(model: Model) {
        
        let infoPage = infoPageViewController();
        infoPage.detailedModel = model;
        self.navigationController?.pushViewController(infoPage, animated: true);
    }
}
