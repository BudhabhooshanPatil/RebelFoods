//
//  infoPageViewController.swift
//  RebelFoods
//
//  Created by Budhabhooshan Patil on 17/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import UIKit

class infoPageViewController: UIViewController {
    
    private var infoModel:Model!;
    let decoder = JSONDecoder()
    
    var detailedModel: Model {
        get {
            return infoModel;
        }
        set {
            infoModel = newValue;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView);
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: [], metrics: nil, views: ["tableView":tableView]);
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: [], metrics: nil, views: ["tableView":tableView]);
        self.view.addConstraints(horizontal);
        self.view.addConstraints(vertical);
        
    }
    lazy var tableView:UITableView = {
        
        let _tableView = UITableView(frame: .zero, style: .plain);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.register(PosterTableViewCell.self, forCellReuseIdentifier: "PosterTableViewCell")   ;      // register cell name
        _tableView.register(OthersTableViewCell.self, forCellReuseIdentifier: "OverviewTableViewCell");
        _tableView.separatorStyle = .none;
        _tableView.allowsSelection = false;
        return _tableView;
    }();
    
    func headerView(text:String) -> UIView {
        let view = UIView(frame: CGRect(x: 20, y: 0, width: self.view.frame.size.width, height: 44));
        view.backgroundColor = .white;
        let label = UILabel(frame: view.frame);
        label.text = text;
        label.font = UIFont.boldSystemFont(ofSize: 25);
        view.addSubview(label);
        return view;
    }
}
extension infoPageViewController :UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch detailedModel.modelType {
            
        case .music:
            switch indexPath.section {
            case 0:
                return self.view.frame.size.width;
            default:
                break;
            }
            break
        case .movie:
            switch indexPath.section {
            case 0:
                return self.view.frame.size.width;
            case 4:
                if let movie = detailedModel as? Movie {
                    if let copyRight = movie.copyright{
                        return copyRight.height(withConstrainedWidth: self.tableView.frame.size.width, font: UIFont(name: "HelveticaNeue-Medium", size: 22)!);
                    }
                }
            default:
                break;
            }
            break
        case .show:
            switch indexPath.section {
            case 0:
                return self.view.frame.size.width;
            case 5:
                if let show = detailedModel as? Show {
                    if let copyRight = show.copyright{
                        return copyRight.height(withConstrainedWidth: self.tableView.frame.size.width, font: UIFont(name: "HelveticaNeue-Medium", size: 22)!);
                    }
                }
            default:
                break;
            }
            break
        case .book:
            switch indexPath.section {
            case 0:
                return self.view.frame.size.width;
            default:
                break;
            }
            break
        case .none:
            switch indexPath.section {
            case 0:
                return self.view.frame.size.width;
            default:
                break;
            }
            break
        }
        
        return 44.0;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.0;
        default:
            break;
        }
        return 44.0;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch detailedModel.modelType {
            
        case .music:
            switch section {
            case 1:
                return headerView(text: "Name");
            case 2:
                return headerView(text: "Kind");
            default:
                break;
            }
        case .movie:
            switch section {
            case 1:
                return headerView(text: "Name");
            case 2:
                return headerView(text: "ArtistName");
            case 3:
                return headerView(text: "Release Date");
            case 4:
                return headerView(text: "Copyright");
            case 5:
                return headerView(text: "Genres");
            default:
                break;
            }
        case .show:
            switch section {
            case 1:
                return headerView(text: "Name");
            case 2:
                return headerView(text: "ArtistName");
            case 3:
                return headerView(text: "Release Date");
            case 4:
                return headerView(text: "Collection Name");
            case 5:
                return headerView(text: "Copyright");
            case 6:
                return headerView(text: "Genres");
            default:
                break;
            }
        case .book:
            switch section {
            case 1:
                return headerView(text: "Name");
            case 2:
                return headerView(text: "Artist Name");
            case 3:
                return headerView(text: "Release Date");
            case 4:
                return headerView(text: "Genres");
            default:
                break;
            }
        case .none:
            break;
        }
        return UIView();
    }
}
extension infoPageViewController :UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        switch detailedModel.modelType {
            
        case .music:
            return 3;
        case .movie:
            return 6;
        case .show:
            return 7;
        case .book:
            return 6;
        case .none:
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch detailedModel.modelType {
            
        case .music:
            
            if let music = detailedModel as? Music {
                switch indexPath.section{
                case 0:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "PosterTableViewCell", for: indexPath) as? PosterTableViewCell {
                        cell.tag = indexPath.row;
                        cell.bind(model: self.detailedModel, indexPath: indexPath);
                        return cell;
                    }
                    break;
                case 1:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: music.name, indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                    break;
                case 2:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: music.kind, indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                    break;
                default:
                    break;
                }
            }
            break;
        case .movie:
            if let movie = detailedModel as? Movie {
                switch indexPath.section{
                case 0:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "PosterTableViewCell", for: indexPath) as? PosterTableViewCell {
                        cell.tag = indexPath.row;
                        cell.bind(model: self.detailedModel, indexPath: indexPath);
                        return cell;
                    }
                    break;
                case 1:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: movie.name, indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                    break;
                case 2:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: movie.artistName, indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                    break;
                case 3:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: movie.releaseDate, indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                    break;
                case 4:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: movie.copyright, indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                    break;
                case 5:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: movie.geners.joined(separator: "/"), indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                    break;
                default:
                    break;
                }
            }
            break
        case .show:
            if let show = detailedModel as? Show {
                switch indexPath.section{
                case 0:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "PosterTableViewCell", for: indexPath) as? PosterTableViewCell {
                        cell.tag = indexPath.row;
                        cell.bind(model: self.detailedModel, indexPath: indexPath);
                        return cell;
                    }
                    break;
                case 1:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: show.name, indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                    break;
                case 2:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: show.artistName, indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                    break;
                case 3:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: show.releaseDate, indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                    break;
                case 4:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: show.collectionName, indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                    break;
                case 5:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: show.copyright, indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                case 6:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: show.geners.joined(separator: "/"), indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                    break;
                default:
                    break;
                }
            }
            break
        case .book:
            if let book = detailedModel as? Book {
                switch indexPath.section{
                case 0:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "PosterTableViewCell", for: indexPath) as? PosterTableViewCell {
                        cell.tag = indexPath.row;
                        cell.bind(model: self.detailedModel, indexPath: indexPath);
                        return cell;
                    }
                    break;
                case 1:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: book.name, indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                    break;
                case 2:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: book.artistName, indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                    break;
                case 3:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: book.releaseDate, indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                    break;
                case 4:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as? OthersTableViewCell{
                        cell.bind(text: book.geners.joined(separator: "/"), indexPath: indexPath, textColor: UIColor.black);
                        return cell;
                    }
                    break;
                default:
                    break;
                }
            }
            break
        case .none:
            break
        }
        return UITableViewCell();
    }
}
