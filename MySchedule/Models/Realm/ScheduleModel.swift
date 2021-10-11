//
//  ScheduleModel.swift
//  MySchedule
//
//  Created by Максим on 11.10.2021.
//

import RealmSwift
import Foundation

class ScheduleModel: Object {
    
    @Persisted var scheduleDate = Date()
    @Persisted var scheduleTime = Date()
    @Persisted var scheduleName: String = ""
    @Persisted var scheduleType: String = ""
    @Persisted var scheduleBuilding: String = ""
    @Persisted var scheduleAudience: String = ""
    @Persisted var scheduleTeacher: String = "Name LastName"
    @Persisted var scheduleColor: String = "FFFFF"
    @Persisted var scheduleRepeat: Bool = true
    @Persisted var scheduleWeekday: Int = 1
    
}
