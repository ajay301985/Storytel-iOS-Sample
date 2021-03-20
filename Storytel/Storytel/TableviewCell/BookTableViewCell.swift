//
//  BookTableViewCell.swift
//  Storytel
//
//  Created by Ajay Rawat on 2021-03-20.
//
/*!
 @discussion TableCell class with a UIImageview (thumbnail) and three label to show the header
 description and description2
 */


import UIKit

private func descriptionLabel() -> UILabel {
  let titleObj = UILabel()
  titleObj.font = UIFont.systemFont(ofSize: 14)
  titleObj.translatesAutoresizingMaskIntoConstraints = false
  return titleObj
}

class BookTableViewCell: UITableViewCell {
  // MARK: Lifecycle

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    translatesAutoresizingMaskIntoConstraints = false
    selectionStyle = .none
    setupViews()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  let titleLabel: UILabel = {
    let titleObj = UILabel()
    titleObj.font = UIFont.boldSystemFont(ofSize: 18)
    titleObj.translatesAutoresizingMaskIntoConstraints = false
    return titleObj
  }()

  let description1Label: UILabel = {
    descriptionLabel()
  }()

  let description2Label: UILabel = {
    descriptionLabel()
  }()

  let thumbnailImageView: UIImageView = {
    let thumbnail = UIImageView()
    thumbnail.translatesAutoresizingMaskIntoConstraints = false
    thumbnail.heightAnchor.constraint(equalToConstant: 100).isActive = true
    thumbnail.widthAnchor.constraint(equalToConstant: 100).isActive = true
    thumbnail.image = UIImage(named: "placeholder.jpg")
    thumbnail.contentMode = .scaleAspectFill
    thumbnail.clipsToBounds = true
    return thumbnail
  }()

  // MARK: Private

  private let stackView: UIStackView = {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.spacing = 10
    stack.distribution = .fillEqually
    return stack
  }()

  private func setupViews() {
    contentView.addSubview(thumbnailImageView)
    thumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true

    contentView.addSubview(stackView)
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(description1Label)
    stackView.addArrangedSubview(description2Label)

    stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
    stackView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 5).isActive = true
    stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    self.thumbnailImageView.image = UIImage(named: "placeholder.jpg")

  }
}
