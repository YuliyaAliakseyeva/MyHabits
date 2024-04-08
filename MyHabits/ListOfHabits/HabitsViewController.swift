//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Yuliya Vodneva on 7.03.24.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private let habitsCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .customGray
        
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.identifier)
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupLayouts()
        
        let addHabitButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(pressedButton))
        
        navigationItem.rightBarButtonItem = addHabitButton
        navigationItem.backButtonTitle = "Сегодня"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupCollectionView()
        habitsCollectionView.reloadData()
    }
    
    @objc func pressedButton () {
        var habitNavigationController: UINavigationController!
        habitNavigationController = UINavigationController(rootViewController: HabitViewController())

        habitNavigationController.modalTransitionStyle = .coverVertical
        habitNavigationController.modalPresentationStyle = .fullScreen
        present(habitNavigationController, animated: true)
}
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupSubviews() {
        view.addSubview(habitsCollectionView)
        
    }
    
    private func setupCollectionView() {
        habitsCollectionView.dataSource = self
        habitsCollectionView.delegate = self
    }
    
    private func setupLayouts() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            habitsCollectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
    }
    
    private enum LayoutConstant {
           static let spacing: CGFloat = 16.0
           static let itemProgressHeight: CGFloat = 65.0
        static let itemHabitHeight: CGFloat = 140.0
       }

}

extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            1
        } else {
            HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProgressCollectionViewCell.identifier,
                for: indexPath) as! ProgressCollectionViewCell
            
            cell.configureProgress()
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HabitCollectionViewCell.identifier,
                for: indexPath) as! HabitCollectionViewCell
            
            let habit = HabitsStore.shared.habits[indexPath.row]
            cell.configureHabit(with: habit)
            cell.closure = {
                if habit.isAlreadyTakenToday == false {
                    HabitsStore.shared.track(habit)
                } else {
                    print("Привычка уже затрекана")
                }
            }
            return cell
        }
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout{
    
    private func itemWidth(
            for width: CGFloat,
            spacing: CGFloat
        ) -> CGFloat {
            let itemsInRow: CGFloat = 1
            
            let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
            let finalWidth = (width - totalSpacing) / itemsInRow
            
            return floor(finalWidth)
        }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath)
    -> CGSize {
        if indexPath.section == 0 {
            let width = itemWidth(
                for: view.frame.width,
                spacing: LayoutConstant.spacing
            )
            
            return CGSize(width: width, height: LayoutConstant.itemProgressHeight)
        } else {
            let width = itemWidth(
                for: view.frame.width,
                spacing: LayoutConstant.spacing
            )
            
            return CGSize(width: width, height: LayoutConstant.itemHabitHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(
            top: LayoutConstant.spacing,
            left: LayoutConstant.spacing,
            bottom: LayoutConstant.spacing,
            right: LayoutConstant.spacing
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int)
    -> CGFloat {
        LayoutConstant.spacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
            if indexPath.section == 1 {
        
                let habit = HabitsStore.shared.habits[indexPath.row]
                let habitDetailsViewController = HabitDetailsViewController()
                habitDetailsViewController.habit = habit
                habitDetailsViewController.title = habit.name
                habitDetailsViewController.indexOfHabit = indexPath.row
                navigationController?.pushViewController(habitDetailsViewController, animated: true)
            }
    }
}

