//
//  YLSqlLiteManager.swift
//  LearnRealm
//
//  Created by 谭林杰 on 2019/1/31.
//  Copyright © 2019 Bksx-cp. All rights reserved.
//

import UIKit
import FMDB

class YLSqlLiteManager: NSObject {
    
    // 单例
    private static let manager:YLSqlLiteManager = YLSqlLiteManager()
    
    class func shareManager() -> YLSqlLiteManager {
        return manager
    }
    
    var db:FMDatabase? //创建
    let lock = NSLock()
    
    /// 获取默认fmdb。sqlite
    ///
    /// - Returns: s数据路
    func getDBWithDataBaseName() -> FMDatabase {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = path + "fmdb.sqlite"
        let fmdb = FMDatabase(path: dbPath)
        db = fmdb
        return db!
    }

    /// 获取自定义名称数据库
    ///
    /// - Parameter databaseName: 数据库名称
    /// - Returns: 数据路
    func getDBWithDataBaseName(dbName databaseName:String) -> FMDatabase {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = path + "/\(databaseName).sqlite"
//        print("数据库地址:\(dbPath)")
//        let success = isOpenDataBase(db: FMDatabase.init(path: dbPath))
        return FMDatabase(path: dbPath)
    }
    
    /// 获取自定义地址数据库
    ///
    /// - Parameters:
    ///   - databaseName: 数据库名称
    ///   - dbPaths: 地址
    /// - Returns: 数据库
    func getDBWithDBNameAndDBPath(dbName databaseName:String, path dbPaths:String) -> FMDatabase {

        let dbPath = dbPaths + "/\(databaseName).sqlite"
        //        print("数据库地址:\(dbPath)")
        //        let success = isOpenDataBase(db: FMDatabase.init(path: dbPath))
        return FMDatabase(path: dbPath)
    }
    
    /// 数据库是否打开成功
    ///
    /// - Parameter FMDB: 数据库
    /// - Returns: 是否 lboll
    func isOpenDataBase(db FMDB:FMDatabase) -> Bool {
        if FMDB.open() {
//            print("数据库打开成功")
            return true
        } else {
            print("数据库打开失败")
            return false
        }
    }
    
    
    /// 查询指定数据库内指定表是否存在
    ///
    /// - Parameters:
    ///   - databaseName: 数据库名称
    ///   - tableName: 表名称
    /// - Returns: 是否 true or false
    func checkTableExist(dbName databaseName:String, tabName tableName:String ) -> Bool {
        let db = getDBWithDataBaseName(dbName: databaseName);
        let success = isOpenDataBase(db: db);
        if success {
            let contain = db.tableExists(tableName)
            if contain {
                print("数据库\(databaseName)中包含有\(tableName)表")
                return true
            } else {
                print("数据库\(databaseName)中不包含有\(tableName)表，请核对数据库及表名称！")
                return false
            }
            
        } else {
            print("数据库打开失败，查询失败！")
            return false
        }
        
    }
    
    
    
}

//MARK: -- 建立表
extension YLSqlLiteManager{

    /// 给指定数据库创建表
    ///
    /// - Parameters:
    ///   - databaseName: 数据库名称
    ///   - sqlString:
    func createTable(db databaseName:String, sql sqlString:String) -> Void {
        let db = getDBWithDataBaseName(dbName: databaseName)
        let success = isOpenDataBase(db: db)
        if success {
            let result = db.executeStatements(sqlString)
            result ? print("数据库\(databaseName)中创建表\(sqlString)成功！") : print("数据库\(databaseName)中创建表\(sqlString)失败！请检查sql语句")
        }
        db.close()
    }
    
    /// 指定数据库删除指定表
    ///
    /// - Parameters:
    ///   - databaseName:数据库
    ///   - tableName: 表名称
    func dropTable(db databaseName:String ,table tableName:String)->Void{
        let db = getDBWithDataBaseName(dbName: databaseName)
        let contains = checkTableExist(dbName: databaseName, tabName: tableName)
        if contains {
            let sql = "DROP TABLE" + tableName
            do{
                try db.executeUpdate(sql, values: nil)
            }catch{
                print(db.lastErrorMessage())
            }
            print("数据库中\(databaseName)中表\(tableName)删除成功")
        }else{
            print("数据库中\(databaseName)中表\(tableName)删除失败")
        }
    }
    
    /// 给指定数据库中表添加字段
    ///
    /// - Parameters:
    ///   - databaseName: 数据库
    ///   - tableName: 表
    ///   - fieldName: 字段名
    ///   - fieldType: 字段类型
    func addFieldForTable(db databaseName:String ,table tableName:String ,field fieldName:String ,type fieldType:String) -> Void {
        let db = getDBWithDataBaseName(dbName: databaseName)
        let contains = checkTableExist(dbName: databaseName, tabName: tableName)
        if contains {
            let sql = "ALTER TABLE" + tableName + "ADD" + fieldName + fieldType
            do {
                try db.executeUpdate(sql, values: nil)
            }catch {
                print(db.lastErrorMessage())
            }
            print("数据库中\(databaseName)中表\(tableName)添加字段\(fieldName)成功")
        } else {
            print("数据库中\(databaseName)中表\(tableName)添加字段\(fieldName)失败")
        }
    }
    
}


//MARK: -- 查
extension YLSqlLiteManager{

    
    /// 查询指定数据库表结果
    ///
    /// - Parameters:（是否需要指定表）
    ///   - databaseName: 数据库表
    ///   - sqlString: sql
    /// - Returns: 返回数组
    func selectDataByFMDB(db databaseName:String,table tableName:String, sql sqlString:String ) -> String {
        let db = getDBWithDataBaseName(dbName: databaseName)
        let contains = checkTableExist(dbName: databaseName, tabName: tableName)
        var resultArray = [AnyObject]()
        if contains {
            db.open()
            do {
                let rs = try db.executeQuery(sqlString, values: nil)
                print(rs.int(forColumnIndex: 1))
                while(rs.next()){
                    let count = rs.columnCount
                    var dic = [String:String]()
                    for i in 0..<count  {
                        let key = rs.columnName(for: i)
                        let value = rs.string(forColumnIndex: i)
                        dic[key!] = value
                    }
                    resultArray.append(dic as AnyObject)
                }
                let str = getJSONStringFromArray(array: resultArray as NSArray)
                print(str)
            }catch {
                print(db.lastErrorMessage())
                
            }
            
        }else {
           
        }
        db.close()
        return getJSONStringFromArray(array: resultArray as NSArray)
    }
    
    
    

}

//MARK: -- 增
extension YLSqlLiteManager{
    
    /// 插入数据到指定表 -- 传入sql 指定数据列
    ///
    /// - Parameters:
    ///   - databaseName: 数据库
    ///   - tableName: 表名称
    ///   - sqlString: sql语句
    ///   - values: 数值数组
    func insertDataToTable(db databaseName:String,table tableName:String, sql sqlString:String ,value values:Array<Any>)->Void{
        let db = getDBWithDataBaseName(dbName: databaseName)
        let contains = checkTableExist(dbName: databaseName, tabName: tableName)
        if contains {
            db.open()
            do {
                try db.executeUpdate(sqlString, values: values)
            }catch {
                print(db.lastErrorMessage())
            }
        }else {
            print("插入失败")
        }
        db.close()
    }
    
//    func insertDataToTable(db databaseName:String,table tableName:String ,value values:Array<Any>)->Void{
//        let db = getDBWithDataBaseName(dbName: databaseName)
//        let contains = checkTableExist(dbName: databaseName, tabName: tableName)
//        if contains {
//            do {
//                let sqlString = "INSERT INTO `\(tableName)` VALUES()"
//                let s = values as Array<Any>
//                array = array + values
//                let str = array.joined(separator:",")
//
//                try db.executeUpdate(sqlString, values: values)
//            }catch {
//                print(db.lastErrorMessage())
//            }
//        }else {
//            print("插入失败")
//        }
//
//    }

}

//MARK: -- 删
extension YLSqlLiteManager{
    
    /// 删除指定数据库表内数据 -- 多条件
    ///
    /// - Parameters:
    ///   - databaseName: 数据库
    ///   - tableName: 表名称
    ///   - sqlString: sql语句
    ///   - values: 数据
    func deleteDataFromTable(db databaseName:String,table tableName:String, sql sqlString:String ,value values:Array<Any>) -> Void {
        let db = getDBWithDataBaseName(dbName: databaseName)
        let contains = checkTableExist(dbName: databaseName, tabName: tableName)
        if contains {
            db.close()
            do {
                try db.executeUpdate(sqlString, values: values)
                print("删除成功")
            }catch {
                print(db.lastErrorMessage())
            }
        }else {
            print("删除失败")
        }
        db.close()
    }
    
    /// 删除指定数据库中表数据 -- 单条件
    ///
    /// - Parameters:
    ///   - databaseName: 数据库
    ///   - tableName: 表名
    ///   - key: 字段
    ///   - value: 数值
    func deleteDataFromTable(db databaseName:String,table tableName:String, ConditionK key:String ,ConditionsV value:String) -> Void {
        let db = getDBWithDataBaseName(dbName: databaseName)
        let contains = checkTableExist(dbName: databaseName, tabName: tableName)
        if contains {
            db.open()
            do {
                let sqlString = "DELETE FROM `\(tableName)` WHERE \(key) = \(value)"
                try db.executeUpdate(sqlString, values: nil)
                print("删除成功")
            }catch {
                print(db.lastErrorMessage())
            }
        }else {
            print("删除失败")
        }
        db.close()
    }
}

//MARK: -- 改
extension YLSqlLiteManager{
    
    /// 修改指定数据库数据表数据
    ///
    /// - Parameters:
    ///   - databaseName: 数据库
    ///   - tableName: 表名
    ///   - key: 字段
    ///   - value: 数值
    func modifyDataFromTable(db databaseName:String,table tableName:String, sql sqlString:String ,value values:Array<Any>) -> Void {
        let db = getDBWithDataBaseName(dbName: databaseName)
        let contains = checkTableExist(dbName: databaseName, tabName: tableName)
        if contains {
            db.open()
            do {
                try db.executeUpdate(sqlString, values: values)
                print("修改成功")
            }catch {
                print(db.lastErrorMessage())
            }
        }else {
            print("修改失败")
        }
        db.close()
    }
}

//MARK: -- COUNT
extension YLSqlLiteManager{

    /// 返回表
    ///
    /// - Parameters:
    ///   - databaseName: 数据库
    ///   - tableName: 表名称
    ///   - sqlString: sql
    func getCounFromTable(db databaseName:String,table tableName:String, sql sqlString:String ) -> Void{
        let db = getDBWithDataBaseName(dbName: databaseName)
        let contains = checkTableExist(dbName: databaseName, tabName: tableName)
        if contains {
            db.open()
            do {
                try db.executeUpdate(sqlString, values: nil)
                
                print("查询成功")
            }catch {
                print(db.lastErrorMessage())
            }
        }else {
            print("修改失败")
        }
        db.close()
    }
}

//MARK: -- 工具类
extension YLSqlLiteManager{
    /// 数组转json串
    ///
    /// - Parameter array: 数据
    /// - Returns: json
    func getJSONStringFromArray(array:NSArray) -> String {
        
        if (!JSONSerialization.isValidJSONObject(array)) {
            print("无法解析出JSONString")
            return ""
        }
        
        let data : NSData! = try? JSONSerialization.data(withJSONObject: array, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
    }
}

