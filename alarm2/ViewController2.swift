//
//  ViewController2.swift
//  alarm2
//
//  Created by 山邉瑛愛 on 2022/03/20.
//

import UIKit
import AVFAudio
import RealmSwift
import AVFoundation

protocol TestDelegate {
    func test(data: Int)
}

class ViewController2: UIViewController, UITextFieldDelegate{
    
    let realm = try! Realm()
    
    @IBOutlet var memoTextField: UITextField!
    
    //alartのサウンドファイルを読み込んで、プレイヤーを作る
    let alarmSoundPlayer = try! AVAudioPlayer(data: NSDataAsset(name: "alart")!.data)
    let alarm2SoundPlayer = try! AVAudioPlayer(data: NSDataAsset(name: "alart2mp3")!.data)
    let alarm3SoundPlayer = try! AVAudioPlayer(data: NSDataAsset(name: "alart3")!.data)

    
    // デリケートを作成
    var testDelegate:ViewController3?
   
    
    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
  
    
    @IBOutlet var myDPvar: UIDatePicker!
    var tempTime: String = "00:00"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let memo: Results<Memo>? = read()
       
        memoTextField.delegate = self
        
        // DatePickerのstyleをホイールにする
        myDPvar.preferredDatePickerStyle = .wheels
        
        
        // Do any additional setup after loading the view.
        
    }
    func read() -> Results<Memo>?{
        return realm.objects(Memo.self)
    }
//    //保存するためのパスを作る
//        func createLocalDataFile(){
//            //作成するテキストファイルの名前
//            let fileName = "\(NSUUID().uuidString).png"
//
//        }
                @IBAction func save() {
                    let memo: String = memoTextField.text!
                    let time: String = tempTime
                    
                    let newMemo = Memo()
                    newMemo.memo = memo
                    newMemo.zikan = time
                    //転移先に戻る
                    dismiss(animated: true, completion: nil)
                }
                @IBAction func myDPfunc(){
                    // DPの値を成形
                    let format = DateFormatter()
                    format.dateFormat = "HH:mm"
                    // 一時的にDPの値を保持
                    tempTime = format.string(from: myDPvar.date)
                    
                    // Delegate発火
                  //  testDelegate?.register(data: tempTime)
                    
                    
                }
                
                @IBAction func alartButton() {
                    //alartの音を再生する
                    alarmSoundPlayer.play()
                    Button.backgroundColor = UIColor(red: 170, green: 174, blue: 179, alpha: 68)
                }
                @IBAction func alar2tButton() {
                    //alartの音を再生する
                    alarm2SoundPlayer.play()
                    Button2.backgroundColor = UIColor.red
                    
                }
                func alart3Button() {
                    //alartの音を再生する
                    alarm3SoundPlayer.play()
                    Button3.backgroundColor = UIColor.red
                }
                @IBAction func stopbutton() {
                    alarmSoundPlayer.stop()
                    alarm2SoundPlayer.stop()
                    alarm3SoundPlayer.stop()
                    Button.backgroundColor = UIColor.clear
                    Button2.backgroundColor = UIColor.clear
                    Button3.backgroundColor = UIColor.clear
                    
                    
                }
        
            
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




