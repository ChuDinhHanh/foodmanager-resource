//
//  ViewController.swift
//  FoodManagements2023
//
//  Created by CNTT on 4/20/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit
//auto-enable return key: de lam mow khi khong co du lieu
//Secure text entry: ma hoa mat khau: ******
//B1: Thuc hien protocol cua doi tuong TextField
class NewDetailController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var edtNewName: UITextField!
    @IBOutlet weak var imgMeal: UIImageView!
    //Dinh nghia navigationType
    enum NavigationType {
        case newMeal
        case editMeal
    }
    var meal:Meal?
    var navigationType: NavigationType = .newMeal
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    @IBOutlet weak var btnGoToMap: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Lay du lieu meal truyen sang tu tableViewController
        if let meal = meal{
            //Dien du lieu vao title va edtMealName
            navigationItem.title = meal.getName()
            edtNewName.text = meal.getName()
            //Dien du lieu anh
            imgMeal.image = meal.getImgMeal()
            //Dien du lieu ratingValue
            ratingControl.ratingValue = meal.getRatingValue()
        }
        
        //Cap nhat trang thai btnSave
        updateSaveState()
        
        // B3: Thuc hien viec uy quyen cho doi tuong TextField
        edtNewName.delegate = self
        
        btnGoToMap.clipsToBounds = true
        btnGoToMap.layer.cornerRadius = 6
        
    }
    //MARK: TextField 's Delegation Function
    //B2: Dinh nghia cacs ham uy quyen
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print("ShouldReturn called")
        //An ban phim
        edtNewName.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("DidEnditing called")
        navigationItem.title = edtNewName.text
        //Cap nhat trang thai btnSave
        updateSaveState()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnSave.isEnabled = false
    }
    //MARK: Image Processing 
    //Bat su kien cho doi tuong View
    //B1: Keo tha doi tuong resrure recognizer
    //B2:Ctr + drag
    //B3: Cho phep tuong tac nguoi dung: check Interaction: User interaction enable
    
    @IBAction func imageProcessing(_ sender: UITapGestureRecognizer) {
//        print("ImageProcessing call")
        //An ban phim va lay ket qua ten mon an
        edtNewName.resignFirstResponder()
        //Su dung doi tuong image Picker Controller de lay anh
        let imagePicker = UIImagePickerController()
        //Cau hinh cho image Picker Controller
        imagePicker.sourceType = .photoLibrary
        //B3: Thuc hien uy quyen cho doi tuong imagePicker
        imagePicker.delegate = self
        //Hien thi man hinh cua image picker controller
        present(imagePicker, animated: true, completion: nil)
    }
    
    //B2: Dinh nghia cac ham uy quyen cua doi tuong image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //Lay anh tu thu vien va dua vao imageView
        
        if let imageSelected = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgMeal.image = imageSelected
        }
        //quay ve man hinh truoc do
        dismiss(animated: true, completion: nil)
    }
    //MARK NAvigation
    //Cancel
    @IBAction func btnCancel(_ sender: UIBarButtonItem) {
        switch navigationType {
        case .newMeal:
            dismiss(animated: true, completion: nil)
        case .editMeal:
            if let navigationController = navigationController {
                navigationController.popViewController(animated: true)
            }
        }
    }
    
    //Chuyen man hinh thi ham prepare se duoc goi!
    // === so sanh hai doi tuong co la mot hay khong
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //xac dinh tac nhan chuyen man hinh
        if let btnSender = sender as? UIBarButtonItem {
            if btnSender === btnSave {
                let name = edtNewName.text ?? ""
                let imgMeal = self.imgMeal.image
                let ratingValue = ratingControl.ratingValue
                meal = Meal(name: name,  ratingValue: ratingValue, imgMeal: imgMeal)
                
            }
        }
        else{
            //Cac truong hop khong phai UIBaButtonItem
            print("Go to map")
        }
    }
    
    //MARK: Cap nhat trang thai btnSave
    private func updateSaveState(){
        let name = edtNewName.text ?? ""
        if !name.isEmpty {
            //Cho phep btnSave
            btnSave.isEnabled = true
        }
        else{
            //Khng cho phep btnSave
            btnSave.isEnabled = false
        }
    }
}


