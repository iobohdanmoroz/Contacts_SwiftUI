
import Foundation

enum DisplayOrder: Int {
    case lastFirst
    case firstLast
}

enum InfoView: Int {
    case detailed
    case short
}

enum Settings {
    static var displayOrder = DisplayOrder.firstLast
    static var infoView = InfoView.detailed
}
