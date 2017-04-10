//
//  User.swift
//  SwiftDemo
//
//  Created by QianTuFD on 2017/2/7.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class User {
    
    var loginMessage: String?
    var uid: String?
    var agentIdentifier: String?
    var phoneNumber: String?
    var feeRate: String?
    var noCardFeeRate: String?
    var agentStatus: String?
    var merchantStatus: String?
    var reviewStatus: String?
    var needCreatePaymentPassword: String?
    var needLoginOneMoreTime: String?
    var hadRecharge: String?
    var idCardReviewPassed: String?
    var scenePhotoReviewPassed: String?
    var isAreaAgent: String?
    var isSuperMember: String?
    var isretailers: String?
    var isgeneralagent: String?
    var issaleagt: String?
    var personpic: String?
    var lOEMID: String?

    static let shareInstance: User = {
        let users = User()
        return users
    }()
}


