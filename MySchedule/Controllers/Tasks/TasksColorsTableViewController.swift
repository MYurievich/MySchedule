//
//  ColorTasksTableViewController.swift
//  MySchedule
//
//  Created by Максим on 08.10.2021.
//

import UIKit

class TasksColorsTableViewController: UITableViewController {
    
    let idTasksColorCell = "idTasksColorCell"
    let idTaskScheduleHeader = "idTaskScheduleHeader"
    
    let headerNameArray = ["RED", "ORANGE", "YELLOW", "GREEN", "BLUE", "DEEP BLUE", "PURPLE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        
        tableView.bounces = false
        
        title = "Color Tasks"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ColorsTableViewCell.self, forCellReuseIdentifier: idTasksColorCell)
        tableView.register(HeaderOptionTableViewCell.self, forHeaderFooterViewReuseIdentifier: idTaskScheduleHeader)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTasksColorCell, for: indexPath) as! ColorsTableViewCell
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idTaskScheduleHeader) as! HeaderOptionTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       print("tapCell")
    }
    }
