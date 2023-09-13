//
//  UserViewController.swift
//  ejParking
//
//  Created by Javier Rodríguez Valentín on 06/10/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift



class UserViewController: UIViewController {
    
    var email = ""
    var db = Firestore.firestore()

    init(email:String){
        self.email = email
        super.init(nibName: "UserViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        //esta función te la pone Xcode al meter la función anterior del init
        fatalError("init(coder:) has not been implemented")
    }
   
    @IBOutlet var userView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var labelCarLicence: UILabel!
    @IBOutlet weak var labelMark: UILabel!
    @IBOutlet weak var labelModel: UILabel!
    @IBOutlet weak var labelColour: UILabel!
    
    @IBOutlet weak var inputCarLicence: UITextField!
    @IBOutlet weak var inputMark: UITextField!
    @IBOutlet weak var inputModel: UITextField!
    @IBOutlet weak var inputColour: UITextField!
    
    @IBOutlet weak var getBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var eraseBtn: UIButton!
    
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true //oculta el botón back
        navigationController?.isNavigationBarHidden = true //oculta la barra entera
        //navigationItem.setHidesBackButton(true, animated: true) //oculta el botón back
        
        userView.backgroundColor = .cyan
        
        titleLabel.text = "ejParking"
        titleLabel.textAlignment = .center
        titleLabel.font = titleLabel.font.withSize(30)
        
        labelCarLicence.text = "Matrícula"
        labelCarLicence.textAlignment = .center
        labelCarLicence.font = labelCarLicence.font.withSize(23)
        
        labelMark.text = "Marca"
        labelMark.textAlignment = .center
        labelMark.font = labelMark.font.withSize(23)
        
        labelModel.text = "Matrícula"
        labelModel.textAlignment = .center
        labelModel.font = labelCarLicence.font.withSize(23)
        
        labelModel.text = "Marca"
        labelModel.textAlignment = .center
        labelModel.font = labelModel.font.withSize(23)
        
        labelColour.text = "Color"
        labelColour.textAlignment = .center
        labelColour.font = labelModel.font.withSize(23)
        
        inputCarLicence.attributedPlaceholder = NSAttributedString(string: "Matrícula del coche", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        inputCarLicence.font = UIFont.systemFont(ofSize: 23)
        inputCarLicence.spellCheckingType = UITextSpellCheckingType.no//para que no cambie palabras de forma automáticamente
        
        
        inputMark.attributedPlaceholder = NSAttributedString(string: "Marca del coche", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        inputMark.font = UIFont.systemFont(ofSize: 23)
        inputMark.spellCheckingType = UITextSpellCheckingType.no
        
        inputModel.attributedPlaceholder = NSAttributedString(string: "Modelo del coche", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        inputModel.font = UIFont.systemFont(ofSize: 23)
        inputModel.spellCheckingType = UITextSpellCheckingType.no
        
        inputColour.attributedPlaceholder = NSAttributedString(string: "Color del coche", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        inputColour.font = UIFont.systemFont(ofSize: 23)
        inputColour.spellCheckingType = UITextSpellCheckingType.no
        
        saveBtn.setTitle("Guardar datos", for: .normal)
        saveBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        saveBtn.tintColor = .white
        saveBtn.layer.cornerRadius = 12
        saveBtn.backgroundColor = UIColor(red: 98/255, green: 128/255, blue: 18/255, alpha: 1)
        saveBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        saveBtn.titleLabel?.textAlignment = .center
        
        
        getBtn.setTitle("Obtener datos", for: .normal)
        getBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        getBtn.tintColor = .white
        getBtn.layer.cornerRadius = 12
        getBtn.backgroundColor = UIColor(red: 98/255, green: 128/255, blue: 18/255, alpha: 1)
        getBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        getBtn.titleLabel?.textAlignment = .center
        
        eraseBtn.setTitle("Borrar datos", for: .normal)
        eraseBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        eraseBtn.tintColor = .white
        eraseBtn.layer.cornerRadius = 12
        eraseBtn.backgroundColor = UIColor(red: 213/255, green: 143/255, blue: 0/255, alpha: 1)
        eraseBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        
        logoutBtn.setTitle("LOGOUT", for: .normal)
        logoutBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        logoutBtn.tintColor = .white
        logoutBtn.layer.cornerRadius = 12
        logoutBtn.backgroundColor = UIColor(red: 213/255, green: 143/255, blue: 0/255, alpha: 1)
        logoutBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        
        deleteBtn.setTitle("BORRAR CUENTA", for: .normal)
        deleteBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        deleteBtn.tintColor = .white
        deleteBtn.layer.cornerRadius = 12
        deleteBtn.backgroundColor = UIColor(red: 255/255, green: 34/255, blue: 0/255, alpha: 1)
        deleteBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        
    }
    
    //MARK: touchesBegan()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: getBtnAc
    @IBAction func getBtnAc(_ sender: Any) {
        self.view.endEditing(true) //para hacer desaparecer el teclado
        db.collection("usuarios").document(email).getDocument { (capture, error) in
            
            if let document = capture , error == nil{
                
                if let carLicense = document.get("matricula") as? String{
                    self.inputCarLicence.text = carLicense
                }else{
                    self.inputCarLicence.text = ""
                }
                
                if let mark = document.get("marca") as? String{
                    self.inputMark.text = mark
                }else{
                    self.inputMark.text = ""
                }
                
                if let model = document.get("modelo") as? String{
                    self.inputModel.text = model
                }else{
                    self.inputModel.text = ""
                }
                
                if let colour = document.get("color") as? String{
                    self.inputColour.text = colour
                }else{
                    self.inputColour.text = ""
                }
                
                if ((document.get("matricula") as? String) == nil) && ((document.get("marca") as? String) == nil) && ((document.get("modelo") as? String) == nil)
                && ((document.get("color") as? String) == nil){
                    self.alert(titulo: "Modificar datos", msg: "Sin datos para mostrar")
                }
                
            }
        }
    }
    
    //MARK: saveBtnAc
    @IBAction func saveBtnAc(_ sender: Any) {
        self.view.endEditing(true) //para hacer desaparecer el teclado
        var a = [0,0,0,0]
        
        if inputCarLicence.text! == ""{
            a [0] = 1
        }
        
        if inputMark.text! == ""{
            a [1] = 1
        }
        
        if inputModel.text! == ""{
            a [2] = 1
        }
        
        if inputColour.text! == ""{
            a [3] = 1
        }
        //print(a)
        save(a: a)
    }
    
    //MARK: eraseBtnAc
    @IBAction func eraseBtnAc(_ sender: Any) {
        self.view.endEditing(true) //para hacer desaparecer el teclado
        db.collection("usuarios").document(email).delete()
        alert(titulo: "Borrar datos", msg: "Datos borrados")
        self.inputCarLicence.text = ""
        self.inputMark.text = ""
        self.inputModel.text = ""
        self.inputColour.text = ""
        //borra solo un campo
        //db.collection("usuarios").document(email).updateData(["dieccion" : FieldValue.delete()])
    }
    
    //MARK: logoutBtnAc
    @IBAction func logoutBtnAc(_ sender: Any) {
        logout()
    }
    
    //MARK: deleteBtnAc
    @IBAction func deleteBtnAc(_ sender: Any) {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                // An error happened.
                print("Error al eliminar la cuenta. Error: \(error)")
            } else {
                // Account deleted.
                self.alert(titulo: "Eliminar cuenta", msg: "Cuenta eliminada")
                self.logout()
            }
        }
    }
    
    
    //MARK: logout()
    func logout(){
        do {
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Error. No se ha podido desloguear")
        }
       
    }
    
    
    //MARK: alert()
    func alert(titulo: String, msg:String){
        
        //print("exito")
        let alert = UIAlertController(title: titulo, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        present(alert, animated: true, completion: {/*Para poner el temporizador, se puede poner nil*/ Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: {_ in
            self.dismiss(animated: true, completion: nil)
        })})
        
    }
    
    //MARK: save(a)
    func save(a: [Int]){
        
        var text = ""
        
        if a[0] == 1 && a[1] == 1 && a[2] == 1 && a[3] == 1 {
            alert(titulo: "Guardar datos", msg: "Escriba algún campo a guardar")
        }else{
            
            var b:[String:String] = [:]
            text = "Se han guardado correctamente los campos: \n"
            
            if a[0] == 0 {
                text += "Matrícula\n"
                //db.collection("usuarios").document(email).setData([ "matricula": inputCarLicence.text!], merge: true)
                b["matricula"] = inputCarLicence.text
                inputCarLicence.text = ""
            }
            
            if a[1] == 0{
                text += "Marca\n"
               //db.collection("usuarios").document(email).setData([ "marca": inputMark.text!], merge: true)
                b["marca"] = inputMark.text
                inputMark.text = ""
            }
            
            if a[2] == 0{
                text += "Modelo\n"
                ///db.collection("usuarios").document(email).setData([ "modelo": inputModel.text!], merge: true)
                b["modelo"] = inputModel.text
                inputModel.text = ""
            }
            
            if a[3] == 0{
                text += "Color\n"
                //db.collection("usuarios").document(email).setData([ "color": inputColour.text!], merge: true)
                b["color"] = inputColour.text
                inputColour.text = ""
            }
            
            //si tenemos muchos parámetros a introducir es mejor hacerlo con un bucle que guardarlos uno a uno por eso en la funcíon en los condicionales if hay código comentado porque lo tenía para guardarlo uno por uno
            for (key, value) in b {
            db.collection("usuarios").document(email).setData([key:value], merge: true)
                //print(key + "-" + value)
            }
            
             /* //para hacerlo con diccionarios y reducir codigo con un bucle -> ya lo tengo de esta manera
             var b:[String:String] = [:]
             b.["matrícula"] = inputCarLicense.text!
             ...
             for (key, value) in b {
             db.collection("usuarios").document(email).setData([key:value], merge: true)
             value = ""
             }
             */
            
        }
        
        alert(titulo: "Guardar datos", msg: text)
        
    }
    
}
