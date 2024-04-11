//
//  TableHeaderView.swift
//  MyHabits
//
//  Created by Yuliya Vodneva on 16.03.24.
//

import UIKit

final class TableHeaderView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    convenience init(title: String) {
        self.init(frame: .zero)
        
        titleLabel.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tuneView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(
            width: UIView.noIntrinsicMetric,
            height: 50.0
        )
    }
    
    private func tuneView() {
        backgroundColor = .customGray
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25)
        ])
    }
}
