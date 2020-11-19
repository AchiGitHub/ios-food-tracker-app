//
//  Meal.swift
//  FoodAppRedesign
//
//  Created by Achintha Ikiriwatte on 11/19/20.
//

import UIKit

class Meal {
    var name: String
    var photo: UIImage?

    init?(name: String, photo: UIImage?) {
        
        if name.isEmpty {
            return nil
        }
        
        self.name = name
        self.photo = photo
    }
}
