//
//  ContactsTableViewCell.swift
//  MySchedule
//
//  Created by Максим on 09.10.2021.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    let contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "contact")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let phoneImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let mailImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "envelope.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel = UILabel(text: "Cruella De Vil", font: .avenirNext20(), alignment: .left)
    let phoneLabel = UILabel(text: "+7 666 66 66 66", font: .avenirNext14(), alignment: .center)
    let mailLabel = UILabel(text: "CruellaDeVill@mail.ru", font: .avenirNext14(), alignment: .center)
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        contactImageView.layer.cornerRadius = contactImageView.frame.height / 2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        setConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ContactModel) {
        
        nameLabel.text = model.contactsName
        phoneLabel.text = model.contactsPhone
        mailLabel.text = model.contactsMail
        
        guard let data = model.contactsImage, let image = UIImage(data: data) else { return }
        contactImageView.image = image
    }
    
}

extension ContactsTableViewCell {
    
    func setConstraints() {
        
        self.addSubview(contactImageView)
        NSLayoutConstraint.activate([
        contactImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        contactImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
        contactImageView.widthAnchor.constraint(equalToConstant: 70),
        contactImageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
        nameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        nameLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [phoneImageView, phoneLabel, mailImageView, mailLabel], axis: .horizontal, spacing: 3, distribution: .fillProportionally)
        
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 21)
        ])
        
    }
}
