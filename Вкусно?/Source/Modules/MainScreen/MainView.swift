//
//  MainView.swift
//  Вкусно?
//
//  Created by Anton on 19.01.2023.
//

import UIKit

protocol MainView: AnyObject {
	func updateTableView()
}

final class MainViewController: UIViewController {
	
	// MARK: - Properties
	
	var presenter: MainViewPresenter?
	
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
		setupController()
		fetchItems()
	}

	// MARK: - Setup Controller
	
	private func setupController() {
		view.backgroundColor = .white
		title = Localization.appName.rawValue
		navigationController?.navigationBar.prefersLargeTitles = true
		view.addSubview(tableView)
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
		])
	}
	
	// MARK: - Private Methods
	
	private func fetchItems() {
		presenter?.fetchItems()
	}
}

// MARK: - Protocol

extension MainViewController: MainView {
	func updateTableView() {
		tableView.reloadData()
	}
}

// MARK: - Delegates Extensions

extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		presenter?.numberOfItems() ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell()
		}
		cell.recipe = presenter?.itemForRow(at: indexPath.row)
		presenter?.fetchImageData(for: indexPath.row) { data in
			cell.recipe?.imageData = data
		}
		return cell
	}
}

extension MainViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		.tableRowHeight
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		guard let view = presenter?.createDetailView(for: indexPath.row)
				as? UIViewController else { return }
		navigationController?.pushViewController(view, animated: true)
	}
}
