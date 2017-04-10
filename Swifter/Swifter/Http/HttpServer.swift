//
//  HttpServer.swift
//  SwiftDemo
//
//  Created by QianTuFD on 2017/2/7.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

import SWXMLHash

class HttpServer {
    
}

enum UserLoginChannel {
    case phoneNumber
    case weiChat
    case qq
    case sina
}

enum HttpType: String{
    case login = "199002.tran7"
    case signUp = "199001.tran7"
    case b
    case c
}

// MARK: - http post
extension HttpServer {
    class func post(httpType: HttpType, parameters: [String: Any]? = nil, success: @escaping (String) -> (), failure: @escaping (Error) -> ()) {
        let urlString = "http://121.201.39.135:22124/mpay/" + httpType.rawValue
        HttpTool.post(urlString: urlString, parameters: parameters, success: {
            success($0)
        }, failure: {
            failure($0)
        })
    }
}




// MARK: - 用户登录
extension HttpServer {
    class func login(phoneNumber: String, password: String, isLogin: Bool, loginChannel: UserLoginChannel, completionHandler: @escaping (_ success: LoginModel?, _ failure: Error?) -> ()) {
        // 参数处理
        let parameters = [
            "CURVERSION": "2.6.2",
            "TRANCODE": "199002",
            "PASSWORD": "123456",
            "CLIENTTYPE": "2",
            "PCSIM": "11111111",
            "JPALIAS": "",
            "IOSVERSION": "10.1",
            "JPTAG": "",
            "PHONENUMBER": "18888888888",
            "APPTYP": "2",
            "JPREGISTRATIONID": "18888888888",
            "OEMID": "IOS_bbbaopay_1.0.0",
            ]
    
        HttpServer.post(httpType: .login, parameters: parameters, success: {
            completionHandler(LoginModel($0), nil)
        }, failure: {
            completionHandler(nil, $0)
        })
        
    }
}


// MARK: - 用户注册
extension HttpServer {
    class func signUp(phoneNumber: String, password: String, promotionCode: String, actCode: String, SMSCode: String, wechatFlag: Bool, completionHandler: @escaping (_ success: SignUpModel?, _ failure: Error?) -> ()) {
        // 参数处理

        let parameters = [
            "":""
            ]
        
        HttpServer.post(httpType: .signUp, parameters: parameters, success: {
            completionHandler(SignUpModel($0), nil)
        }, failure: {
            completionHandler(nil, $0)
        })
    }
}

