//
//  ViewController.swift
//  Storytel
//
//  Created by Ajay Rawat on 2021-03-18.
//

import UIKit

class BookListViewController: UIViewController {
  // MARK: Internal

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    configureTableView()
    loadBooks()
  }

  // MARK: Private

  private struct Constants {
    static let HeaderHeight: CGFloat = 100
    static let FooterHeight: CGFloat = 60
    static let HeaderMinimumHeight: CGFloat = 50
    static let FooterMinimumHeight = 0
    static let HeaderAnimationDuration = 1.0
    static let FooterAnimationDuration = 1.0
  }

  private let tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    return table
  }()

  private let footerView: LoaderView = {
    LoaderView()
  }()

  private let headerView: HeaderView = {
    HeaderView()
  }()

  private var headerViewHeightConstraint: NSLayoutConstraint!
  private var footerViewHeightConstraint: NSLayoutConstraint!

  private let tableCellIdentifier = "BookCell"
  private let imageLoader = ImageDownloader()
  private var isShowingHeader = false
  private let viewModel = BookViewModel()

  private func loadBooks() {
    viewModel.getPlaces { [weak self] isSuccess, error in
      guard let self = self else { return }
      DispatchQueue.main.async {
        if isSuccess {
          self.reloadTableData()
        } else {
          self.displayAlertMessage(message: error?.errorMessage)
        }
      }
    }
  }

  private func configureTableView() {
    tableView.register(BookTableViewCell.self, forCellReuseIdentifier: tableCellIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
  }

  private func setupViews() {
    view.addSubview(headerView)
    headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    headerViewHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: Constants.HeaderHeight)
    headerViewHeightConstraint.isActive = true
    headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

    view.addSubview(tableView)
    tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

    view.addSubview(footerView)
    footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    footerViewHeightConstraint = footerView.heightAnchor.constraint(equalToConstant: 0)
    footerViewHeightConstraint.isActive = true
    footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: 0).isActive = true
  }

  private func reloadTableData() {
    DispatchQueue.main.async {
      UIView.animate(withDuration: 2.0, delay: 0.0, options: .transitionCrossDissolve, animations: {
        self.footerViewHeightConstraint.constant = 0
        self.footerView.stopLoading()
        self.view.setNeedsLayout()
      }, completion: nil)
      self.headerView.setTitle(title: self.viewModel.titleForHeader)
      self.tableView.reloadData()
    }
  }

  private func loadMoreBooks() {
    UIView.animate(withDuration: Constants.FooterAnimationDuration, delay: 0.0, options: .transitionCrossDissolve, animations: {
      self.footerViewHeightConstraint.constant = Constants.FooterHeight
      self.footerView.startLoading()
      self.view.layoutIfNeeded()
    }, completion: nil)

    loadBooks()
  }
}

extension BookListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.books.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier) as? BookTableViewCell else {
      assertionFailure("Table cell is not register")
      return UITableViewCell(style: .subtitle, reuseIdentifier: tableCellIdentifier)
    }
    let currentBook = viewModel.books[indexPath.row]
    cell.titleLabel.text = currentBook.title
    cell.description1Label.text = currentBook.authorNameList
    cell.description2Label.text = currentBook.narratorNameList

    guard let imagePath = currentBook.cover?.url else {
      return cell
    }

    imageLoader.obtainImageWithPath(imagePath: imagePath) { image in
      DispatchQueue.main.async {
        cell.thumbnailImageView.image = image
        cell.setNeedsLayout()
      }
    }

    return cell
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let totalCount = viewModel.books.count
    if indexPath.row == (totalCount - 1) {
      loadMoreBooks()
    }
  }
}

extension BookListViewController {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y > Constants.HeaderHeight && isShowingHeader {
      UIView.animate(withDuration: Constants.HeaderAnimationDuration, delay: 0.0, options: .transitionCrossDissolve, animations: {
        self.headerViewHeightConstraint.constant = self.viewModel.shouldHideHeader ? 0 : Constants.HeaderMinimumHeight
        self.view.layoutIfNeeded()
      }, completion: { _ in
        self.isShowingHeader.toggle()
      })
    } else if scrollView.contentOffset.y < Constants.HeaderHeight && !isShowingHeader {
      UIView.animate(withDuration: Constants.HeaderAnimationDuration, delay: 0.0, options: .transitionCrossDissolve, animations: {
        self.headerViewHeightConstraint.constant = Constants.HeaderHeight
        self.view.layoutIfNeeded()
      }, completion: { _ in
        self.isShowingHeader.toggle()
      })
    }
  }
}
