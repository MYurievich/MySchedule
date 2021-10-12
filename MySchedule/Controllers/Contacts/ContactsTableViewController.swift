//
//  ContactsTableViewController.swift
//  MySchedule
//
//  Created by Максим on 11.10.2021.
//

import UIKit
import RealmSwift

class ContactsViewController: UIViewController {

    private let searchController = UISearchController()
    
    private let idContactsCell = "idContactsCell"

    private let localRealm = try! Realm()
    private var contactsArray: Results<ContactModel>!
    private var filtredArray: Results<ContactModel>!
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return true }
        return text.isEmpty
    }
    
    var isFiltring: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private let segmentedControll: UISegmentedControl = {
       let segmentedControll = UISegmentedControl(items: ["Friends", "Teachers"])
        segmentedControll.selectedSegmentIndex = 0
        return segmentedControll
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        contactsArray = localRealm.objects(ContactModel.self).filter("contactsType = 'Friend'")
        
        title = "Contacts"
        view.backgroundColor = .white

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: idContactsCell)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonTapped))
        
        segmentedControll.addTarget(self, action: #selector(segmentedChanged), for: .valueChanged)

        setConstraints()
        
    }

    @objc private func segmentedChanged() {
        
        if segmentedControll.selectedSegmentIndex == 0 {
            contactsArray = localRealm.objects(ContactModel.self).filter("contactsType = 'Friend'")
            tableView.reloadData()
        } else {
            contactsArray = localRealm.objects(ContactModel.self).filter("contactsType = 'Teacher'")
            tableView.reloadData()
    }
}
    
    @objc private func rightBarButtonTapped() {
        let contactOption = ContactsOptionsTableViewController()
        navigationController?.pushViewController(contactOption, animated: true)
    }
    }

//MARK: UITableViewDelegate, UITableViewDataSource

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactsCell, for: indexPath) as! ContactsTableViewCell
         let model = (isFiltring ? filtredArray[indexPath.row] : contactsArray[indexPath.row])
        cell.configure(model: model)
        return cell
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return (isFiltring ? filtredArray.count : contactsArray.count)
    }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap")
    }
    
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editingRow = contactsArray[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteContactModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension ContactsViewController:UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filtredArray = contactsArray.filter("contactsName CONTAINS[c] %@", searchText)
        tableView.reloadData()
    }
    
}

extension ContactsViewController {
    
    private func setConstraints() {
        
        let stackView = UIStackView(arrangedSubviews: [segmentedControll, tableView], axis: .vertical, spacing: 0, distribution: .equalSpacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
