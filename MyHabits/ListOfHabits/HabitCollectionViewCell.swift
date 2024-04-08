//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Yuliya Vodneva on 14.03.24.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
            static let contentViewCornerRadius: CGFloat = 8.0
        }
    
    private lazy var habitsNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var counterNumLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(trackedHabit)
        )
        image.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    var closure: (() -> ())?
    
    @objc func trackedHabit() {
        habitImage.image = UIImage(systemName: "checkmark.circle.fill")
        habitImage.tintColor = habitsNameLabel.textColor
        print("привычка затрекана")
        closure?()
    }
    
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
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
    }
    private func addSubviews() {
        contentView.addSubview(habitsNameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(counterLabel)
        contentView.addSubview(counterNumLabel)
        contentView.addSubview(habitImage)
    }
    private func setupSubviews() {
        habitsNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        habitsNameLabel.numberOfLines = 0
        
        timeLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        timeLabel.textColor = .systemGray2
        
        counterLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        counterLabel.textColor = .systemGray
        
        counterNumLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        counterNumLabel.textColor = .systemGray
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            habitsNameLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 20
            ),
            habitsNameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            habitsNameLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -90
            ),
            
            timeLabel.topAnchor.constraint(
                equalTo: habitsNameLabel.bottomAnchor,
                constant: 10
            ),
            timeLabel.leadingAnchor.constraint(
                equalTo: habitsNameLabel.leadingAnchor
            ),
            timeLabel.trailingAnchor.constraint(
                equalTo: habitsNameLabel.trailingAnchor
            ),

            counterLabel.leadingAnchor.constraint(
                equalTo: habitsNameLabel.leadingAnchor
            ),
            counterLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -20
            ),
            
            counterNumLabel.topAnchor.constraint(
                equalTo: counterLabel.topAnchor
            ),
            counterNumLabel.leadingAnchor.constraint(
                equalTo: counterLabel.trailingAnchor,
                constant: 2),
            counterNumLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -20
            ),
            
            habitImage.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            habitImage.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20),
            habitImage.heightAnchor.constraint(
                equalToConstant: 45
            ),
            habitImage.widthAnchor.constraint(
                equalTo: habitImage.heightAnchor
            ),
        ])
    }
    
    public func configureHabit(
        with habit: Habit
    ) {
        habitsNameLabel.text = habit.name
        habitsNameLabel.textColor = habit.color
        timeLabel.text = habit.dateString
        
        counterLabel.text = "Счётчик:"
        counterNumLabel.text = String(habit.trackDates.count)
        
        habitImage.tintColor = habit.color
        
        if habit.isAlreadyTakenToday == false {
            habitImage.image = UIImage(systemName: "circle")
            
        } else if habit.isAlreadyTakenToday == true {
            habitImage.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            print("Error")
        }
    }
}
