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
    let rMotor = DCMotor()
    let lMotor = DCMotor()
    let stickY = VoltageRatioInput()
    let stickX = VoltageRatioInput()
    let distSensor = DistanceSensor()
    let objDetected : Bool = true
    func attachHandler(sender: Phidget) {
        do {
            if (try sender.getHubPort() == 0) {
                print("Right motor attached")
            } else if (try sender.getHubPort() == 1) {
                print("Left motor attached")
            } else if (try sender.getHubPort() == 2) {
                print("Distance sensor attached")
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
    
    func voltageChanger(sender: VoltageRatioInput, voltageRatio: Double) {
        do {
            let xVoltageRatio = try stickX.getVoltageRatio()
            let yVoltageRatio = try stickY.getVoltageRatio()
            if ( xVoltageRatio > 0.5) {
             
                try lMotor.setTargetVelocity(xVoltageRatio)
                try rMotor.setTargetVelocity(-yVoltageRatio)
            } else if (xVoltageRatio < -0.5) {
                try lMotor.setTargetVelocity(yVoltageRatio)
                try rMotor.setTargetVelocity(xVoltageRatio)
  
            } else {
                try lMotor.setTargetVelocity(yVoltageRatio)
                try rMotor.setTargetVelocity(-yVoltageRatio)
            }
        } catch let err as PhidgetError {
            print("error 1 in voltage")
            print(err)
        } catch {
            print("error 2 in voltage")
            print(error)
        }
    }
    
    func distChange(sender: DistanceSensor, distance: UInt32) {
        do {
            let distance = try distSensor.getDistance()
            if(distance <= 80) {
                try lMotor.setTargetVelocity(0)
                try rMotor.setTargetVelocity(0)
            } else {
                
            }
        } catch let err as PhidgetError {
            print(err)
        } catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do {
           
            try Net.enableServerDiscovery(serverType: .deviceRemote)
            
            try rMotor.setDeviceSerialNumber(527997)
            try rMotor.setHubPort(0)
            try rMotor.setIsHubPortDevice(false)
            
            try lMotor.setDeviceSerialNumber(527997)
            try lMotor.setHubPort(1)
            try lMotor.setIsHubPortDevice(false)
            
            try stickY.setDeviceSerialNumber(527997)
            try stickY.setHubPort(3)
            try stickY.setIsHubPortDevice(false)
            try stickY.setChannel(0)
            
            try stickX.setDeviceSerialNumber(527997)
            try stickX.setHubPort(3)
            try stickX.setIsHubPortDevice(false)
            try stickX.setChannel(1)
            
            try distSensor.setHubPort(2)
            try distSensor.setIsHubPortDevice(false)
            


            
            let _ = distSensor.attach.addHandler(attachHandler)
            let _ = rMotor.attach.addHandler(attachHandler)
            let _ = lMotor.attach.addHandler(attachHandler)
            let _ = stickY.attach.addHandler(attachHandler)
            let _ = stickX.attach.addHandler(attachHandler)
            
            let _ = distSensor.distanceChange.addHandler(distChange)
            let _ = stickX.voltageRatioChange.addHandler(voltageChanger)
            let _ = stickY.voltageRatioChange.addHandler(voltageChanger)
            
            try rMotor.open()
            try lMotor.open()
            try distSensor.open()
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



