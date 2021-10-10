//
//  ScheduleColorTableViewCell.swift
//  MySchedule
//
//  Created by Максим on 08.10.2021.
//

import UIKit

class ColorsTableViewCell: UITableViewCell {

    let backgroundViewCell: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        
        self.selectionStyle = .none
        
        setConsctraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ColorsTableViewCell {
    
    func setConsctraints() {
        
        self.addSubview(backgroundViewCell)
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
}
    
    func cellConfigure(indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0: backgroundViewCell.backgroundColor = .red
        case 1: backgroundViewCell.backgroundColor = .orange
        case 2: backgroundViewCell.backgroundColor = .yellow
        case 3: backgroundViewCell.backgroundColor = .green
        case 4: backgroundViewCell.backgroundColor = .blue
        case 5: backgroundViewCell.backgroundColor = .systemBlue
            
        default:
        backgroundViewCell.backgroundColor = .purple
        }
    }

}
