//
//  ViewController3.swift
//  alarm2
//
//  Created by 山邉瑛愛 on 2022/05/29.
//

import UIKit

class ViewController3: UIViewController, UITableViewDataSource {

    var onoff:Bool = true
    
    //StoryBoardで扱うTableViewを宣言
    @IBOutlet var table: UITableView!
    @IBOutlet var onoffbutton: UIButton!
    
    //アラームの時間を入れるための配列
    var timeArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

            //テーブルビューのデータソースメソッドはViewControllerクラスに書くよ、という設定
        table.dataSource = self
        
        //timeArrayに時間を入れていく
        timeArray = ["","",""]
        // Do any additional setup after loading the view.
    }
    
    //セルの数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArray.count
    }
    
    //ID付きのセルを取得して、セル所属のtextLabelにテストと表示させてみる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = timeArray[indexPath.row]
        
        //セルにメモを表示させる
        //セルにオンオフのボタンを表示させる
        
        return cell!
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//カスタムセルクラス
class CustomCell: UITableViewCell {
    var indexPath = IndexPath()
    
    @IBAction func onoffbuttonaction(){
        if onoff == true{
            onoffbutton.setTitle("OFF", for: .normal)
            onoff = false
        }else{
            onoff = true
            onoffbutton.setTitle("ON", for: .normal)
        }
            
    }
}
