//
//  ViewWithHeader.swift
//  Вкусно?
//
//  Created by Anton on 21.01.2023.
//

import UIKit

final class ViewWithHeader: UIView {
	
	// MARK: - Properties

	private let header: String
	var body: String? {
		didSet {
			guard let body = body else {
				headerLabel.text = nil
				return
			}
			bodyLabel.text = body
		}
	}
	
	// MARK: - Elements
	
	private lazy var headerLabel: UILabel = {
		let label = UILabel()
		label.text = header
		label.font = Fonts.header.semibold
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var bodyLabel: UILabel = {
		let label = UILabel()
		label.font = Fonts.body.regular
		label.numberOfLines = 0
		label.textColor = .gray
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	// MARK: - Initializers

	init(header: String) {
		self.header = header
		super.init(frame: .zero)
		setupController()
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup Controller
	
	private func setupController() {
		addSubview(headerLabel)
		addSubview(bodyLabel)
		
		NSLayoutConstraint.activate([
			headerLabel.topAnchor.constraint(equalTo: topAnchor),
			headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			bodyLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: .verticalOffset),
			bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}
