//
//  DetailsTableViewCell.swift
//  MyHabits
//
//  Created by Yuliya Vodneva on 16.03.24.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .default,
            reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        contentView.backgroundColor = .white
        
        accessoryView = nil
        accessoryType = .checkmark
        
        selectionStyle = .gray
    }
    
    func update(_ index: Int, _ habit: Habit) {
        
        textLabel?.text = HabitsStore.shared.trackDateString(forIndex: (HabitsStore.shared.dates.count - 2 - index))
        let date = HabitsStore.shared.dates[HabitsStore.shared.dates.count - 2 - index]
        if HabitsStore.shared.habit(habit, isTrackedIn: date) {
            accessoryType = .checkmark
        } else {
            accessoryType = .none
        }
    }
}
