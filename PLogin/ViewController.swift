//
//  ViewController.swift
//  PLogin
//
//  Created by os on 2019/9/2.
//  Copyright © 2019 os. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var loginBackView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        loginBackView = UIView(frame: CGRect(x: 0, y: 0, width: 500, height:self.view.frame.size.height - 400))
        loginBackView?.center = self.view.center
//        loginBackView?.backgroundColor = UIColor.lightGray
        self.view.addSubview(loginBackView)
        
        
        let userNameFieldView = setupChildTextField(frame:  CGRect(x: 10, y: 10, width: 480, height: 50), placeholder: "请输入用户名", leftImage: "userName",action: #selector(didChangeUserNameFieldAction(textField:)))
        loginBackView.addSubview(userNameFieldView)
        
        let passwordFieldView = setupChildTextField(frame:  CGRect(x: 10, y: userNameFieldView.y + userNameFieldView.height + 50, width: 480, height: 50), placeholder: "请输入密码", leftImage: "password",action: #selector(didChangePasswordFieldAction(textField:)))
        let passwordField = passwordFieldView.subviews[0] as! UITextField
        passwordField.isSecureTextEntry = true
        loginBackView.addSubview(passwordFieldView)
        
        let loginButton = UIButton(type: .custom)
        loginButton.frame = CGRect(x: 0, y: passwordFieldView.y + passwordFieldView.height + 100, width: passwordField.width + 20, height: 50)
        loginButton.setTitle("登录", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        loginButton.backgroundColor = UIColor.orange
        loginButton.layer.cornerRadius = 25
        loginButton.addTarget(self, action: #selector(loginButtonClick(button:)), for: .touchUpInside)
        loginBackView.addSubview(loginButton)
        KeyBoderHandleTool.getSharedKeyBoderTool().handleKeyBoderAction(handleView: loginBackView, offsetY: nil)
        
    }
    
    func setupChildTextField(frame:CGRect,placeholder:String,leftImage:String,action: Selector)->UIView{
        let backView = UIView(frame: frame)
        
        let imageLeft = UIImageView(frame: CGRect(x: -30, y: 0, width: 32, height: 32))
        imageLeft.image = UIImage(named: leftImage)
        
        let textField = PTextField(frame:backView.bounds)
        let placeholserAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]
        
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,attributes: placeholserAttributes)
        textField.textColor = UIColor.white
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.leftView = imageLeft
        textField.leftViewMode = .always
        textField.contentVerticalAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.addTarget(self, action:action, for: .editingChanged)
        backView.addSubview(textField)
        
        let lineView = UIView(frame: CGRect(x: textField.x, y: textField.y+textField.height + 10, width: textField.width, height: 1))
        lineView.backgroundColor = UIColor.white
        backView.addSubview(lineView)
        
        return backView
    }
    
    //用户名
    @objc func didChangeUserNameFieldAction(textField:UITextField){
        print("userName：",textField.text!)
    }
    
    //密码
    @objc func didChangePasswordFieldAction(textField:UITextField){
        print("password：",textField.text!)
    }
    
    //登录
    @objc func loginButtonClick(button:UIButton){
        print("登录")
//        realmTest()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func realmTest(){
        var dataArr = [Person]()
        //增
        for i in 1...10{
            let person = Person()
            person.id = i
            person.name = "小夏\(i)"
            person.age = 25 + i
            dataArr.append(person)
            //增
//            RealmManager.shared.add(person)
        }
        
        //查
//        let result = RealmManager.shared.query(Person(), filter: "id=3")
//        print("查：\(result)")
        
        //删除一条信息
//        RealmManager.shared.delete(result.first)
        
        //删除整张表信息
//        RealmManager.shared.deleteList(Person())
        
        //改
        let person = Person()
        person.id = 3
        person.name = "小红"
        person.age = 22
        RealmManager.shared.update(person)
    }
 
}

