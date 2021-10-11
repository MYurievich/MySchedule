//
//  ContactsTableViewController.swift
//  MySchedule
//
//  Created by Максим on 09.10.2021.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    let searchController = UISearchController()
    
    let idContactsCell = "idContactsCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController

        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .singleLine
        
        title = "Contacts"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: idContactsCell)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonTapped))
        
    }
    
    @objc func rightBarButtonTapped() {
        let contactOption = ContactsOptionsTableViewController()
        navigationController?.pushViewController(contactOption, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactsCell, for: indexPath) as! ContactsTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap")
    }
    }
