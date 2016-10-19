import UIKit
import PureLayout

class HomeViewController: UIViewController {
  
  var viewReady = false
  var presenter: HomePresenter?
  
  /**
   Table view of the settings screen.
   */
  let tableView: UITableView = {
    let tableView = UITableView.newAutoLayout()
    tableView.backgroundColor = UIColor.white
    tableView.tableFooterView = UIView()
    return tableView
  }()
  
  override func loadView() {
    super.loadView()
    configViews()
    configTableView()
  }
  
  override func updateViewConstraints() {
    if !viewReady {
      configTableViewConstraints()
      viewReady = true
    }
    super.updateViewConstraints()
  }
  
  func configViews() {
    view.backgroundColor = UIColor(rgba: "#303030")
    [tableView].forEach { view.addSubview($0) }
    view.setNeedsUpdateConstraints()
  }
  
  func configTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  /**
   Return the style of the status bar for this ViewController.
   */
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
}

extension HomeViewController: UITableViewDataSource {

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.cellForRow(at: indexPath)!
  }

  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
}

extension HomeViewController: UITableViewDelegate {
  
}

extension HomeViewController: HomeView {
  
  func onSuccess() {
    
  }
  
  func onError() {
    
  }
  
}
