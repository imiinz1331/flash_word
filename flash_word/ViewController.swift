//
//  ViewController.swift
//  flash_word
//
//  Created by 飯沼瑞稀 on 2021/07/05.
//  Copyright © 2021 mizuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // タイマー変数
    var timer  : Timer?
    // 経過時間の変数
    var count = 0
    //設定値を扱うキー
    let settingKey = "timer_value"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // UserDefaultsのインスタンスを生成
        let settings = UserDefaults.standard
        
        // UserDefaultsに初期値を登録
        settings.register(defaults : [settingKey:10])
    }
    
    func displayUpdate() -> Int {
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        let remainCount = timerValue - count
        TimeLabel.text = "残り\(remainCount)秒"
        return remainCount
    }
    
    @objc func timerInterrupt(_ timer:Timer){
        count += 1
        // 残り時間が0以下の時タイマーを止める
        if(displayUpdate()<=0){
            count = 0
            timer.invalidate()
            
            let alertController = UIAlertController(title: "タイムアップ", message: "一斉に回答をどうぞ！", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }

    @IBOutlet weak var NumberLabel: UILabel!
    
    
    @IBOutlet weak var CharLabel: UILabel!
    
    var Chars = ["あ", "い", "う", "え", "お", "か", "き", "く", "け", "こ", "さ", "し", "す", "せ", "そ", "た", "ち", "つ", "て", "と", "な", "に", "ぬ", "ね", "の", "は", "ひ", "ふ", "へ", "ほ", "ま", "み", "む", "め", "も", "や", "ゆ", "よ", "ら", "り", "る", "れ", "ろ", "わ"]
    
    @IBAction func DrawButton(_ sender: Any) {
        NumberLabel.text = String(Int.random(in: 2..<8))
        CharLabel.text = Chars[Int.random(in: 0..<44)]
        
        // タイマースタート
        if let nowtimer = timer {
            if nowtimer.isValid == true{
                return
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:  #selector(self.timerInterrupt(_:)), userInfo: nil, repeats: true)
    }
    
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBAction func settingButtonAction(_ sender: Any) {
        // 実行中なら停止
        if let nowTimer = timer {
            if nowTimer.isValid == true{
                nowTimer.invalidate()
            }
        }
        
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    
    // 画面切り替えで初期化
    override func viewDidAppear(_ animated: Bool) {
        count = 0
        _ = displayUpdate()
    }
    
    @IBAction func HowtoPlayAction(_ sender: Any) {
        performSegue(withIdentifier: "goHowtoPlay", sender: nil)
    }
    
}

