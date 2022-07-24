//
//  ViewController3.swift
//  alarm2
//
//  Created by 山邉瑛愛 on 2022/05/29.
//

import UIKit
import RealmSwift
import AVFoundation
class ViewController3: UIViewController, UITableViewDataSource {

    
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var setTimeLabel: UILabel!
        
    
    
    //Realmを宣言
    let realm = try! Realm()
    
    //StoryBoardで扱うTableViewを宣言
    @IBOutlet var table: UITableView!
    
    //アラームの時間を入れるための配列
    var timeArray = [String]()
    //メモを見れるようにする配列
    var memoArray = [String]()
    
    override func viewDidLoad(){
        super.viewDidLoad()

        let memo: Results<Memo>? = read()
        
        if memo!.count <= 0{
            memoArray.append("")
            timeArray.append("")
        }else{
        
        for i in  0...memo!.count {
            memoArray[i] = memo![i].memo
            timeArray[i] = memo![i].zikan
        }
        }
        
       
     //   do {
        //                try player = AVAudioPlayer("alart")
        //                //音楽をバッファに読み込んでおく
        //                player.prepareToPlay()
        //            } catch {
        //                print(error)
        //            }
        //
                  
                   
                    
                    // 時間管理してくれる
        _ = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(CustomCell.update), userInfo: nil, repeats: true)
                    
        
            //テーブルビューのデータソースメソッドはViewControllerクラスに書くよ、という設定
        table.dataSource = self
        
        
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
       // memoArray = ["","",""]
        //セルにメモを表示させる
        cell.memoLabel?.text = memoArray[indexPath.row]
        //セルに時間を表示させる
        cell.timeLabel?.text = timeArray[indexPath.row]
        
    
       
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        let memo: Results<Memo>? = read()
        for i in  0...memo!.count {
            memoArray[i] = memo![i].memo
            timeArray[i] = memo![i].zikan
        }
        table.reloadData()
    }
    
   
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
       
    
    
    
   
    func read() -> Results<Memo>?{
        return realm.objects(Memo.self)
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
    //実装した転移先のprotocolが呼ばれた時の処理
//    func register(data: String){
//       tempTime = (data)
//       print(data)  //5
//    }


}

//カスタムセルクラス
class CustomCell: UITableViewCell {
    
    var indexPath = IndexPath()
    var onoff:Bool = true
    var player:AVAudioPlayer!
    var tempTime: String = "00:00"
    var setTime: String = "00:00"
    let alarmSoundPlayer = try!AVAudioPlayer(data: NSDataAsset(name: "alart")!.data)
    
    func test(data: Int) {
        
    }

    
    @IBOutlet var onoffbutton: UIButton!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func onoffbuttonaction(){
        if onoff == true{
            onoffbutton.setTitle("OFF", for: .normal)
            onoff = false
            myButtonfunc()
        }else{
            onoff = true
            onoffbutton.setTitle("ON", for: .normal)
        }
            
    }
    
       func myButtonfunc() {
            // アラームをセット
            setTime = tempTime
            // 表示
            timeLabel.text = setTime
            
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
            
            // アラーム鳴らすか判断
            myAlarm(str: str)
        }
        
        func myAlarm(str: String) {
            // 現在時刻が設定時刻と一緒なら
            if str == setTime{
                ViewController3().alert()
                
                //alartの音を巻き戻す
                alarmSoundPlayer.currentTime = 0
                //alartの音を再生する
                alarmSoundPlayer.play()
            }
        }
        
        
  
    
    
}

