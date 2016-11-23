import PureLayout

extension HomeViewController {
  
  func configTableViewConstraints() {
    itemTableView.autoPinEdge(.top, to: .bottom, of: topBarView)
    itemTableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .top)
  }
  
  func configTopBarViewConstraints() {
    topBarView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .bottom)
    topBarView.autoSetDimension(.height, toSize: 44 + UIApplication.shared.statusBarFrame.height)
  }
  
  func configLogoConstraints() {
    logoView.autoAlignAxis(toSuperviewAxis: .vertical)
    logoView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 4)
    logoView.autoSetDimension(.height, toSize: 30)
  }
  
}
