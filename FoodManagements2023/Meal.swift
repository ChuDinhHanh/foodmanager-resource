//
//  Meal.swift
//  FoodManagements2023
//
//  Created by CNTT on 5/4/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit
class Meal {
    //MARK: Properties
    private var name:String
    private var ratingValue:Int
    private var imgMeal:UIImage?
    
    //MARK: Contructors
    init?(name:String, ratingValue:Int, imgMeal:UIImage?) {
        if name.isEmpty {
            return nil
        }
        if ratingValue < 0 || ratingValue > 5{
            return nil
        }
        //Dua gia tri vao bien thanh phan cua doi tuong
        self.name = name
        self.ratingValue = ratingValue
        self.imgMeal = imgMeal
    }
    
    //Getter and setter
    public func getName()->String{
        return name
    }
    
    public func getRatingValue()->Int{
        return ratingValue
    }
    
    public func getImgMeal()->UIImage?{
        return imgMeal
    }
}
