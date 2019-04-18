//
//  ListCollectionViewCell.swift
//  RebelFoods
//
//  Created by Budhabhooshan Patil on 17/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import UIKit



class ListCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        viewWillAddSubViews();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func viewWillAddSubViews() -> Void {
        
        self.contentView.addSubview(self.holderView);
        self.holderView.addSubview(self.icon);
        self.contentView.addSubview(self.name);
        self.contentView.addSubview(self.anotherLabel);
        
        let views = ["icon":self.icon , "name":self.name , "anotherLabel":anotherLabel , "holderView":self.holderView];
        
        let horizontal1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[holderView]-|", options: [], metrics: nil, views: views);
        let horizontal2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[name]-|", options: [], metrics: nil, views: views);
        let horizontal3 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[anotherLabel]-|", options: [], metrics: nil, views: views);
        let vertical1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[holderView]-[name(20)]-[anotherLabel(20)]-|", options: [], metrics: nil, views: views);
        
        self.contentView.addConstraints(horizontal1);
        self.contentView.addConstraints(horizontal2);
        self.contentView.addConstraints(horizontal3);
        self.contentView.addConstraints(vertical1);
        
        let horizontal4 = NSLayoutConstraint.constraints(withVisualFormat: "H:|[icon]|", options: [], metrics: nil, views: views);
        let vertical2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|[icon]|", options: [], metrics: nil, views: views);
        
        self.holderView.addConstraints(horizontal4);
        self.holderView.addConstraints(vertical2);
        
    }
    
    func bind(model:Model , indexPath:IndexPath) -> Void {
        
        switch model {
            
        case  is Music:
            if let music = model as? Music {
                name.text = music.name;
                anotherLabel.text = music.kind;
            }
            break;
        case  is Movie:
            if let movie = model as? Movie {
                name.text = movie.name;
                anotherLabel.text = movie.releaseDate;
            }
            break;
        case  is Show:
            if let show = model as? Show {
                name.text = show.name;
                anotherLabel.text = show.collectionName;
            }
            break;
        case  is Book:
            if let book = model as? Book {
                name.text = book.name;
                anotherLabel.text = book.kind;
            }
            break;
        default:
            break;
        }
        
        if let url = model.artworkUrl100 {
            
            ApiConnections.downloadMoviePoster(path: url) { (_image) in
                
                DispatchQueue.main.async {
                    
                    if (self.tag == indexPath.row) {
                        
                        self.icon.image = _image;
                    }
                }
            }
        }
    }
    
    var holderView: UIView = {
        let view = UIView();
        view.layer.cornerRadius = 10.0;
        view.translatesAutoresizingMaskIntoConstraints = false;
        // shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 4.0
        return view;
    }();
    
    var icon: UIImageView  = {
        
        let imageView = UIImageView(frame: .zero);
        imageView.clipsToBounds = true;
        imageView.contentMode = .scaleAspectFill;
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.image = UIImage(named: "iconPlaceHolder");
        imageView.layer.cornerRadius = 10.0
        return imageView;
    }()
    
    var name: UILabel  = {
        
        let label = UILabel();
        label.adjustsFontSizeToFitWidth = true;
        label.font =  UIFont(name: "HelveticaNeue-Medium", size: 14.0);
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textAlignment = .center
        return label;
    }()
    
    var anotherLabel: UILabel = {
        
        let label = UILabel();
        label.adjustsFontSizeToFitWidth = true;
        label.font =  UIFont(name: "HelveticaNeue-Medium", size: 18.0);
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textAlignment = .center;
        label.textColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1);
        return label;
    }()
}
