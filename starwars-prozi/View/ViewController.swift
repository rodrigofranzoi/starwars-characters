//
//  ViewController.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 30/11/21.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    let model = MainViewModel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
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
        setupTableConstraints()
        
        model.loadData()
    }

    func setupTableConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.cellClicked(atIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == model.characters.count-5 {
            model.loadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier) as? MainCell else { return UITableViewCell() }
        let character = model.characters[indexPath.row]
        cell.usernameLabel.text = character.name ?? "Unknown"
        cell.imgLang.image = nil
        cell.usernameLabel.textColor = character.gender.color
        RestManager.getLanguageImage(url: character.species?.first) { status in
            switch status {
            case .succeeded(let data):
                cell.imgLang.image = UIImage(data: data)
            case .failed: break
            }
        }
        return cell
    }
}

extension ViewController: MainViewDelegate {
    
    func goToDetail(character: Character, hometown: String) {
        let model = DetailViewModel(chatacter: character, hometown: hometown)
        self.navigationController?.pushViewController(DetailViewController(model: model), animated: true)
    }
    
    func reloadTable() {
        self.tableView.reloadData()
    }
    
    func addCharacter(character char: Character) {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: model.characters.count-1, section: 0)], with: .none)
        tableView.endUpdates()
    }
}
