//
//  DetailViewController.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 01/12/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    private let model: DetailViewModel
    
    private let button: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        btn.backgroundColor = .yellow
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = btn.frame.height/2
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(DetailViewController.didTapGoogle(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Google it!", for: .normal)
        btn.titleLabel?.font =  UIFont(name: "Star Jedi Outline", size: 12)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        return btn
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = model.title
        tableView.dataSource = self
        tableView.delegate = self
        model.delegate = self
        view.addSubview(tableView)
        view.addSubview(button)
        setupTableConstraints()
    }
    
    public init(model: DetailViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func didTapGoogle(_ sender:AnyObject)  {
        guard let url = URL(string: model.googleURL) else { return }
        UIApplication.shared.open(url)
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = model.skinColor
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.content.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model.headers[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.content[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = model.content[indexPath.section][indexPath.row].title
        cell.detailTextLabel?.text =  model.content[indexPath.section][indexPath.row].detail
        cell.textLabel?.font = UIFont(name: "Star Jedi Outline", size: 8)
        return cell
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func reloadData() {
        self.tableView.reloadData()
    }
}
