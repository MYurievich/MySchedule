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
        case 0: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.7450980392, green: 0.1568627451, blue: 0.07450980392, alpha: 1)
        case 1: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.4980392157, blue: 0.3529411765, alpha: 1)
        case 2: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.6862745098, blue: 0.1333333333, alpha: 1)
        case 3: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.2745098039, green: 0.4862745098, blue: 0.1411764706, alpha: 1)
        case 4: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        case 5: backgroundViewCell.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4980392157, blue: 0.7568627451, alpha: 1)
        default:
        backgroundViewCell.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.01176470588, blue: 0.5607843137, alpha: 1)
        }
    }

}
