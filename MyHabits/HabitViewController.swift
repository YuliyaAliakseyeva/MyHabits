//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Yuliya Vodneva on 9.03.24.
//

import UIKit

public class HabitViewController: UIViewController {
    
    public var store = HabitsStore.shared
    var exist = false
    var index: Int?
    
    private lazy var createScrollView: UIScrollView = {
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
    
    private lazy var habitsNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitsNameTextField: UITextField = {
        let textField = UITextField(frame: .infinite)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var colorImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedColor))
        image.addGestureRecognizer(tap)
        return image
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeInstallLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeFromDatePikerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timePiker: UIDatePicker = {
        let piker = UIDatePicker()
        piker.translatesAutoresizingMaskIntoConstraints = false
        return piker
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
   
    public override func viewDidLoad() {
        super.viewDidLoad()
       
        setupView()
        addSubviews()
        setupConstrains()
        setupSubviews()
       
    }
    
    @objc func selectedColor() {
        let colorPiker = UIColorPickerViewController()
        colorPiker.title = "Выбор цвета"
        colorPiker.supportsAlpha = false
        colorPiker.delegate = self
        colorPiker.modalPresentationStyle = .popover
        colorPiker.popoverPresentationController?.sourceItem = self.navigationItem.rightBarButtonItem
        colorPiker.selectedColor = colorImage.tintColor
        self.present(colorPiker, animated: true)
        
        print("Select color")
        
    }
    
    @objc func safedHabit () {
        if exist {
            let editedHabit = Habit(name: habitsNameTextField.text ?? "Что-то пошло не так",
                                 date: timePiker.date,
                                 color: colorImage.tintColor)
            
            store.habits[index!].name = editedHabit.name
            store.habits[index!].date = editedHabit.date
            store.habits[index!].color = editedHabit.color
        } else {
            let newHabit = Habit(name: habitsNameTextField.text ?? "Что-то пошло не так",
                                 date: timePiker.date,
                                 color: colorImage.tintColor)
            store.habits.append(newHabit)
            
            dismiss(animated: true)
        
            print("Привычка сохранена")
        }
}
    
    @objc func canceledNewHabit () {
        dismiss(animated: true)
        print("Отмена создания новой привычки")
}
    
    @objc func timeChanged() {
        getTimeFromDatePiker(date: timePiker.date)
    }
    
    @objc func deletedHabit(_ sender: UIButton) {
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: {action in print("Отмена удаления привычки")
        }))
        alert.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { [self]action in 
            store.habits.remove(at: index!)
            print("Привычка удалена")
        }))
        
        alert.modalTransitionStyle = .flipHorizontal
        alert.modalPresentationStyle = .pageSheet
        
        present(alert, animated: true)
    }

    private func setupView() {
        
        view.backgroundColor = .lightGray
        
        if exist {
            title = "Править"
        } else {
            title = "Создать"
        }
        
        let safeButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(safedHabit))
        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(canceledNewHabit))
        
        navigationItem.rightBarButtonItem = safeButton
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    private func addSubviews() {
        view.addSubview(createScrollView)
        createScrollView.addSubview(contentView)
        contentView.addSubview(habitsNameLabel)
        contentView.addSubview(habitsNameTextField)
        contentView.addSubview(colorLabel)
        contentView.addSubview(colorImage)
        contentView.addSubview(timeLabel)
        contentView.addSubview(timeInstallLabel)
        contentView.addSubview(timeFromDatePikerLabel)
        contentView.addSubview(timePiker)
        contentView.addSubview(deleteButton)
    }
    
    private func setupConstrains() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            createScrollView.topAnchor.constraint(
                equalTo: safeAreaGuide.topAnchor
            ),
            createScrollView.bottomAnchor.constraint(
                equalTo: safeAreaGuide.bottomAnchor
            ),
            createScrollView.leadingAnchor.constraint(
                equalTo: safeAreaGuide.leadingAnchor
            ),
            createScrollView.trailingAnchor.constraint(
                equalTo: safeAreaGuide.trailingAnchor
            ),
            
            contentView.topAnchor.constraint(
                equalTo: createScrollView.topAnchor
            ),
            contentView.bottomAnchor.constraint(
                equalTo: createScrollView.bottomAnchor
            ),
            contentView.leadingAnchor.constraint(
                equalTo: createScrollView.leadingAnchor
            ),
            contentView.trailingAnchor.constraint(
                equalTo: createScrollView.trailingAnchor
            ),
            contentView.widthAnchor.constraint(
                equalTo: createScrollView.widthAnchor
            ),
            
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
                constant: -20
            ),
            habitsNameLabel.heightAnchor.constraint(
                equalToConstant: 22
            ),
            
            habitsNameTextField.topAnchor.constraint(
                equalTo: habitsNameLabel.bottomAnchor,
                constant: 15
            ),
            habitsNameTextField.leadingAnchor.constraint(
                equalTo: habitsNameLabel.leadingAnchor
            ),
            habitsNameTextField.trailingAnchor.constraint(
                equalTo: habitsNameLabel.trailingAnchor
            ),
            habitsNameTextField.heightAnchor.constraint(
                equalToConstant: 22
            ),
            
            colorLabel.topAnchor.constraint(
                equalTo: habitsNameTextField.bottomAnchor,
                constant: 15
            ),
            colorLabel.leadingAnchor.constraint(
                equalTo: habitsNameLabel.leadingAnchor
            ),
            colorLabel.trailingAnchor.constraint(
                equalTo: habitsNameLabel.trailingAnchor
            ),
            colorLabel.heightAnchor.constraint(
                equalToConstant: 22
            ),
            
            colorImage.topAnchor.constraint(
                equalTo: colorLabel.bottomAnchor,
                constant: 10
            ),
            colorImage.leadingAnchor.constraint(
                equalTo: habitsNameLabel.leadingAnchor
            ),
            colorImage.widthAnchor.constraint(
                equalToConstant: 40
            ),
            colorImage.heightAnchor.constraint(
                equalTo: colorImage.widthAnchor
            ),
            
            timeLabel.topAnchor.constraint(
                equalTo: colorImage.bottomAnchor,
                constant: 10
            ),
            timeLabel.leadingAnchor.constraint(
                equalTo: habitsNameLabel.leadingAnchor
            ),
            timeLabel.trailingAnchor.constraint(
                equalTo: habitsNameLabel.trailingAnchor
            ),
            timeLabel.heightAnchor.constraint(
                equalToConstant: 22
            ),
            
            timeInstallLabel.topAnchor.constraint(
                equalTo: timeLabel.bottomAnchor,
                constant: 15
            ),
            timeInstallLabel.leadingAnchor.constraint(
                equalTo: habitsNameLabel.leadingAnchor
            ),
            timeInstallLabel.heightAnchor.constraint(
                equalToConstant: 22
            ),
            
            timeFromDatePikerLabel.topAnchor.constraint(
                equalTo: timeInstallLabel.topAnchor
            ),
            timeFromDatePikerLabel.leadingAnchor.constraint(
                equalTo: timeInstallLabel.trailingAnchor
            ),
            timeFromDatePikerLabel.heightAnchor.constraint(
                equalToConstant: 22
            ),
            
            timePiker.topAnchor.constraint(
                equalTo: timeFromDatePikerLabel.bottomAnchor,
                constant: 20
            ),
            timePiker.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            timePiker.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            
            deleteButton.topAnchor.constraint(
                equalTo: timePiker.bottomAnchor,
                constant: 200
            ),
            deleteButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            deleteButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            deleteButton.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -10
            )
        ])
    }
    
    private func setupSubviews() {
        
        if exist {
            deleteButton.isHidden = false
            habitsNameTextField.text = store.habits[index!].name
            colorImage.tintColor = store.habits[index!].color
            
            getTimeFromDatePiker(date: store.habits[index!].date)
            timePiker.date = store.habits[index!].date
            
        } else {
            deleteButton.isHidden = true
            getTimeFromDatePiker(date: timePiker.date)
        }
        
        habitsNameLabel.text = "НАЗВАНИЕ"
        habitsNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        habitsNameLabel.textColor = .black
        
        habitsNameTextField.backgroundColor = .white
        habitsNameTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        habitsNameTextField.textColor = .systemGray2
        habitsNameTextField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        habitsNameTextField.keyboardType = UIKeyboardType.default
        habitsNameTextField.returnKeyType = UIReturnKeyType.done
        habitsNameTextField.autocapitalizationType = .none
        habitsNameTextField.leftViewMode = .always
        habitsNameTextField.delegate = self
        
        colorLabel.text = "ЦВЕТ"
        colorLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        colorLabel.textColor = .black
        
        colorImage.image = UIImage(systemName: "circle.fill")
        
        timeLabel.text = "ВРЕМЯ"
        timeLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        timeLabel.textColor = .black
        
        timeInstallLabel.text = "Каждый день в "
        timeInstallLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        timeInstallLabel.textColor = .black
        
        
        timeFromDatePikerLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        timeFromDatePikerLabel.textColor = .customPurple
        
        timePiker.datePickerMode = .time
        timePiker.preferredDatePickerStyle = .wheels
        timePiker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        timePiker.locale = Locale(identifier: "en_US")
        timePiker.backgroundColor = .white
        
        deleteButton.setTitle("Удалить привычку", for: .normal)
        deleteButton.setTitleColor(.systemRed, for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        deleteButton.addTarget(self, action: #selector(deletedHabit(_:)), for: .touchUpInside)

    }
   
    private func getTimeFromDatePiker(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        timeFromDatePikerLabel.text = formatter.string(from: date)
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    public func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        colorImage.tintColor = viewController.selectedColor
    }
}

extension HabitViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

