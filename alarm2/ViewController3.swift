//
//  ViewController3.swift
//  alarm2
//
//  Created by 山邉瑛愛 on 2022/05/29.
//

import UIKit
import RealmSwift
import AVFoundation
class ViewController3: UIViewController, UITableViewDataSource, TestDelegate {

    
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var setTimeLabel: UILabel!
        
    var player:AVAudioPlayer!
        var tempTime: String = "00:00"
        var setTime: String = "00:00"

    
    
    //Realmを宣言
    let realm = try! Realm()
    
    //StoryBoardで扱うTableViewを宣言
    @IBOutlet var table: UITableView!
    
    //アラームの時間を入れるための配列
    var timeArray = [String]()
    //メモを見れるようにする配列
    var memoArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

     //   do {
        //                try player = AVAudioPlayer("alart")
        //                //音楽をバッファに読み込んでおく
        //                player.prepareToPlay()
        //            } catch {
        //                print(error)
        //            }
        //
                  
                    // 起動した時点の時刻をmyLabelに反映
                    myLabel.text = "現在時刻: " + getNowTime()
                    setTimeLabel.text = "設定時刻: " + getNowTime()
                    // 時間管理してくれる
                    _ = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(update), userInfo: nil, repeats: true)
                    
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")as!CustomCell
        
        
        //memoArrayに時間を入れていく
        memoArray = ["","",""]
        //セルにメモを表示させる
        cell.memoLabel?.text = memoArray[indexPath.row]
        //セルに時間を表示させる
        cell.timeLabel?.text = timeArray[indexPath.row]
        
        return cell
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    let alarmSoundPlayer = try!AVAudioPlayer(data: NSDataAsset(name: "alart")!.data)
    
    func test(data: Int) {
        
    }

       
    
    //ボタンクリック時に画面転移する
    @IBAction func alarmButton(_ sender: Any) {
        performSegue(withIdentifier: "a", sender: nil)
    }
        //転移先の処理を記述
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "a"{
            //転移先のNextViewControllerクラスを取得
            let nextVC = segue.destination as! ViewController2
            // protocolを紐づける
            nextVC.testDelegate = self
    }
    }
    
    //実装した転移先のprotocolが呼ばれた時の処理
    func register(data: String){
       tempTime = (data)
       print(data)  //5
    }
        @IBAction func myButtonfunc() {
            // アラームをセット
            setTime = tempTime
            // 表示
            setTimeLabel.text = "設定時刻: " + setTime
            
        }

        func getNowTime()-> String {
            // 現在時刻を取得
            let nowTime: NSDate = NSDate()
            // 成形する
            let format = DateFormatter()
            format.dateFormat = "HH:mm"
            let nowTimeStr = format.string(from: nowTime as Date)
            // 成形した時刻を文字列として返す
            return nowTimeStr
        }
        
        @objc func update() {
            // 現在時刻を取得
            let str = getNowTime()
            // myLabelに反映
            myLabel.text = "現在時刻: " + str
            // アラーム鳴らすか判断
            myAlarm(str: str)
        }
        
        func myAlarm(str: String) {
            // 現在時刻が設定時刻と一緒なら
            if str == setTime{
                alert()
                
                //alartの音を巻き戻す
                alarmSoundPlayer.currentTime = 0
                //alartの音を再生する
                alarmSoundPlayer.play()
            }
        }
        
        // アラートの表示
        func alert() {
            let path = URL(fileURLWithPath: Bundle.main.path(forResource: "alart",ofType:"mp3")!)
            let audioPlayer = try! AVAudioPlayer(contentsOf:path)
            audioPlayer.play()
            
            let myAlert = UIAlertController(title: "アラーム", message: "", preferredStyle: .alert)
            let myAction = UIAlertAction(title: "OK", style: .default) {
                action in print("foo!!")
            }
            myAlert.addAction(myAction)
            present(myAlert, animated: true, completion: nil)
        }

}

//カスタムセルクラス
class CustomCell: UITableViewCell {
    
    var indexPath = IndexPath()
    var onoff:Bool = true
    
    @IBOutlet var onoffbutton: UIButton!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
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

