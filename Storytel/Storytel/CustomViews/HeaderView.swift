//
//  HeaderView.swift
//  Storytel
//
//  Created by Ajay Rawat on 2021-03-20.
//
/*!
 @discussion This class use as header with a label to show the center align title
 */

import UIKit

class HeaderView: UIView {

  private let headerTitleLabel: UILabel = {
    let header = UILabel()
    header.textAlignment = .center
    header.translatesAutoresizingMaskIntoConstraints = false
    header.font = UIFont.boldSystemFont(ofSize: 24)
    header.textColor = .systemBlue
    return header
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
    addSubview(headerTitleLabel)

    headerTitleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    headerTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    headerTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
  }

  func setTitle(title: String?) {
    headerTitleLabel.text = title
  }
}
