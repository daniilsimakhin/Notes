import UIKit

typealias C = Constans

struct Constans {
    struct Colors {
        
    }
    
    struct Images {
        struct Core {
            static let trash: UIImage? = UIImage(systemName: "trash.fill")
        }
    }
    
    struct Strings {
        static let delete: String = NSLocalizedString("Delete", comment: "Delete string")
        static let notes: String = NSLocalizedString("Notes", comment: "Notes string")
    }
}
