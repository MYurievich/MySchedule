//
//  ScheduleViewController.swift
//  MySchedule
//
//  Created by Максим on 17.07.2021.
//

import UIKit
import FSCalendar
import RealmSwift

class ScheduleViewController: UIViewController {
    
    private var calendarHeightConstraint: NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    private let showHideButton: UIButton = {
       let showHideButton = UIButton()
        showHideButton.setTitle("Open calendar", for: .normal)
        showHideButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        showHideButton.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        return showHideButton
    }()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let localRealm = try! Realm()
    
    var scheduleArray: Results<ScheduleModel>!
    
    private let identifiableCell = "cell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Schedule"
        
        calendar.delegate = self
        calendar.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: identifiableCell)
        
        calendar.scope = .week
        
        setConstraints()
        swipeAction()
        scheduleOnDay(date: Date())
        
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonTapped))
        
        if #available(iOS 15.0, *) {
            navigationController?.tabBarController?.tabBar.scrollEdgeAppearance = navigationController?.tabBarController?.tabBar.standardAppearance
        } 
    }

    @objc private func rightBarButtonTapped() {
        let scheduleOptionViewController = ScheduleOptionsViewController()
        navigationController?.pushViewController(scheduleOptionViewController, animated: true)
    }
    
    @objc private func showHideButtonTapped() {
        
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideButton.setTitle("Close calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideButton.setTitle("Open calendar", for: .normal)
        }
    }

//MARK: SwipeGestureRecognizer

    private func swipeAction() {
    
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
    }
    
    @objc private func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            showHideButtonTapped()
        case .down:
            showHideButtonTapped()
        default:
            break
        }
    }
    
    private func scheduleOnDay(date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else { return }
        
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart)!
        }()
        
        let predicateRepeat = NSPredicate(format: "scheduleWeekday = \(weekday) AND scheduleRepeat = true")
        let predicateUnrepeat = NSPredicate(format: "scheduleRepeat = false AND scheduleDate BETWEEN %@", [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeat])
        
        scheduleArray = localRealm.objects(ScheduleModel.self).filter(compound).sorted(byKeyPath: "scheduleTime")
        tableView.reloadData()
    }
}
//MARK: FSCalendarDataSource, FSCalendarDelegate

extension ScheduleViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        scheduleOnDay(date: date)
    }
}

//MARK: UITableViewDataSource, UITableViewDelegate

extension ScheduleViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiableCell, for: indexPath) as! ScheduleTableViewCell
        let model = scheduleArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editingRow = scheduleArray[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, competionHandler in
            RealmManager.shared.deleteScheduleModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}

//MARK: SetConstraints

extension ScheduleViewController {
    
    func setConstraints () {
    
        view.addSubview(calendar)
        
        calendarHeightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightConstraint)
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
        
        view.addSubview(showHideButton)
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            showHideButton.widthAnchor.constraint(equalToConstant: 100),
            showHideButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        
    }
}
