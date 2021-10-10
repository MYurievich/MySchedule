//
//  ContactOptionTableViewController.swift
//  MySchedule
//
//  Created by Максим on 09.10.2021.
//

import UIKit

class ContactOptionTableViewController: UITableViewController {
    
    let idOptionsContactCell = "idOptionsContactCell"
    let idOptionsContactHeader = "idOptionsContactHeader"
    
    let headerNameArray = ["NAME", "PHONE", " MAIL", "TYPE", "CHOOSE IMAGE"]
    
    let cellNameArray = ["Name", "Phone", "Mail", "Type", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        
        tableView.bounces = false
        
        title = "Option Schedule"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsContactCell)
        tableView.register(HeaderOptionTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsContactHeader)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsContactCell, for: indexPath) as! OptionsTableViewCell
        cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 4 ? 200 : 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsContactHeader) as! HeaderOptionTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section {
        case 0: alertForCellName(label: cell.nameCellLabel, name: "Name Contact", placeholder: "Enter name contact")
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Phone Contact", placeholder: "Enter phone contact")
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Mail Contact", placeholder: "Enter mail contact")
        case 3: alertFriendOrTeacher(label: cell.nameCellLabel) { type in
            print(type)
        }
        default:
            print("Tap ContactTableView")
        }
    }
    
    func pushControllers(vc: UIViewController) {
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
    }
