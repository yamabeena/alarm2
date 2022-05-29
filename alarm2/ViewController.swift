//
//  ViewController.swift
//  alarm2
//
//  Created by 山邉瑛愛 on 2022/03/12.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, TestDelegate {
    
    //alartのサウンドファイルを読み込んで、プレイヤーを作る
    let alarmSoundPlayer = try!AVAudioPlayer(data: NSDataAsset(name: "alart")!.data)
    
    func test(data: Int) {
        
    }
    

    
    
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var setTimeLabel: UILabel!
        
    var player:AVAudioPlayer!
        var tempTime: String = "00:00"
        var setTime: String = "00:00"

    
        override func viewDidLoad() {
            super.viewDidLoad()
            
//            do {
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

    
    

