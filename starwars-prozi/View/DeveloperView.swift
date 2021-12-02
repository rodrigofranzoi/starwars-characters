//
//  DeveloperView.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 02/12/21.
//

import Foundation
import UIKit

class DeveloperView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "stars")
        imageView.sizeToFit()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.textColor = .yellow
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Rodrigo Franzoi Scroferneker\n19-04-1996"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Star Jedi Outline", size: 15)
        
        let button = UIButton()
        button.setTitle("GitHub", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(DeveloperView.didTapGitHub(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(button)
        view.addSubview(label)
        

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 48),
            button.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
    }
    
    @objc func didTapGitHub(_ sender:AnyObject)  {
        guard let url = URL(string: "https://github.com/rodrigofranzoi") else { return }
        UIApplication.shared.open(url)
    }
    

}
