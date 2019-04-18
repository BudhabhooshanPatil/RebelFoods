//
//  OthersTableViewCell.swift
//  RebelFoods
//
//  Created by Budhabhooshan Patil on 17/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import UIKit

class OthersTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        self.contentView.addSubview(self.holderView);
        self.holderView.addSubview(self.cellText);
        
        let view = ["holderView":self.holderView,"cellText":cellText];
        
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[holderView]-|", options: [], metrics: nil, views: view);
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|[holderView]|", options: [], metrics: nil, views: view);
        self.contentView.addConstraints(horizontal);
        self.contentView.addConstraints(vertical);
        
        let horizontal1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[cellText]-|", options: [], metrics: nil, views: view);
        let vertical1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[cellText]", options: [], metrics: nil, views: view);
        
        self.holderView.addConstraints(horizontal1);
        self.holderView.addConstraints(vertical1);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func bind(text:String?, indexPath:IndexPath , textColor:UIColor) -> Void {
        
        guard let text = text else { return  }
        self.cellText.text = text;
        self.cellText.textColor = textColor;
    }
    
    lazy var cellText: UILabel = {
        
        let label = UILabel();
        label.adjustsFontSizeToFitWidth = true;
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 20.0);
        label.numberOfLines = 0;
        label.textColor = .black;
        label.sizeToFit();
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label;
    }()
    
    lazy var holderView: UIView = {
        
        let view = UIView();
        view.layer.cornerRadius = 10.0;
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
    }()
}
