import UIKit
import PureLayout

class ItemViewCell: UITableViewCell {
  
  var didViewReady = false
  
  let titleLabel: UILabel = {
    let label = UILabel.newAutoLayout()
    label.backgroundColor = UIColor.white
    label.textAlignment = .left
    label.textColor = UIColor.black
    return label
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = UIColor.black
    [titleLabel].forEach { addSubview($0) }
    setNeedsUpdateConstraints()
    updateConstraintsIfNeeded()
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setNeedsUpdateConstraints() {
    if !didViewReady {
      configConstraints()
      didViewReady = true
    }
    super.setNeedsUpdateConstraints()
  }
  
  func configLabels(_ item: Item) {
    titleLabel.text = item.title
  }
  
}

extension ItemViewCell {
  
  func configConstraints() {
    titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 14.0)
    titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 9.0)
  }
  
}
