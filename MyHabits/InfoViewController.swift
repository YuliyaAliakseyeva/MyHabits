//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Yuliya Vodneva on 7.03.24.
//

import UIKit

final class InfoViewController: UIViewController {
    
    private var model = Information.make()
    
    private lazy var infoScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        return contentView
    }()
    
    private lazy var headlineInfo: UILabel = {
        let headline = UILabel()
        headline.translatesAutoresizingMaskIntoConstraints = false
        return headline
    }()
    
    private lazy var textInfo: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstrains()
        setupSubviews()
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        title = "Информация"
    }
    
    private func addSubviews() {
        view.addSubview(infoScrollView)
        infoScrollView.addSubview(contentView)
        contentView.addSubview(headlineInfo)
        contentView.addSubview(textInfo)
    }
    
    private func setupConstrains() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            infoScrollView.topAnchor.constraint(
                equalTo: safeAreaGuide.topAnchor
            ),
            infoScrollView.bottomAnchor.constraint(
                equalTo: safeAreaGuide.bottomAnchor
            ),
            infoScrollView.leadingAnchor.constraint(
                equalTo: safeAreaGuide.leadingAnchor
            ),
            infoScrollView.trailingAnchor.constraint(
                equalTo: safeAreaGuide.trailingAnchor
            ),
            
            contentView.topAnchor.constraint(
                equalTo: infoScrollView.topAnchor
            ),
            contentView.bottomAnchor.constraint(
                equalTo: infoScrollView.bottomAnchor
            ),
            contentView.leadingAnchor.constraint(
                equalTo: infoScrollView.leadingAnchor
            ),
            contentView.trailingAnchor.constraint(
                equalTo: infoScrollView.trailingAnchor
            ),
            contentView.widthAnchor.constraint(
                equalTo: infoScrollView.widthAnchor
            ),
            
            headlineInfo.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 20
            ),
            headlineInfo.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            headlineInfo.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            ),
            headlineInfo.heightAnchor.constraint(
                equalToConstant: 20
            ),
            
            textInfo.topAnchor.constraint(
                equalTo: headlineInfo.bottomAnchor,
                constant: 25
            ),
            textInfo.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            textInfo.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            ),
            textInfo.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -20
            ),
        ])
    }
    
    private func setupSubviews() {
        headlineInfo.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        headlineInfo.text = "Привычка за 21 день"
        
        textInfo.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textInfo.numberOfLines = 0
        textInfo.lineBreakMode = NSLineBreakMode.byWordWrapping
        textInfo.text = model.text
    }
}
