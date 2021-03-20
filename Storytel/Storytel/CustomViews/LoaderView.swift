//
//  LoaderView.swift
//  Storytel
//
//  Created by Ajay Rawat on 2021-03-20.
//

/*!
 @discussion This class use as loader while loading more data, this class contain a activity indicator
 and method to start and stop loading activity indicator
 */

import UIKit

class LoaderView: UIView {

  private let activityIndicatorView: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    return activityIndicator
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
    addSubview(activityIndicatorView)
    activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
  }

  func startLoading() {
    activityIndicatorView.startAnimating()
  }

  func stopLoading() {
    activityIndicatorView.stopAnimating()
  }
}
