//
//  Reusable.swift
//  MyHabits
//
//  Created by Yuliya Vodneva on 14.03.24.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

extension UICollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
