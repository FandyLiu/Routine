//
//  LoginModel.swift
//  SwiftDemo
//
//  Created by QianTuFD on 2017/2/7.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

import SWXMLHash

struct LoginModel {
    var RSPCOD: String = ""
    var RSPMSG: String = ""
    var ACTCARD: String = ""
    var PAYCODE: String = ""
    var CURROL: String = ""
    var AGENTID: String = ""
    var PHONENUMBER: String = ""
    var MERSTS: String = ""
    var LOGNUM: String = ""
    var MERCNUM: String = ""
    var STS: String = ""
    var NOCARDFEERATE: String = ""
    var TXNSTS: String = ""
    var IDCARDPICSTA: String = ""
    var CUSTPICSTA: String = ""
    var FRYHKIMGPATHSTA: String = ""
    var OEMFEERATE: String = ""
    var ISSENIORMEMBER: String = ""
    var ISSALEAGT: String = ""
    var ISRETAILERS: String = ""
    var ISGENERALAGENT: String = ""
    var LOEMID: String = ""
    var PERSONPIC: String = ""
    var ISBRUSHOTHERSCARD: String = ""
    var NOTICEMESSAGE: String = ""
    var ISAREAAGENT: String = ""
    var OPENID: String = ""
    var UNIONID: String = ""
}

extension LoginModel {
    init(_ xmlString: String) {
        let xml = SWXMLHash.config({ (config) in
            config.shouldProcessLazily = true
        }).parse(xmlString)
        for elem in xml["EPOSPROTOCOL"] {
            RSPCOD = elem["RSPCOD"].element?.text ?? ""
            RSPMSG = elem["RSPMSG"].element?.text ?? ""
            ACTCARD = elem["ACTCARD"].element?.text ?? ""
            PAYCODE = elem["PAYCODE"].element?.text ?? ""
            CURROL = elem["CURROL"].element?.text ?? ""
            AGENTID = elem["AGENTID"].element?.text ?? ""
            PHONENUMBER = elem["PHONENUMBER"].element?.text ?? ""
            MERSTS = elem["MERSTS"].element?.text ?? ""
            LOGNUM = elem["LOGNUM"].element?.text ?? ""
            MERCNUM = elem["MERCNUM"].element?.text ?? ""
            STS = elem["STS"].element?.text ?? ""
            NOCARDFEERATE = elem["NOCARDFEERATE"].element?.text ?? ""
            TXNSTS = elem["TXNSTS"].element?.text ?? ""
            IDCARDPICSTA = elem["IDCARDPICSTA"].element?.text ?? ""
            CUSTPICSTA = elem["CUSTPICSTA"].element?.text ?? ""
            FRYHKIMGPATHSTA = elem["FRYHKIMGPATHSTA"].element?.text ?? ""
            OEMFEERATE = elem["OEMFEERATE"].element?.text ?? ""
            ISSENIORMEMBER = elem["ISSENIORMEMBER"].element?.text ?? ""
            ISSALEAGT = elem["ISSALEAGT"].element?.text ?? ""
            ISRETAILERS = elem["ISRETAILERS"].element?.text ?? ""
            ISGENERALAGENT = elem["ISGENERALAGENT"].element?.text ?? ""
            LOEMID = elem["LOEMID"].element?.text ?? ""
            PERSONPIC = elem["PERSONPIC"].element?.text ?? ""
            ISBRUSHOTHERSCARD = elem["ISBRUSHOTHERSCARD"].element?.text ?? ""
            NOTICEMESSAGE = elem["NOTICEMESSAGE"].element?.text ?? ""
            ISAREAAGENT = elem["ISAREAAGENT"].element?.text ?? ""
            OPENID = elem["OPENID"].element?.text ?? ""
            UNIONID = elem["UNIONID"].element?.text ?? ""
        }
    }
}







