//
//  Memo.swift
//  alarm2
//
//  Created by 山邉瑛愛 on 2022/06/12.
//

import UIKit
import Foundation
import RealmSwift

class Memo: Object {
    @objc dynamic var zikan: String = ""
    @objc dynamic var memo: String = ""
    @objc dynamic var oto: String = ""
}

struct MemoModel {
    let zikan: String
    let memo: String
    let oto: String
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


