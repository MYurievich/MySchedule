//
//  ScheduleOptionViewControllerCell.swift
//  MySchedule
//
//  Created by Максим on 25.07.2021.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {

    let backgroundViewCell: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let repeatSwitch: UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.isHidden = true
        repeatSwitch.onTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()
    
    let nameCellLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        
        self.selectionStyle = .none
        
        setConsctraints()
        
        repeatSwitch.addTarget(self, action: #selector(switchChange(paramTarget:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OptionsTableViewCell {
    
    func setConsctraints() {
        
        self.addSubview(backgroundViewCell)
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
        
        self.addSubview(nameCellLabel)
        NSLayoutConstraint.activate([
            nameCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameCellLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 15)
        ])
        
        contentView.addSubview(repeatSwitch)
        NSLayoutConstraint.activate([
            repeatSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            repeatSwitch.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -20)
        ])
        
        
}
    
    func cellScheduleConfigure(nameArray: [[String]], indexPath: IndexPath) {
        nameCellLabel.text = nameArray[indexPath.section][indexPath.row]
        
        if indexPath == [3,0] {
            backgroundViewCell.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        }
        
        if indexPath == [4,0] {
            repeatSwitch.isHidden = false
        }
    }
    
    func cellTasksConfigure(nameArray: [String], indexPath: IndexPath) {
        nameCellLabel.text = nameArray[indexPath.section]
        
        if indexPath == [3,0] {
            backgroundViewCell.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        }
    }
    
    func cellContactConfigure(nameArray: [String], indexPath: IndexPath) {
        nameCellLabel.text = nameArray[indexPath.section]
        indexPath.section == 4 ? backgroundViewCell.image = UIImage(systemName: "person.fill.badge.plus") : nil
    }
    
    @objc func switchChange(paramTarget: UISwitch) {
        if paramTarget.isOn {
            print("tap")
        } else {
            print("tap")
        }
    }
}