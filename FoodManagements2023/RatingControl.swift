//
//  RatingControl.swift
//  FoodManagements2023
//
//  Created by CNTT on 4/27/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    //@IBDesignable: hien thi len giao dien khi thiet ke
    //MARK: Properties
    private var buttons = [UIButton]()
    @IBInspectable public var ratingValue:Int = 3 {
        didSet {
            updateStates()
        }
    }
    
    @IBInspectable private var buttonCount:Int = 5 {
        didSet {
            setupRatingControl()
        }
    }
    @IBInspectable private var buttonSize:CGSize = CGSize(width: 44.0, height: 44.0){
        didSet{
            setupRatingControl()
        }
    }
    //MARK: Dinh nghia contructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRatingControl()
    }
    
    required init(coder: NSCoder) {
       super.init(coder: coder)
        setupRatingControl()
    }
    
    //MARK: Ham xay dung doi tuong ratingControl
    private func setupRatingControl(){
        //Xoa button cu
        for button in buttons {
            button.removeFromSuperview()
            removeArrangedSubview(button)
        }
        buttons.removeAll()
        
        //Load anh cho cac button
        //Load anh tuong minh
        let bundle = Bundle(for: type(of: self))
        let normal = UIImage(named: "normal", in: bundle, compatibleWith: self.traitCollection)
        let selected = UIImage(named: "selected", in: bundle, compatibleWith: self.traitCollection)
        let pressed = UIImage(named: "pressed", in: bundle, compatibleWith: self.traitCollection)
        //Tao button moi
        for _ in 0..<buttonCount {
            //Tao 1 button cho RatingControl
            let btnRating = UIButton()
            //Cau hinh cho btnRating
            //btnRating.backgroundColor = UIColor.red
            btnRating.setImage(normal, for: .normal)
            btnRating.setImage(selected, for: .selected)
            btnRating.setImage(pressed, for: .highlighted)
            btnRating.setImage(pressed, for: [.selected, .highlighted])
            
            btnRating.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = false
            btnRating.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = false
            //Bat su kien cho btnRating
            btnRating.addTarget(self, action: #selector(btnRatingEventProcessing(button:)), for: .touchUpInside)
            //Dua btnRating vao trong RatingControl(StackView)
            addArrangedSubview(btnRating)
            // Dua btnRating vao trong mang buttons de quan ly
            //Cach 1:
            buttons += [btnRating]
            //Cach 2:
            //buttons.append(btnRating)
        }
        //Cap nhat trang that btnRating
        updateStates()
    }
    //Ham xu ly su kien cho btnRating
    @objc private func btnRatingEventProcessing(button: UIButton){
        let index = buttons.firstIndex(of: button)
        if index! + 1 != ratingValue {
            ratingValue = index! + 1
        }else{
            ratingValue -= 1
        }
        
        //Cap nhat lai trang thai cho btnRating
        updateStates()
    }
    //Ham cap nhat trang thai raing button
    private func updateStates(){
        for (index, button) in buttons.enumerated(){
            button.isSelected = (index + 1) <= ratingValue
        }
    }
}
