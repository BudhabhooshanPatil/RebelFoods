//
//  ListTableViewCell.swift
//  RebelFoods
//
//  Created by Budhabhooshan Patil on 17/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import UIKit

protocol ModelDelegate:class {
    func didSelectModel(model:Model) -> Void;
}

class ListTableViewCell: UITableViewCell {
    
    var numberOfCellsPerRow = 2
    var models = [Model]();

    weak var delegate:ModelDelegate? = nil;
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        self.contentView.addSubview(self.collectionView);
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
        
        // horizontal/vertical constraints for UICollectionView
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: [], metrics: nil, views: ["collectionView":collectionView]);
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView]|", options: [], metrics: nil, views: ["collectionView":collectionView]);
        self.contentView.addConstraints(horizontal);
        self.contentView.addConstraints(vertical);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        
        // setup the collection view
        let flowLayout = UICollectionViewFlowLayout();
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal;

        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowLayout);
        collectionview.dataSource = self;
        collectionview.delegate = self;
        collectionview.alwaysBounceVertical = false;
        collectionview.backgroundColor = .white;
        collectionview.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell");
        return collectionview;
    }();
    func bind(models:[Model]) -> Void {
        self.models = models;
        self.collectionView.reloadData();
    }
}
extension ListTableViewCell :UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectModel(model: self.models[indexPath.row]);
    }
}
extension ListTableViewCell:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.models.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) as? ListCollectionViewCell {
            cell.tag = indexPath.row;
            cell.bind(model: self.models[indexPath.row], indexPath: indexPath);
            return cell;
        }
        return UICollectionViewCell();
    }
}
extension ListTableViewCell:UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalwidth = self.bounds.size.width;
        let dimensions = CGFloat(Int(totalwidth) / numberOfCellsPerRow)
        
        return CGSize(width: dimensions, height: collectionView.frame.size.height - 16.0);
    }
    func collectionView(_ collectionView: UICollectionView,  layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
}
