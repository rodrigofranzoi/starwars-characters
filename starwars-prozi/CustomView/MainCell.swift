//
//  MainCell.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 30/11/21.
//

import Foundation
import UIKit

class MainCell: UITableViewCell {
    
    static let identifier = "MainCell"
    
    let imgLang = UIImageView()
    let usernameLabel = UILabel()
    let favoriteButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        btn.backgroundColor = .red
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.setTitle("Favorite", for: .normal)
        return btn
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(imgLang)
        addSubview(usernameLabel)
//        addSubview(favoriteButton)
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.leadingAnchor.constraint(equalTo: imgLang.trailingAnchor, constant: 8).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        usernameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        
        imgLang.translatesAutoresizingMaskIntoConstraints = false
        imgLang.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        imgLang.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        imgLang.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
//        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
//        favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8).isActive = true
//        favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
//        favoriteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imgLang.heightAnchor.constraint(equalToConstant: 28).isActive = true
        imgLang.widthAnchor.constraint(equalToConstant: 28).isActive = true
        imgLang.layer.cornerRadius = imgLang.frame.height/2
        imgLang.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
