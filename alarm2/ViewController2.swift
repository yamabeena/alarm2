//
//  ViewController2.swift
//  alarm2
//
//  Created by 山邉瑛愛 on 2022/03/20.
//

import UIKit


protocol TestDelegate {
    func test(data: Int)
}

class ViewController2: UIViewController {

    // デリケートを作成
    var testDelegate:TestDelegate?
    
    @IBOutlet var myDPvar: UIDatePicker!
    var tempTime: String = "00:00"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // DatePickerのstyleをホイールにする
        myDPvar.preferredDatePickerStyle = .wheels
        
        
        // Do any additional setup after loading the view.
    }
    
    //ボタンを押したら５を転移先にもどす
   
    
    @IBAction func myDPfunc() {
        // DPの値を成形
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        // 一時的にDPの値を保持
        tempTime = format.string(from: myDPvar.date)
        
        // Delegate発火
        testDelegate?.register(data: tempTime)
        
        //転移先に戻る
        dismiss(animated: true, completion: nil)
    }
    //あいう
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
