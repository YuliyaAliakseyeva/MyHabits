//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Yuliya Vodneva on 14.03.24.
//

import UIKit

private enum Constants {
        static let contentViewCornerRadius: CGFloat = 8.0
}

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private lazy var text: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var percent: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progress: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        addSubviews()
        setupSubviews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        contentView.backgroundColor = .white
    }
    
    private func addSubviews() {
        contentView.addSubview(text)
        contentView.addSubview(percent)
        contentView.addSubview(progress)
    }
    
    private func setupSubviews() {
        text.textColor = .systemGray
        text.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        
        percent.textColor = .systemGray
        percent.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        percent.textAlignment = .right
        
        progress.transform = CGAffineTransform(scaleX: 1, y: 2)
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 5
            ),
            text.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 12
            ),
            text.widthAnchor.constraint(
                equalToConstant: 180
            ),
            
            percent.topAnchor.constraint(
                equalTo: text.topAnchor
            ),
            percent.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -12
            ),
            percent.widthAnchor.constraint(
                equalToConstant: 40
            ),
            percent.bottomAnchor.constraint(
                equalTo: text.bottomAnchor
            ),
            
            progress.topAnchor.constraint(
                equalTo: text.bottomAnchor,
                constant: 5
            ),
            progress.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 12
            ),
            progress.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -12
            ),
            progress.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -12
            ),
            
        ])
    }
    
    func configureProgress() {
        text.text = "Все получится!"
        progress.progress = HabitsStore.shared.todayProgress
        let transformProgress = Int(progress.progress*100)
        percent.text = "\(transformProgress)%"
    }
}
