//
//  DatabasePlayer.swift
//  FoodManagements2023
//
//  Created by CNTT on 5/25/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import Foundation
import UIKit
import os.log
class DatabaseLayer{
    //MARK: Database's Properties
    private let DB_NAME = "meals.sqlite"
    private let DB_PATH:String?
    private let database:FMDatabase?
    
    //MARK: Table 's properties
    //1 Table meals
    private let MEAL_TABLE_NAME = "meals"
    private let MEAL_ID = "_id"
    private let MEAL_NAME = "_name"
    private let MEAL_RATING = "_rating"
    private let MEAL_IMAGE = "_image"
    
    //MARK: Contructors
    init() {
        //Lay dia chi thu muc can ghi database
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        //Khoi tao gia tri cho DB_PATH
        DB_PATH = directories[0] + "/" + DB_NAME
        //Khoi tao CSDL database
        database = FMDatabase(path: DB_PATH)
        //Thong bao su thanh cong khi khoi tao database
        if database  != nil {
            os_log("Khoi tao CSDL thanh cong")
            //Thuc hien tao cac bang du lieu
            let _ = tablesCreation()
        }
        else{
             os_log("Khong the khoi tao CSDL")
        }
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////
    //MARK: Dinh nghia cac ham prinities
    /////////////////////////////////////////////////////////////////////////////////////////////
    
    //1. Kiem tra su ton tai cua CSDL
    private func isDatabaseExist()->Bool{
        return (database != nil)
    }
    
    //2.Ham open CSDl
    private func open()->Bool{
        var ok = false
        if isDatabaseExist(){
            if database!.open(){
                ok = true
                os_log("Mo CSDl thanh cong")
            }
            else{
                os_log("Khong the mo CSDL")
            }
        }
        return ok
    }
    
    //3. Ham Dong CSDl
    private func close()->Bool{
        var ok = false
        if isDatabaseExist(){
            if database!.close(){
                ok = true
                os_log("Dong CSDl thanh cong")
            }
            else{
                os_log("Khong the dong CSDL")
            }
        }
        return ok
    }
    
    //4. Ham tao bang
    private func tablesCreation()->Bool{
        var ok = false
        if open(){
            //Xay dung cau lenh sql
            let sql = "CREATE TABLE \(MEAL_TABLE_NAME) ("
            + MEAL_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, "
            + MEAL_NAME + " TEXT, "
            + MEAL_RATING + " TEXT, "
            + MEAL_IMAGE + " TEXT)"
            //Thu thi cau lenh sql
            if database!.executeStatements(sql){
                ok = true
                os_log("Tao bang du lieu thanh cong")
            }
            else{
                os_log("Khong the tao bang du lieu")
            }
            let _ = close()
        }
        return ok
        
    }
    
    
    /////////////////////////////////////////////////////////////////////////////////////////////
    //MARK: Dinh nghia cac ham APIs
    /////////////////////////////////////////////////////////////////////////////////////////////
    
    //1. Ghi bien meal vao co so du lieu
    public func insert(meal:Meal)->Bool{
        var ok = false
        if open(){
            //Cau lenh sql
            let sql = "INSERT INTO \(MEAL_TABLE_NAME) (\(MEAL_NAME), \(MEAL_RATING), \(MEAL_IMAGE)) VALUES (?, ?, ?)"
            //Thuc thi cau lenh sql
            //B1. Chuyen doi anh thanh text
            var strImage = ""
            if let image = meal.getImgMeal(){
                //B1.1. Chuyen thanh NSData
                let dataImage = image.pngData()! as NSData
                //B1.2. Chuyen thanh text
                strImage = dataImage.base64EncodedString(options: .lineLength64Characters)
            }
            //B2. Ghi vao co so du lieu
            if database!.executeUpdate(sql, withArgumentsIn: [meal.getName(),meal.getRatingValue(),strImage]){
                ok = true 
                os_log("Meal duoc ghi thanh cong vao co so du lieu")
            }
            else{
                os_log("Khong the ghi bien meal vao co so du lieu")
            }
            let _ = close()
        }
        return ok
    }
    
    //2. Doc toan bo meal tu co so du lieu
    public func getAllMeals(meals: inout [Meal]){
        if open(){
            var result:FMResultSet?
            //Cau lenh sql
            let sql = "SELECT * FROM \(MEAL_TABLE_NAME) ORDER BY \(MEAL_RATING) DESC"
            //Bat exception
            do{
                //Thuc thi cau lenh sql
               result = try database!.executeQuery(sql, values: nil)
            }
            catch{
                os_log("Khong the doc meal tu co so du lieu")
            }
            
            //Xu ly doc du lieu tu database
            if let result = result{
                while (result.next()){
                    let name = result.string(forColumn: MEAL_NAME) ?? ""
                    let ratingValue = result.int(forColumn: MEAL_RATING)
                    var image:UIImage? = nil
                    if let strImage = result.string(forColumn: MEAL_IMAGE){
                        //Chuyen strImage thanh UIImage
                        //B1. CHuyen string thanh data
                        let dataImage = Data(base64Encoded: strImage, options: .ignoreUnknownCharacters)
                        //B2. Chuyen thanh UIImage
                        image = UIImage(data: dataImage!)
                    }
                    //Tao doi tuong meal
                    if let meal = Meal(name: name, ratingValue: Int(ratingValue), imgMeal: image){
                        //Luu vao tham bien meals
                        meals.append(meal)
                    }
                }
            }
            let _ = close()
        }
    }
}
