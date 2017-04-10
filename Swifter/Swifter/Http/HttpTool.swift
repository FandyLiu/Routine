//
//  HttpTool.swift
//  SwiftDemo
//
//  Created by QianTuFD on 2017/2/6.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit
import Alamofire



class HttpTool {
    
}


extension HttpTool {
    
    class func post(urlString: String, parameters: [String: Any]? = nil, success: @escaping (String) -> (), failure: @escaping (Error) -> ()) {
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseString { (response: DataResponse<String>) in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                failure(error)
            }
        }
    }

}
