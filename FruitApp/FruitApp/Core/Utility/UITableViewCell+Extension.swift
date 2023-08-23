//
//  UITableViewCell+Extension.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//

import Foundation
import UIKit

protocol TableViewCellIdentifiable {
    static var cellIdentifier: String { get }
}

extension TableViewCellIdentifiable where Self: UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: TableViewCellIdentifiable {}
