//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Yuliya Vodneva on 16.03.24.
//

import UIKit

final class HabitDetailsViewController: UIViewController {
    
    var indexOfHabit: Int?
    var habit = Habit(name: "", date: .now, color: .red)
    var closureDetails: ((_ habit: Habit) -> ())?
    
    private var detailsTableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .plain
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private enum CellReuseID: String {
        case base = "DetailsTableViewCell_ReuseID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
        tuneTableView()
        subscribeOnNotificationCenter()
        
        let editHabitButton = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editButton))
        
        navigationItem.rightBarButtonItem = editHabitButton
    }
    
    @objc func editButton () {
        var habitNavigationController: UINavigationController!
        habitNavigationController = UINavigationController(rootViewController: HabitViewController())
        let habitViewController = HabitViewController()
        habitNavigationController.viewControllers = [habitViewController]
        
        habitViewController.exist = true
        habitViewController.index = indexOfHabit
        
        habitNavigationController.modalTransitionStyle = .coverVertical
        habitNavigationController.modalPresentationStyle = .fullScreen
        present(habitNavigationController, animated: true)
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    private func addSubviews() {
        view.addSubview(detailsTableView)
    }
    private func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            detailsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            detailsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            detailsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            detailsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func tuneTableView() {
        
        detailsTableView.rowHeight = UITableView.automaticDimension
        detailsTableView.estimatedRowHeight = 25
        
        let headerView = TableHeaderView(title: "АКТИВНОСТЬ")
        detailsTableView.setAndLayout(headerView: headerView)
        detailsTableView.tableFooterView = UIView()
        
        detailsTableView.register(
            DetailsTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.base.rawValue)
        
        detailsTableView.dataSource = self
        detailsTableView.delegate = self
    }
    
    func subscribeOnNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(notificationAction),
            name: .deleteHabit,
            object: nil
        )
    }
    
    @objc func notificationAction() {
        navigationController?.popViewController(animated: false)
        
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = detailsTableView.dequeueReusableCell(
            withIdentifier: CellReuseID.base.rawValue,
            for: indexPath
        ) as? DetailsTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        
        let index = indexPath.item
        cell.update(index, habit)
        
        return cell
    }
}

extension HabitDetailsViewController: UITableViewDelegate {
    
}
