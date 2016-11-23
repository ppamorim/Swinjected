import UIKit
import PureLayout

let ITEM_CELL = "ItemCell"

class HomeViewController: UIViewController {
  
  var viewReady = false
  var presenter: HomePresenter?
  
  let topBarView: UIView = {
    let view = UIView.newAutoLayout()
    view.backgroundColor = UIColor(rgba: "#222223")
    return view
  }()
  
  let logoView: UIImageView = {
    let view = UIImageView.newAutoLayout()
    view.image = UIImage(named: "LogoSmall")
    return view
  }()
  
  /**
   Table view of the settings screen.
   */
  let itemTableView: UITableView = {
    let tableView = UITableView.newAutoLayout()
    tableView.backgroundColor = .blue
    tableView.tableFooterView = UIView()
    tableView.register(ItemViewCell.self, forCellReuseIdentifier: ITEM_CELL)
    return tableView
  }()
  
  init(_ presenter: HomePresenter?) {
    super.init(nibName: nil, bundle: nil)
    if presenter == nil {
      fatalError("Presenter must be injected")
    }
    self.presenter = presenter
    self.presenter?.view = self
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
      configTopBarViewConstraints()
      configLogoConstraints()
      viewReady = true
    }
    super.updateViewConstraints()
  }
  
  /**
   Return the style of the status bar for this ViewController.
   */
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  func configViews() {
    [itemTableView, topBarView].forEach { view.addSubview($0) }
    topBarView.addSubview(logoView)
    view.setNeedsUpdateConstraints()
  }
  
  func configTableView() {
    itemTableView.delegate = self
    itemTableView.dataSource = self
  }
  
  func loadData() {
    presenter?.sync()
  }
  
}

extension HomeViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: ITEM_CELL, for: indexPath)
  }

  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("numberOfRowsInSection) \(presenter?.items.count)")
    return presenter?.items.count ?? 0
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
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
    print("data to loco:\(presenter?.items.count)")
    itemTableView.reloadData()
  }
  
  func onError(_ error: Swift.Error) {
    
  }
  
}
