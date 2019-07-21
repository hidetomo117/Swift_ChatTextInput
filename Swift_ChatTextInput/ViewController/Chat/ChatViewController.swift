//
//  ViewController.swift
//  Swift_ChatTextInput
//
//  Created by hidetomo on 2019/07/19.
//  Copyright © 2019 Hidetomo Masuda. All rights reserved.
//

import UIKit

final class ChatViewController: UIViewController {

    var testView: EmojiView?
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUIView()
        
        /**
         大まかな機能
         ・したからコレクションビューがにゅっと出てくる
         ・テキストビューの大きさ変更
         ・テキストビューの入力内容に応じてメンション一覧を出したり、更新したり、非表示にしたり
        
         細かい制御機能
         ・入力に応じて文字の色を変更する
         ・エスケープ処理
         ・入力した文字列からHTMLを生成する
         */
        
    }
    
    private func createUIView() {
        
        let emojiView = EmojiView(frame: CGRect(x: 0 ,
                                                y: self.view.bounds.height,
                                                width: self.view.bounds.width,
                                                height: 100))
        
        testView = emojiView

        guard let test = testView else {
            return
        }
//        test.backgroundColor = UIColor.green

        self.view.addSubview(test)

    }
    
    private func show() {
        
        guard let test = testView else {
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            test.center.y -= test.frame.height
        })
    }
    
    private func hidden() {
        
        guard let test = testView else {
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            test.center.y += test.frame.height
        })
    }
    
    @IBAction func tapped(_ sender: Any) {
        
        if flag {
            hidden()
        } else {
            show()
        }
        flag = !flag
    }
    
    
    
    func addNotification() {
        
        let notification = NotificationCenter.default
        
        notification.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                 name: UIResponder.keyboardWillShowNotification, object: nil)
        
        notification.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                 name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification?) {
        
        guard let rect = (notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
                return
        }
        
        UIView.animate(withDuration: duration) {
            let transform = CGAffineTransform(translationX: 0, y: -(rect.size.height))
            self.view.transform = transform
        }
    }
    
    
    @objc
    func keyboardWillHide(_ notification: Notification?) {
        
        guard let duration = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? TimeInterval else {
            return
        }
        
        UIView.animate(withDuration: duration) {
            self.view.transform = CGAffineTransform.identity
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        if (self.textField.isFirstResponder) {
//            self.textField.resignFirstResponder()
//        }
    }
}

