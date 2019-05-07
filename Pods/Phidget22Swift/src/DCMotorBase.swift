import Foundation
import Phidget22_C

/**
The DC Motor class controls the power applied to attached DC motors to affect its speed and direction. It can also contain various other control and monitoring functions that aid in the control of DC motors.
*/
public class DCMotorBase : Phidget {

	public init() {
		var h: PhidgetHandle?
		PhidgetDCMotor_create(&h)
		super.init(h!)
		initializeEvents()
	}

	internal override init(_ handle: PhidgetHandle) {
		super.init(handle)
	}

	deinit {
		if (retained) {
			Phidget_release(&chandle)
		} else {
			uninitializeEvents()
			PhidgetDCMotor_delete(&chandle)
		}
	}

	/**
	The rate at which the controller can change the motor's `Velocity`.

	*   The acceleration is bounded by `MinAccleration` and `MaxAcceleration`

	- returns:
	The acceleration value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getAcceleration() throws -> Double {
		let result: PhidgetReturnCode
		var acceleration: Double = 0
		result = PhidgetDCMotor_getAcceleration(chandle, &acceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return acceleration
	}

	/**
	The rate at which the controller can change the motor's `Velocity`.

	*   The acceleration is bounded by `MinAccleration` and `MaxAcceleration`

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- acceleration: The acceleration value
	*/
	public func setAcceleration(_ acceleration: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetDCMotor_setAcceleration(chandle, acceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `Acceleration` can be set to.

	- returns:
	The acceleration value.

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinAcceleration() throws -> Double {
		let result: PhidgetReturnCode
		var minAcceleration: Double = 0
		result = PhidgetDCMotor_getMinAcceleration(chandle, &minAcceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minAcceleration
	}

	/**
	The maximum value that `Acceleration` can be set to.

	- returns:
	The acceleration value.

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxAcceleration() throws -> Double {
		let result: PhidgetReturnCode
		var maxAcceleration: Double = 0
		result = PhidgetDCMotor_getMaxAcceleration(chandle, &maxAcceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxAcceleration
	}

	/**
	The most recent `BackEMF` value that the controller has reported.

	- returns:
	The back EMF value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getBackEMF() throws -> Double {
		let result: PhidgetReturnCode
		var backEMF: Double = 0
		result = PhidgetDCMotor_getBackEMF(chandle, &backEMF)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return backEMF
	}

	/**
	When `BackEMFSensingState` is enabled, the controller will measure and report the `BackEMF`.

	*   The motor will coast (freewheel) 5% of the time while the back EMF is being measured (800μs every 16ms). Therefore, at a `DutyCycle` of 100%, the motor will only be driven for 95% of the time.

	- returns:
	The back EMF state

	- throws:
	An error or type `PhidgetError`
	*/
	public func getBackEMFSensingState() throws -> Bool {
		let result: PhidgetReturnCode
		var backEMFSensingState: Int32 = 0
		result = PhidgetDCMotor_getBackEMFSensingState(chandle, &backEMFSensingState)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return (backEMFSensingState == 0 ? false : true)
	}

	/**
	When `BackEMFSensingState` is enabled, the controller will measure and report the `BackEMF`.

	*   The motor will coast (freewheel) 5% of the time while the back EMF is being measured (800μs every 16ms). Therefore, at a `DutyCycle` of 100%, the motor will only be driven for 95% of the time.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- backEMFSensingState: The back EMF state
	*/
	public func setBackEMFSensingState(_ backEMFSensingState: Bool) throws {
		let result: PhidgetReturnCode
		result = PhidgetDCMotor_setBackEMFSensingState(chandle, (backEMFSensingState ? 1 : 0))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The most recent braking strength value that the controller has reported. See `TargetBrakingStrength` for details.

	- returns:
	The braking strength value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getBrakingStrength() throws -> Double {
		let result: PhidgetReturnCode
		var brakingStrength: Double = 0
		result = PhidgetDCMotor_getBrakingStrength(chandle, &brakingStrength)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return brakingStrength
	}

	/**
	The minimum value that `TargetBrakingStrength` can be set to. See `TargetBrakingStrength` for details.

	- returns:
	The braking strength value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinBrakingStrength() throws -> Double {
		let result: PhidgetReturnCode
		var minBrakingStrength: Double = 0
		result = PhidgetDCMotor_getMinBrakingStrength(chandle, &minBrakingStrength)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minBrakingStrength
	}

	/**
	The maximum value that `TargetBrakingStrength` can be set to. See `TargetBrakingStrength` for details.

	- returns:
	The braking strength value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxBrakingStrength() throws -> Double {
		let result: PhidgetReturnCode
		var maxBrakingStrength: Double = 0
		result = PhidgetDCMotor_getMaxBrakingStrength(chandle, &maxBrakingStrength)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxBrakingStrength
	}

	/**
	The controller will limit the current through the motor to the `CurrentLimit` value.

	- returns:
	The current value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getCurrentLimit() throws -> Double {
		let result: PhidgetReturnCode
		var currentLimit: Double = 0
		result = PhidgetDCMotor_getCurrentLimit(chandle, &currentLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return currentLimit
	}

	/**
	The controller will limit the current through the motor to the `CurrentLimit` value.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- currentLimit: The current value
	*/
	public func setCurrentLimit(_ currentLimit: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetDCMotor_setCurrentLimit(chandle, currentLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `CurrentLimit` can be set to.

	- returns:
	The current value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinCurrentLimit() throws -> Double {
		let result: PhidgetReturnCode
		var minCurrentLimit: Double = 0
		result = PhidgetDCMotor_getMinCurrentLimit(chandle, &minCurrentLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minCurrentLimit
	}

	/**
	The maximum value that `CurrentLimit` can be set to.

	- returns:
	The current value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxCurrentLimit() throws -> Double {
		let result: PhidgetReturnCode
		var maxCurrentLimit: Double = 0
		result = PhidgetDCMotor_getMaxCurrentLimit(chandle, &maxCurrentLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxCurrentLimit
	}

	/**
	Depending on power supply voltage and motor coil inductance, current through the motor can change relatively slowly or extremely rapidly. A physically larger DC Motor will typically have a lower inductance, requiring a higher current regulator gain. A higher power supply voltage will result in motor current changing more rapidly, requiring a higher current regulator gain. If the current regulator gain is too small, spikes in current will occur, causing large variations in torque, and possibly damaging the motor controller. If the current regulator gain is too high, the current will jitter, causing the motor to sound 'rough', especially when changing directions.

	*   Each DC Motor we sell specifies a suitable current regulator gain.

	- returns:
	The current regulator gain value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getCurrentRegulatorGain() throws -> Double {
		let result: PhidgetReturnCode
		var currentRegulatorGain: Double = 0
		result = PhidgetDCMotor_getCurrentRegulatorGain(chandle, &currentRegulatorGain)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return currentRegulatorGain
	}

	/**
	Depending on power supply voltage and motor coil inductance, current through the motor can change relatively slowly or extremely rapidly. A physically larger DC Motor will typically have a lower inductance, requiring a higher current regulator gain. A higher power supply voltage will result in motor current changing more rapidly, requiring a higher current regulator gain. If the current regulator gain is too small, spikes in current will occur, causing large variations in torque, and possibly damaging the motor controller. If the current regulator gain is too high, the current will jitter, causing the motor to sound 'rough', especially when changing directions.

	*   Each DC Motor we sell specifies a suitable current regulator gain.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- currentRegulatorGain: The current regulator gain value
	*/
	public func setCurrentRegulatorGain(_ currentRegulatorGain: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetDCMotor_setCurrentRegulatorGain(chandle, currentRegulatorGain)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `CurrentRegulatorGain` can be set to.

	- returns:
	The current regulator gain value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinCurrentRegulatorGain() throws -> Double {
		let result: PhidgetReturnCode
		var minCurrentRegulatorGain: Double = 0
		result = PhidgetDCMotor_getMinCurrentRegulatorGain(chandle, &minCurrentRegulatorGain)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minCurrentRegulatorGain
	}

	/**
	The maximum value that `CurrentRegulatorGain` can be set to.

	- returns:
	The current regulator gain value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxCurrentRegulatorGain() throws -> Double {
		let result: PhidgetReturnCode
		var maxCurrentRegulatorGain: Double = 0
		result = PhidgetDCMotor_getMaxCurrentRegulatorGain(chandle, &maxCurrentRegulatorGain)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxCurrentRegulatorGain
	}

	/**
	The `DataInterval` is the time that must elapse before the controller will fire another `VelocityUpdate`/`BrakingStrengthChange` event.

	*   The data interval is bounded by `MinDataInterval` and `MaxDataInterval`.
	*   Note: `BrakingStrengthChange` events will only fire if a change in braking has occurred.

	- returns:
	The data interval value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getDataInterval() throws -> UInt32 {
		let result: PhidgetReturnCode
		var dataInterval: UInt32 = 0
		result = PhidgetDCMotor_getDataInterval(chandle, &dataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return dataInterval
	}

	/**
	The `DataInterval` is the time that must elapse before the controller will fire another `VelocityUpdate`/`BrakingStrengthChange` event.

	*   The data interval is bounded by `MinDataInterval` and `MaxDataInterval`.
	*   Note: `BrakingStrengthChange` events will only fire if a change in braking has occurred.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- dataInterval: The data interval value
	*/
	public func setDataInterval(_ dataInterval: UInt32) throws {
		let result: PhidgetReturnCode
		result = PhidgetDCMotor_setDataInterval(chandle, dataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `DataInterval` can be set to.

	- returns:
	The data interval value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinDataInterval() throws -> UInt32 {
		let result: PhidgetReturnCode
		var minDataInterval: UInt32 = 0
		result = PhidgetDCMotor_getMinDataInterval(chandle, &minDataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minDataInterval
	}

	/**
	The maximum value that `DataInterval` can be set to.

	- returns:
	The data interval value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxDataInterval() throws -> UInt32 {
		let result: PhidgetReturnCode
		var maxDataInterval: UInt32 = 0
		result = PhidgetDCMotor_getMaxDataInterval(chandle, &maxDataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxDataInterval
	}

	/**
	The `FanMode` dictates the operating condition of the fan.

	*   Choose between on, off, or automatic (based on temperature).
	*   If the `FanMode` is set to automatic, the fan will turn on when the temperature reaches 70°C and it will remain on until the temperature falls below 55°C.
	*   If the `FanMode` is off, the controller will still turn on the fan if the temperature reaches 85°C and it will remain on until it falls below 70°C.

	- returns:
	The fan mode

	- throws:
	An error or type `PhidgetError`
	*/
	public func getFanMode() throws -> FanMode {
		let result: PhidgetReturnCode
		var fanMode: Phidget_FanMode = FAN_MODE_OFF
		result = PhidgetDCMotor_getFanMode(chandle, &fanMode)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return FanMode(rawValue: fanMode.rawValue)!
	}

	/**
	The `FanMode` dictates the operating condition of the fan.

	*   Choose between on, off, or automatic (based on temperature).
	*   If the `FanMode` is set to automatic, the fan will turn on when the temperature reaches 70°C and it will remain on until the temperature falls below 55°C.
	*   If the `FanMode` is off, the controller will still turn on the fan if the temperature reaches 85°C and it will remain on until it falls below 70°C.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- fanMode: The fan mode
	*/
	public func setFanMode(_ fanMode: FanMode) throws {
		let result: PhidgetReturnCode
		result = PhidgetDCMotor_setFanMode(chandle, Phidget_FanMode(fanMode.rawValue))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	This setting allows you to choose how hard the motor will resist being turned when it is not being driven forward or reverse (`Velocity` = 0). The `TargetBrakingStrength` sets the relative amount of electrical braking to be applied to the DC motor, with `MinBrakingStrength` corresponding to no braking (free-wheeling), and `MaxBrakingStrength` indicating full braking.

	*   A low `TargetBrakingStrength` value corresponds to free-wheeling. This means:
	    *   The motor will continue to rotate after the controller is no longer driving the motor (`Velocity` = 0), due to its momentum.
	    *   The motor shaft will provide little resistance to being turned when it is stopped.
	*   As `TargetBrakingStrength` increases, this will engage electrical braking of the DC motor. This means:
	    *   The motor will stop more quickly if it is in motion when braking is requested.
	    *   The motor shaft will resist rotation by oustide forces.
	*   Braking will be added gradually, according to the `Acceleration` setting, once the motor controller's `Velocity` reaches 0.0
	*   Braking will be immediately stopped when a new (non-zero) `TargetVelocity` is set, and the motor will accelerate to the requested velocity.
	*   Braking mode is enabled by setting the `Velocity` to 0.0

	- returns:
	The braking strength value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getTargetBrakingStrength() throws -> Double {
		let result: PhidgetReturnCode
		var targetBrakingStrength: Double = 0
		result = PhidgetDCMotor_getTargetBrakingStrength(chandle, &targetBrakingStrength)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return targetBrakingStrength
	}

	/**
	This setting allows you to choose how hard the motor will resist being turned when it is not being driven forward or reverse (`Velocity` = 0). The `TargetBrakingStrength` sets the relative amount of electrical braking to be applied to the DC motor, with `MinBrakingStrength` corresponding to no braking (free-wheeling), and `MaxBrakingStrength` indicating full braking.

	*   A low `TargetBrakingStrength` value corresponds to free-wheeling. This means:
	    *   The motor will continue to rotate after the controller is no longer driving the motor (`Velocity` = 0), due to its momentum.
	    *   The motor shaft will provide little resistance to being turned when it is stopped.
	*   As `TargetBrakingStrength` increases, this will engage electrical braking of the DC motor. This means:
	    *   The motor will stop more quickly if it is in motion when braking is requested.
	    *   The motor shaft will resist rotation by oustide forces.
	*   Braking will be added gradually, according to the `Acceleration` setting, once the motor controller's `Velocity` reaches 0.0
	*   Braking will be immediately stopped when a new (non-zero) `TargetVelocity` is set, and the motor will accelerate to the requested velocity.
	*   Braking mode is enabled by setting the `Velocity` to 0.0

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- targetBrakingStrength: The braking strength value
	*/
	public func setTargetBrakingStrength(_ targetBrakingStrength: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetDCMotor_setTargetBrakingStrength(chandle, targetBrakingStrength)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The average voltage across the motor is based on the `TargetVelocity` value.

	*   At a constant load, increasing the target velocity will increase the speed of the motor.
	*   `TargetVelocity` is bounded by -1×`MaxVelocity` and `MaxVelocity`, where a sign change (±) is indicitave of a direction change.
	*   Setting `TargetVelocity` to `MinVelocity` will stop the motor. See `TargetBrakingStrength` for more information on stopping the motor.
	*   The units of `TargetVelocity` and `Acceleration` refer to 'duty cycle'. This is because the controller controls velocity by rapidly switching the power on/off (i.e. changing the duty cycle) in order to manipulate the voltage across the motor.

	- returns:
	The velocity value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getTargetVelocity() throws -> Double {
		let result: PhidgetReturnCode
		var targetVelocity: Double = 0
		result = PhidgetDCMotor_getTargetVelocity(chandle, &targetVelocity)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return targetVelocity
	}

	/**
	The average voltage across the motor is based on the `TargetVelocity` value.

	*   At a constant load, increasing the target velocity will increase the speed of the motor.
	*   `TargetVelocity` is bounded by -1×`MaxVelocity` and `MaxVelocity`, where a sign change (±) is indicitave of a direction change.
	*   Setting `TargetVelocity` to `MinVelocity` will stop the motor. See `TargetBrakingStrength` for more information on stopping the motor.
	*   The units of `TargetVelocity` and `Acceleration` refer to 'duty cycle'. This is because the controller controls velocity by rapidly switching the power on/off (i.e. changing the duty cycle) in order to manipulate the voltage across the motor.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- targetVelocity: The velocity value
	*/
	public func setTargetVelocity(_ targetVelocity: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetDCMotor_setTargetVelocity(chandle, targetVelocity)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The most recent velocity value that the controller has reported.

	- returns:
	The velocity value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getVelocity() throws -> Double {
		let result: PhidgetReturnCode
		var velocity: Double = 0
		result = PhidgetDCMotor_getVelocity(chandle, &velocity)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return velocity
	}

	/**
	The minimum value that `TargetVelocity` can be set to

	*   Set the `TargetVelocity` to `MinVelocity` to stop the motor. See `TargetBrakingStrength` for more information on stopping the motor.
	*   `TargetVelocity` is bounded by -1×`MaxVelocity` and `MaxVelocity`, where a sign change (±) is indicitave of a direction change.

	- returns:
	The velocity value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinVelocity() throws -> Double {
		let result: PhidgetReturnCode
		var minVelocity: Double = 0
		result = PhidgetDCMotor_getMinVelocity(chandle, &minVelocity)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minVelocity
	}

	/**
	The maximum value that `TargetVelocity` can be set to.

	*   `TargetVelocity` is bounded by -1×`MaxVelocity` and `MaxVelocity`, where a sign change (±) is indicitave of a direction change.

	- returns:
	The velocity value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxVelocity() throws -> Double {
		let result: PhidgetReturnCode
		var maxVelocity: Double = 0
		result = PhidgetDCMotor_getMaxVelocity(chandle, &maxVelocity)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxVelocity
	}

	internal override func initializeEvents() {
		initializeBaseEvents()
		PhidgetDCMotor_setOnBackEMFChangeHandler(chandle, nativeBackEMFChangeHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
		PhidgetDCMotor_setOnBrakingStrengthChangeHandler(chandle, nativeBrakingStrengthChangeHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
		PhidgetDCMotor_setOnVelocityUpdateHandler(chandle, nativeVelocityUpdateHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
	}

	internal override func uninitializeEvents() {
		uninitializeBaseEvents()
		PhidgetDCMotor_setOnBackEMFChangeHandler(chandle, nil, nil)
		PhidgetDCMotor_setOnBrakingStrengthChangeHandler(chandle, nil, nil)
		PhidgetDCMotor_setOnVelocityUpdateHandler(chandle, nil, nil)
	}

	/**
	The most recent back emf value will be reported in this event.

	---
	## Parameters:
	*   `backEMF`: The back EMF voltage from the motor
	*/
	public let backEMFChange = Event<DCMotor, Double> ()
	let nativeBackEMFChangeHandler : PhidgetDCMotor_OnBackEMFChangeCallback = { ch, ctx, backEMF in
		let me = Unmanaged<DCMotor>.fromOpaque(ctx!).takeUnretainedValue()
		me.backEMFChange.raise(me, backEMF);
	}

	/**
	Occurs when the motor braking strength changes.

	---
	## Parameters:
	*   `brakingStrength`: The most recent braking strength value will be reported in this event.

*   This event will occur only when the value of braking strength has changed
*   See `TargetBrakingStrength` for details about what this number represents.
	*/
	public let brakingStrengthChange = Event<DCMotor, Double> ()
	let nativeBrakingStrengthChangeHandler : PhidgetDCMotor_OnBrakingStrengthChangeCallback = { ch, ctx, brakingStrength in
		let me = Unmanaged<DCMotor>.fromOpaque(ctx!).takeUnretainedValue()
		me.brakingStrengthChange.raise(me, brakingStrength);
	}

	/**
	Occurs at a rate defined by the `DataInterval`.

	---
	## Parameters:
	*   `velocity`: The most recent velocity value will be reported in this event.
	*/
	public let velocityUpdate = Event<DCMotor, Double> ()
	let nativeVelocityUpdateHandler : PhidgetDCMotor_OnVelocityUpdateCallback = { ch, ctx, velocity in
		let me = Unmanaged<DCMotor>.fromOpaque(ctx!).takeUnretainedValue()
		me.velocityUpdate.raise(me, velocity);
	}

}
