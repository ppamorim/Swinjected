import UIKit
import PureLayout

let ITEM_CELL = "ItemCell"

class HomeViewController: UIViewController {
  
  var viewReady = false
  var presenter: HomePresenter?
  
  /**
   Table view of the settings screen.
   */
  let itemTableView: UITableView = {
    let tableView = UITableView.newAutoLayout()
    tableView.backgroundColor = UIColor.blue
    tableView.tableFooterView = UIView()
    tableView.register(ItemViewCell.self, forCellReuseIdentifier: ITEM_CELL)
    return tableView
  }()
  
  init(_ presenter: HomePresenter?) {
    super.init(nibName: nil, bundle: nil)
    self.presenter = presenter
    if self.presenter == nil {
      fatalError("Presenter must be injected")
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    configViews()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configTableView()
    loadData()
  }
  
  override func updateViewConstraints() {
    if !viewReady {
      configTableViewConstraints()
      viewReady = true
    }
    super.updateViewConstraints()
  }
  
  func configViews() {
    [itemTableView].forEach { view.addSubview($0) }
    view.setNeedsUpdateConstraints()
  }
  
  func configTableView() {
    itemTableView.delegate = self
    itemTableView.dataSource = self
  }
  
  func loadData() {
    presenter?.sync()
  }
  
  /**
   Return the style of the status bar for this ViewController.
   */
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
}

extension HomeViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("tableView eee")
    return tableView.dequeueReusableCell(withIdentifier: ITEM_CELL, for: indexPath)
  }

  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.items.count ?? 0
  }
  
}

extension HomeViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView,
                 willDisplay cell: UITableViewCell,
                 forRowAt indexPath: IndexPath) {
    if let itemViewCell = cell as? ItemViewCell,
      let item = presenter?.items[indexPath.row] {
      itemViewCell.configLabels(item)
    }
  }
  
}

extension HomeViewController: HomeView {
  
  func onSuccess() {
    itemTableView.reloadData()
  }
  
  func onError(_ error: Swift.Error) {
    
  }
  
}
