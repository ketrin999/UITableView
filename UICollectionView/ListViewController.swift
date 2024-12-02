//
//  ListViewController.swift
//  UICollectionView
//
//  Created by Ekaterina Yashunina on 03.10.2023.
//

import UIKit

class ListViewController: UITableViewController {

    private let cellID = "listCell"

    private lazy var customSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.isOn = true
        uiSwitch.tintColor = .white
        uiSwitch.backgroundColor = .darkGray
        uiSwitch.layer.cornerRadius = 15
        uiSwitch.thumbTintColor = .yellow
        uiSwitch.addTarget(self, action: #selector(changeScreenMode), for: .valueChanged)

        return uiSwitch
    }()

    private lazy var darkModeLabel: UILabel = {
        let label = UILabel()
        label.text = "dark mode"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorInset = .zero
        tableView.separatorColor = .darkGray

        setupNavigationBar()
    }

//    MARK: - Setup NavBar
    private func setupNavigationBar() {
        title = "to do list"
        navigationController?.navigationBar.prefersLargeTitles = true

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .lightGray

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        let navBarSwitch = UIBarButtonItem(customView: customSwitch)
        let navBarLabel = UIBarButtonItem(customView: darkModeLabel)
        navigationItem.leftBarButtonItems = [navBarSwitch, navBarLabel]
    }

    @objc private func changeScreenMode(sender: UISwitch) {
        if sender.isOn {
            darkModeLabel.text = "dark mode"
            view.backgroundColor = .white
            tableView.separatorColor = .darkGray
            tableView.reloadData()
        } else {
            view.backgroundColor = .darkGray
            tableView.separatorColor = .white
            darkModeLabel.text = "light mode"
            tableView.reloadData()
        }
    }

}

//    MARK: - Table view data sourse
    extension ListViewController {
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            10
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)

            var content = cell.defaultContentConfiguration()
            content.text = "tasks"
            content.textProperties.color = .lightGray
            cell.contentConfiguration = content

            cell.backgroundColor = tableView.backgroundColor

            return cell
        }

        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
