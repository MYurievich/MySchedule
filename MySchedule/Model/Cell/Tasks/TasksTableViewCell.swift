//
//  TasksTableViewCell.swift
//  MySchedule
//
//  Created by Максим on 24.07.2021.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    
    let taskName = UILabel(text: "Программирование", font: UIFont.avenirNextDemiBold20(), alignment: .left)
    let taskDescription = UILabel(text: "Научиться писать extension", font: UIFont.avenirNext14(), alignment: .left)
    
    let readyButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var cellTaskDelegate: PressReadyButtonProtocol?
    var index: IndexPath?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        taskDescription.numberOfLines = 2
        
        setConstraints()
        
        readyButton.addTarget(self, action: #selector(readyButtonTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func readyButtonTap() {
        guard let index = index else { return }
        cellTaskDelegate?.readeButtonTapped(indexPath: index)
    }
    
}

extension TasksTableViewCell {
    
    func setConstraints() {
        
        self.contentView.addSubview(readyButton)
        NSLayoutConstraint.activate([
            readyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            readyButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            readyButton.heightAnchor.constraint(equalToConstant: 40),
            readyButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        self.addSubview(taskName)
        NSLayoutConstraint.activate([
            taskName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            taskName.trailingAnchor.constraint(equalTo: readyButton.trailingAnchor, constant: -5),
            taskName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskName.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        self.addSubview(taskDescription)
        NSLayoutConstraint.activate([
            taskDescription.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: 5),
            taskDescription.trailingAnchor.constraint(equalTo: readyButton.trailingAnchor, constant: -5),
            taskDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
