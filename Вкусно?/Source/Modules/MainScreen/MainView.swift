//
//  MainView.swift
//  Вкусно?
//
//  Created by Anton on 19.01.2023.
//

import UIKit

protocol MainView: AnyObject {
	func reloadTableView(with recipes: [Recipe])
}

final class MainViewController: UIViewController {
	
	// MARK: - Properties
	
	var presenter: MainViewPresenter!
	
	// TODO: DELETE
	var recipes: [Recipe] = []
	
	// MARK: - Elements
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .grouped)
		tableView.backgroundColor = .white
		tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
		tableView.dataSource = self
		tableView.delegate = self
		return tableView
	}()
	
	// MARK: - LifeCycle

	override func viewDidLoad() {
		super.viewDidLoad()
		presenter = MainPresenter(view: self, networkService: NetworkService())
		setupController()
		fetchItems()
	}

	// MARK: - Setup Controller
	
	private func setupController() {
		view.backgroundColor = .white
		title = "Вкусно?"
		navigationController?.navigationBar.prefersLargeTitles = true
		view.addSubview(tableView)
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
		])
	}
	
	// MARK: - Private Methods
	
	private func fetchItems() {
		presenter.fetchItems()
	}
}

// MARK: - Protocol

extension MainViewController: MainView {
	func reloadTableView(with recipes: [Recipe]) {
		self.recipes = recipes
		tableView.reloadData()
	}
}

// MARK: - Delegates Extensions

extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		recipes.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell()
		}
		cell.recipe = recipes[indexPath.row]
		return cell
	}
}

extension MainViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		80
	}
}
