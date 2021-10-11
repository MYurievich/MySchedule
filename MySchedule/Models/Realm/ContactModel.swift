//
//  ContactModel.swift
//  MySchedule
//
//  Created by Максим on 11.10.2021.
//

import RealmSwift
import Foundation

class ContactModel: Object {
    
    @Persisted var contactsName = "Unknown"
    @Persisted var contactsPhone = "Unknown"
    @Persisted var contactsMail = "Unknown"
    @Persisted var contactsType = "Unknown"
    @Persisted var contactsImage: Data?
}
