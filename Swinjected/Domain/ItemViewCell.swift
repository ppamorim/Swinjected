import UIKit
import PureLayout
import AlamofireImage

class ItemViewCell: UITableViewCell {
  
  var didViewReady = false
  
  let titleLabel: UILabel = {
    let label = UILabel.newAutoLayout()
    label.textAlignment = .left
    label.textColor = .white
    return label
  }()
  
  let backgroundImageView: UIImageView = {
    let view = UIImageView.newAutoLayout()
    return view
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = .black
    [backgroundImageView, titleLabel].forEach { addSubview($0) }
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
    if let imageAddress = item.image, let imageURL = URL(string: imageAddress) {
      backgroundImageView.af_setImage(withURL: imageURL)
    }
  }
  
}

extension ItemViewCell {
  
  func configConstraints() {
    titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
    titleLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16.0)
    backgroundImageView.autoPinEdgesToSuperviewEdges()
  }
  
}
