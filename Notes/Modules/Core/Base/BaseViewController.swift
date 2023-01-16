import UIKit

class BaseViewController<T: UIView>: UIViewController {

    var baseView: T { view as! T }
    
    override func loadView() {
        super.loadView()
        view = T(frame: view.frame)
        setDelegates(baseView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    func setupViewController() { }
    func setDelegates(_ view: T) { }
}
