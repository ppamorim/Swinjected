import UIKit
import PureLayout

let ITEM_CELL = "ItemCell"

/**
 This is the Root ViewController of this application, this
 view has a presenter injected when the application starts
 and will configure the view elements and attach the
 callback that notifies any change on the data on the 
 presenter.
 */
class HomeViewController: UIViewController {
  
  var viewReady = false
  var presenter: HomePresenter?
  var cellHeight: CGFloat = 0.0
  
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
   Table view for items, configure the default background color, 
   footer view and register the ViewCell.
   */
  let itemTableView: UITableView = {
    let tableView = UITableView.newAutoLayout()
    tableView.backgroundColor = .black
    tableView.tableFooterView = UIView()
    tableView.register(ItemViewCell.self, forCellReuseIdentifier: ITEM_CELL)
    tableView.separatorColor = .clear
    return tableView
  }()
  
  /**
   Initializer that injects the presenter, there is many ways to
   do this but this is the most simple right now. If the presenter
   is null, this component will crash because has a problem with
   injection.
   */
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
  
  /**
   The ViewController instance is ready and can start the proccess
   to build the view.
   */
  override func loadView() {
    super.loadView()
    configViews()
  }
  
  /**
   After the view loaded, these methods are needed to configure
   the TableView and start the data loading.
   */
  override func viewDidLoad() {
    super.viewDidLoad()
    configTableView()
    loadData()
  }
  
  /**
   Configure the constraints, avoiding unecessary configuration 
   when the ViewController is invalidated or updated.
   */
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
  
  /**
   Add subviews on the ViewController view and call the method
   that force the calculation of the constraints.
   */
  func configViews() {
    [itemTableView, topBarView].forEach { view.addSubview($0) }
    topBarView.addSubview(logoView)
    view.setNeedsUpdateConstraints()
  }
  
  /**
   Configure the TableView delegate and data source to be used
   to load the data from the presenter.
   */
  func configTableView() {
    itemTableView.delegate = self
    itemTableView.dataSource = self
    cellHeight = (view.frame.width * CGFloat(9.0)).divided(by: CGFloat(16.0))
  }
  
  /**
   Start the syncronization of data, this is just a simple way
   to show this data loading feature.
   */
  func loadData() {
    presenter?.sync()
  }
  
}

/**
 This extension is needed to configure the height of the
 ViewCell and load the data, getting the information from
 the presenter.
 */
extension HomeViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellHeight
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

/**
 This extension is needed to control the data source used
 by the table view. This component follow the correct structure
 to load the data and avoid any allocation of data on
 the ViewController, using a protocol to get the count
 of items on the presenter.
 */
extension HomeViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: ITEM_CELL, for: indexPath)
  }

  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.items.count ?? 0
  }

}

/**
 This extension is needed to separate the data control of 
 the presenter on this ViewController. This is very useful
 because it avoid any problem of bad code structure and
 helps on maintenance and implementation of any new feature.
 */
extension HomeViewController: HomeView {
  
  func onSuccess() {
    itemTableView.reloadData()
  }
  
  func onError(_ error: Swift.Error) {
    
  }
  
}
