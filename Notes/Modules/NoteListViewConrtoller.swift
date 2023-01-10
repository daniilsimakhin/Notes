import UIKit

class NoteListViewConrtoller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        applyAppearance()
    }
}

private extension NoteListViewConrtoller {
    func applyAppearance() {
        title = "Заметки"
        view.backgroundColor = .systemBlue
    }
}
