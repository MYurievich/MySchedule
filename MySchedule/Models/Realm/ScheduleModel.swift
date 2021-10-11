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
    @Persisted var scheduleName: String = "Unkown"
    @Persisted var scheduleType: String = "Unkown"
    @Persisted var scheduleBuilding: String = "Unkown"
    @Persisted var scheduleAudience: String = "Unkown"
    @Persisted var scheduleTeacher: String = "Unkown"
    @Persisted var scheduleColor: String = "1A4766"
    @Persisted var scheduleRepeat: Bool = true
    @Persisted var scheduleWeekday: Int = 1
    
}
