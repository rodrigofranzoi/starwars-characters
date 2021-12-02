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
        
        view.backgroundColor = .systemGray5
        
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Rodrigo Franzoi Scroferneker\n19-04-1996"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton()
        button.setTitle("GitHub", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(DeveloperView.didTapGitHub(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 48),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func didTapGitHub(_ sender:AnyObject)  {
        guard let url = URL(string: "https://github.com/rodrigofranzoi") else { return }
        UIApplication.shared.open(url)
    }
    

}
