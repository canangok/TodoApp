import Foundation

enum Priority : String{
    case high = "High"
    case medium = "Medium"
    case low = "Low"
    case noPriority = "No Priority"
    
    var orderNo : Int{
        switch self {
        case .high:
            return 4
        case .medium:
            return 3
        case .low:
            return 2
        case .noPriority:
            return 1
        }
    }
}

struct CheckListItemModel {
    var taskName : String
    var priority : Priority
    
    init(priority:Priority = .high, taskName : String="") {
        self.priority = priority
        self.taskName = taskName
    }
}
