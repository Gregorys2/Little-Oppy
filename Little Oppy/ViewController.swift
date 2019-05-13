//
//  ViewController.swift
//  Lil' Oppy
//
//  Created by Gregory Paul Sim on 2019-04-24.
//  Copyright © 2019 Gregory Paul Sim. All rights reserved.
//

import UIKit
import Phidget22Swift

class ViewController: UIViewController {
    //global variables
    let rMotor = DCMotor()
    let lMotor = DCMotor()
    let stickY = VoltageRatioInput()
    let stickX = VoltageRatioInput()
    let frontSensor = DistanceSensor()
    let rightSensor = DistanceSensor()
    let leftSensor = DistanceSensor()
    var manualToggle : Bool = false
    var autoToggle : Bool = false
    var objDetected : Bool = false
    var leftDetected : Bool = false
    var rightDetected : Bool = false
    var frontDetected: Bool = false
    
    //attach handler
    
    func attachHandler(sender: Phidget) {
        do {
            if (try sender.getHubPort() == 0) {
                print("Right motor attached")
            } else if (try sender.getHubPort() == 1) {
                print("Left motor attached")
            } else if (try sender.getHubPort() == 2) {
                print("Front sensor attached")
            } else if (try sender.getHubPort() == 3) {
                print("Right sensor attached")
            } else if (try sender.getHubPort() == 4) {
                print("Left sensor attached")
            } else {
                print("Thumbstick calibrated")
            }
        } catch let err as PhidgetError {
            print("error 1 in attach")
            print(err)
        } catch {
            print("error 2 in attach")
            print(error)
        }
    }
    
    //THE VOLTAGE CHANGER! It takes two inputs, sender and voltageratio.
    func voltageChanger(sender: VoltageRatioInput, voltageRatio: Double) {
        do {
            //xvoltageratio is stick x's voltage
            let xVoltageRatio = try stickX.getVoltageRatio()
            //yvoltageratio is stick y's voltage
            let yVoltageRatio = try stickY.getVoltageRatio()
            //if xvoltage ratio is over 0.5...
            if (xVoltageRatio > 0.5) {
                //is an object detected?
                switch objDetected {
                case false:
                    //if no, turn right
                    try lMotor.setTargetVelocity(xVoltageRatio)
                    try rMotor.setTargetVelocity(-yVoltageRatio)
                default:
                    //if not, print car is backing up
                    print("car is backing up")
                }
                //if xvoltageratio is less than -0.5
            } else if (xVoltageRatio < -0.5) {
                //object detected?
                switch objDetected {
                case false:
                    //if no, turn left.
                    try lMotor.setTargetVelocity(yVoltageRatio)
                    try rMotor.setTargetVelocity(xVoltageRatio)
                default:
                    //if yes, tell the car its backing up
                    print("car is backing up")
                }
                
  
            } else {
                //if neither of the above
                //object detected?
                switch objDetected {
                    //if not
                case false:
                    //go straight
                    try lMotor.setTargetVelocity(yVoltageRatio)
                    try rMotor.setTargetVelocity(-yVoltageRatio)
                default:
                    //otherwise car is backing up
                    print("car is backing up")
                }
                
            }
        } catch let err as PhidgetError {
            print("error 1 in voltage")
            print(err)
        } catch {
            print("error 2 in voltage")
            print(error)
        }
    }
    //DISTANCE CHANGER! calls for two parameters, sender and distance
    func distChange(sender: DistanceSensor, distance: UInt32) {
        do {
            //distance is the distance between the sonar and nearest object
            let distance = try frontSensor.getDistance()
            //if distance is less than or equal to 80
            if(distance <= 80) {
                //change the objdetected variable to true
                objDetected = true
                //back the car up
                try lMotor.setTargetVelocity(-0.8)
                try rMotor.setTargetVelocity(0.8)
            } else {
                //otherwise objdetected is false
                objDetected = false
            }
        } catch let err as PhidgetError {
            print(err)
        } catch {
            print(error)
        }
    }
    
    func frontDistChange(sender: DistanceSensor, distance: UInt32) {
        do {
            //distance is the distance between the sonar and nearest object
            let distance = try frontSensor.getDistance()
            //if distance is less than or equal to 80
                if(distance<=300 && distance >= 81){
                    
                } else if(distance <= 80 ){
                    if(rightDetected && leftDetected == true){
                    try lMotor.setTargetVelocity(-1)
                    try rMotor.setTargetVelocity(1)
                } else if(rightDetected == true || leftDetected == false) {
                    try lMotor.setTargetVelocity(1)
                    try rMotor.setTargetVelocity(1)
                } else if(rightDetected == false || leftDetected == true){
                    try lMotor.setTargetVelocity(-1)
                    try rMotor.setTargetVelocity(-1)
                }
            } else {
                try lMotor.setTargetVelocity(1)
                try rMotor.setTargetVelocity(-1)
            }
            
        } catch let err as PhidgetError {
            print(err)
        } catch {
            print(error)
        }
    }
    
    func voltageToggleOn() {
        voltageToggleOff()
        let _ = frontSensor.distanceChange.addHandler(distChange)
        let _ = stickX.voltageRatioChange.addHandler(voltageChanger)
        let _ = stickY.voltageRatioChange.addHandler(voltageChanger)
    }
    
    func voltageToggleOff() {
        let _ = frontSensor.distanceChange.removeAllHandlers()
        let _ = stickX.voltageRatioChange.removeAllHandlers()
        let _ = stickY.voltageRatioChange.removeAllHandlers()
    }
    
    func nullifySpeed() {
        do {
            try lMotor.setTargetVelocity(0)
            try rMotor.setTargetVelocity(0)
        } catch let err as PhidgetError {
            print("error 1 in voltage toggle")
            print(err)
        } catch {
            print("error 2 in voltage toggle")
            print(error)
        }
    }
    
    func autoPilot() {
        let _ = frontSensor.distanceChange.addHandler(frontDistChange)
    }
    
    
    @IBAction func autoDrive(_ sender: Any) {
        switch autoToggle {
        case true:
            manualToggle = false
            autoToggle = false
            voltageToggleOff()
            nullifySpeed()
        default:
            manualToggle = false
            autoToggle = true
            voltageToggleOff()
            autoPilot()
        }
    }
    
    @IBAction func manDrive(_ sender: Any) {
        switch manualToggle{
        case true:
            manualToggle = false
            autoToggle = false
            voltageToggleOff()
            nullifySpeed()
        default:
            autoToggle = false
            manualToggle = true
            voltageToggleOff()
            voltageToggleOn()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //all startup stuff. youve seen this before
        do {
           
            try Net.enableServerDiscovery(serverType: .deviceRemote)
            //ooh this is new. add a server named phidgets bc at ip address 192.168.99.1, with a port of 5661 with no password with 0 flags
            try Net.addServer(serverName: "phidgetsbc", address: "192.168.99.1", port: 5661, password: "", flags: 0);
            
            try rMotor.setDeviceSerialNumber(512806)
            try rMotor.setHubPort(0)
            try rMotor.setIsHubPortDevice(false)
            
            try lMotor.setDeviceSerialNumber(512806)
            try lMotor.setHubPort(1)
            try lMotor.setIsHubPortDevice(false)
            
            try stickY.setDeviceSerialNumber(527997)
            try stickY.setHubPort(5)
            try stickY.setIsHubPortDevice(false)
            try stickY.setChannel(0)
            
            try stickX.setDeviceSerialNumber(527997)
            try stickX.setHubPort(5)
            try stickX.setIsHubPortDevice(false)
            try stickX.setChannel(1)
            
            try frontSensor.setDeviceSerialNumber(512806)
            try frontSensor.setHubPort(2)
            try frontSensor.setIsHubPortDevice(false)
        
            try rightSensor.setDeviceSerialNumber(512806)
            try rightSensor.setHubPort(3)
            try rightSensor.setIsHubPortDevice(false)
            
            try leftSensor.setDeviceSerialNumber(512806)
            try leftSensor.setHubPort(4)
            try leftSensor.setIsHubPortDevice(false)


            
            let _ = frontSensor.attach.addHandler(attachHandler)
            let _ = leftSensor.attach.addHandler(attachHandler)
            let _ = rightSensor.attach.addHandler(attachHandler)
            let _ = rMotor.attach.addHandler(attachHandler)
            let _ = lMotor.attach.addHandler(attachHandler)
            let _ = stickY.attach.addHandler(attachHandler)
            let _ = stickX.attach.addHandler(attachHandler)
            
            try rMotor.open()
            try lMotor.open()
            try frontSensor.open()
            try leftSensor.open()
            try rightSensor.open()
            try stickX.open()
            try stickY.open()
            
        } catch let err as PhidgetError {
            print("error 1 in startup")
            print(err)
        } catch {
            print("error 2 in startup")
            print(error)
        }
        
    }
}



