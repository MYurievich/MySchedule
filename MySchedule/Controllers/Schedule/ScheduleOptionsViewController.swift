//
//  ScheduleOptionViewController.swift
//  MySchedule
//
//  Created by Максим on 25.07.2021.
//

import UIKit
import RealmSwift

class ScheduleOptionsViewController: UITableViewController {
    
    private let idOptionsScheduleCell = "idOptionsScheduleCell"
    private let idOptionsScheduleHeader = "idOptionsScheduleHeader"
    
    let headerNameArray = ["DATE AND TIME", "LESSON", " TEACHER", "COLOR", "PERIOD"]
    
    var cellNameArray = [["Date", "Time"],
                         ["Name", "Type", "Building", "Audience"],
                         ["Teacher Name"],
                         [""],
                         ["Repeat every 7 days"]
    ]
    var scheduleModel = ScheduleModel()
    
    var hexColorCell = "1A4766"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        
        tableView.bounces = false
        
        title = "Options Schedule"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsScheduleCell)
        tableView.register(HeaderOptionTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsScheduleHeader)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(rightBarButtonTapped))
        
    }
    
    @objc private func rightBarButtonTapped() {
        
        if scheduleModel.scheduleDate == nil || scheduleModel.scheduleTime == nil || scheduleModel.scheduleName == "Unknown" {
            alertOk(title: "Error", message: "Requered fields: DATE, TIME, NAME")
        } else {
        
        scheduleModel.scheduleColor = hexColorCell
        RealmManager.shared.saveScheduleModel(model: scheduleModel)
        scheduleModel = ScheduleModel() // сохранение с realmstudio
        alertOk(title: "Success", message: nil)
        hexColorCell = "1A4766"
            cellNameArray[2][0] = "Teacher Name"
        tableView.reloadData()
    }
}
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsScheduleCell, for: indexPath) as! OptionsTableViewCell
        cell.cellScheduleConfigure(nameArray: cellNameArray, indexPath: indexPath, hexColor: hexColorCell)
        cell.SwitchRepeatDelegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 4
        case 2: return 1
        case 3: return 1
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsScheduleHeader) as! HeaderOptionTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath {
            
        case [0,0]: alertDate(label: cell.nameCellLabel) { [self] numberWeekday, date in
            scheduleModel.scheduleDate = date
            scheduleModel.scheduleWeekday = numberWeekday
        }
        case [0,1]: alertTime(label: cell.nameCellLabel) { [self] time in
            scheduleModel.scheduleTime = time
        }
        case [1,0]: alertForCellName(label: cell.nameCellLabel, name: "Name Lesson", placeholder: "Enter name lesson") { [self] text in
            scheduleModel.scheduleName = text
        }
        case [1,1]: alertForCellName(label: cell.nameCellLabel, name: "Type Lesson", placeholder: "Enter type lesson") { [self] text in
            scheduleModel.scheduleType = text
        }
        case [1,2]: alertForCellName(label: cell.nameCellLabel, name: "Building number", placeholder: "Enter number of building") { [self] text in
            scheduleModel.scheduleBuilding = text
        }
        case [1,3]: alertForCellName(label: cell.nameCellLabel, name: "Audience number", placeholder: "Enter number of audience") { [self] text in
            scheduleModel.scheduleAudience = text
        }
            
        case [2,0]: pushControllers(vc: TeachersViewController())
           
        case [3,0]: pushControllers(vc: ScheduleColorsViewController())
            
        default:
            print("Error")
        }
    }
    
    func pushControllers(vc: UIViewController) {
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
    }

extension ScheduleOptionsViewController: SwitchRepeatProtocol {
    func switchRepeat(value: Bool) {
        scheduleModel.scheduleRepeat = value
    }
}
