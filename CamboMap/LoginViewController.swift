//
//  LoginViewController.swift
//  CamboMap
//
//  Created by Yoman on 7/29/15.
//  Copyright (c) 2015 AlwayAtHome. All rights reserved.
//



class LoginViewController: YomanViewController {

    
    @IBOutlet var formView: UIView!
    @IBOutlet var txtId: UITextField!
    @IBOutlet var txtPassword: UITextField!
    

    
    //MARK: - View Life Cycle
    //MARK: --------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.navigationController?.navigationBarHidden  = true
        
        formView.layer.cornerRadius=45;
    }

    //MARK: - Move TextField Method
    //MARK: --------------------------------------------------
    func TextFieldMoveUp(move:Bool , txtfield:UITextField)  {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDuration(0.2)
        UIView.setAnimationBeginsFromCurrentState(true)
        
        var rect = self.view.frame
        if(move){
            rect.origin.y -= 60.0
        }else{
            rect.origin.y += 60.0
        }
        self.view.frame=rect
        UIView.commitAnimations()
    }
    func textFieldDidBeginEditing(textField: UITextField)   {
        if(textField == txtId){
            self.TextFieldMoveUp(true, txtfield: txtId)
        }else{
            self.TextFieldMoveUp(true, txtfield: txtPassword)
        }
    }
    func textFieldDidEndEditing(textField: UITextField)     {
        if(textField == txtId){
            self.TextFieldMoveUp(false, txtfield: txtId)
        }else{
            self.TextFieldMoveUp(false, txtfield: txtPassword)
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }

    //MARK: - Button Method Action
    //MARK: --------------------------------------------------
    
    @IBAction func BtnLogiAction(sender: UIButton) {
        
        
        
        
    }
    
    @IBAction func btnResgisterAction(sender: UIButton) {
        
        
        
    }
    @IBAction func btnBackAction(sender: UIButton) {
        self.navigationController?.navigationBarHidden  = false
        self.dismissViewControllerAnimated(false, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    
    
    }
}
