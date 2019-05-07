import Foundation
import Phidget22_C

/**
The BLDC Motor class controls the power applied to attached brushless DC motors to affect its speed and direction. It can also contain various other control and monitoring functions that aid in the control of brushless DC motors.
*/
public class BLDCMotorBase : Phidget {

	public init() {
		var h: PhidgetHandle?
		PhidgetBLDCMotor_create(&h)
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
			PhidgetBLDCMotor_delete(&chandle)
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
		result = PhidgetBLDCMotor_getAcceleration(chandle, &acceleration)
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
		result = PhidgetBLDCMotor_setAcceleration(chandle, acceleration)
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
		result = PhidgetBLDCMotor_getMinAcceleration(chandle, &minAcceleration)
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
		result = PhidgetBLDCMotor_getMaxAcceleration(chandle, &maxAcceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxAcceleration
	}

	/**
	The most recent braking strength value that the controller has reported.

	- returns:
	The braking strength value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getBrakingStrength() throws -> Double {
		let result: PhidgetReturnCode
		var brakingStrength: Double = 0
		result = PhidgetBLDCMotor_getBrakingStrength(chandle, &brakingStrength)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return brakingStrength
	}

	/**
	The minimum value that `TargetBrakingStrength` can be set to.

	- returns:
	The braking value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinBrakingStrength() throws -> Double {
		let result: PhidgetReturnCode
		var minBrakingStrength: Double = 0
		result = PhidgetBLDCMotor_getMinBrakingStrength(chandle, &minBrakingStrength)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minBrakingStrength
	}

	/**
	The maximum value that `TargetBrakingStrength` can be set to.

	- returns:
	The braking value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxBrakingStrength() throws -> Double {
		let result: PhidgetReturnCode
		var maxBrakingStrength: Double = 0
		result = PhidgetBLDCMotor_getMaxBrakingStrength(chandle, &maxBrakingStrength)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxBrakingStrength
	}

	/**
	The `DataInterval` is the time that must elapse before the controller will fire another update event.

	*   The data interval is bounded by `MinDataInterval` and `MaxDataInterval`.

	- returns:
	The data interval value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getDataInterval() throws -> UInt32 {
		let result: PhidgetReturnCode
		var dataInterval: UInt32 = 0
		result = PhidgetBLDCMotor_getDataInterval(chandle, &dataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return dataInterval
	}

	/**
	The `DataInterval` is the time that must elapse before the controller will fire another update event.

	*   The data interval is bounded by `MinDataInterval` and `MaxDataInterval`.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- dataInterval: The data interval value
	*/
	public func setDataInterval(_ dataInterval: UInt32) throws {
		let result: PhidgetReturnCode
		result = PhidgetBLDCMotor_setDataInterval(chandle, dataInterval)
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
		result = PhidgetBLDCMotor_getMinDataInterval(chandle, &minDataInterval)
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
		result = PhidgetBLDCMotor_getMaxDataInterval(chandle, &maxDataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxDataInterval
	}

	/**
	The most recent position value that the controller has reported.

	*   Position values are calculated using Hall Effect sensors mounted on the motor, therefore, the resolution of position depends on the motor you are using.
	*   Units for `Position` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees. For more information on how to apply the `RescaleFactor` to your application, see your controller's User Guide.

	- returns:
	The position value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getPosition() throws -> Double {
		let result: PhidgetReturnCode
		var position: Double = 0
		result = PhidgetBLDCMotor_getPosition(chandle, &position)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return position
	}

	/**
	The lower bound of `Position`.

	- returns:
	The position value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinPosition() throws -> Double {
		let result: PhidgetReturnCode
		var minPosition: Double = 0
		result = PhidgetBLDCMotor_getMinPosition(chandle, &minPosition)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minPosition
	}

	/**
	The upper bound of `Position`.

	- returns:
	The position value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxPosition() throws -> Double {
		let result: PhidgetReturnCode
		var maxPosition: Double = 0
		result = PhidgetBLDCMotor_getMaxPosition(chandle, &maxPosition)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxPosition
	}

	/**
	Adds an offset (positive or negative) to the current position.

	*   This can be especially useful for zeroing position.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- positionOffset: Amount to offset the position by
	*/
	public func addPositionOffset(positionOffset: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetBLDCMotor_addPositionOffset(chandle, positionOffset)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	Change the units of your parameters so that your application is more intuitive.

	*   Units for `Position` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees. For more information on how to apply the `RescaleFactor` to your application, see your controller's User Guide.

	- returns:
	The rescale factor value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getRescaleFactor() throws -> Double {
		let result: PhidgetReturnCode
		var rescaleFactor: Double = 0
		result = PhidgetBLDCMotor_getRescaleFactor(chandle, &rescaleFactor)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return rescaleFactor
	}

	/**
	Change the units of your parameters so that your application is more intuitive.

	*   Units for `Position` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees. For more information on how to apply the `RescaleFactor` to your application, see your controller's User Guide.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- rescaleFactor: The rescale factor value
	*/
	public func setRescaleFactor(_ rescaleFactor: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetBLDCMotor_setRescaleFactor(chandle, rescaleFactor)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	Before reading this description, it is important to note the difference between the units of `StallVelocity` and `Velocity`.

	*   `Velocity` is a number between -1 and 1 with units of 'duty cycle'. It simply represents the average voltage across the motor.
	*   `StallVelocity` represents a real velocity (e.g. m/s, RPM, etc.) and the units are determined by the `RescaleFactor`. With a `RescaleFactor` of 1, the default units would be in commutations per second.

	If the load on your motor is large, your motor may begin rotating more slowly, or even fully stall. Depending on the voltage across your motor, this may result in a large amount of current through both the controller and the motor. In order to prevent damage in these situations, you can use the `StallVelocity` property.  
	  
	The `StallVelocity` should be set to the lowest velocity you would expect from your motor. The controller will then monitor the motor's velocity, as well as the `Velocity`, and prevent a 'dangerous stall' from occuring. If the controller detects a dangerous stall, it will immediately reduce the `Velocity` (i.e. average voltage) to 0 and an error will be reported to your program.

	*   A 'dangerous stall' will occur faster when the `Velocity` is higher (i.e. when the average voltage across the motor is higher)
	*   A 'dangerous stall' will occur faster as (`StallVelocity` \- motor velocity) becomes larger .

	Setting `StallVelocity` to 0 will turn off stall protection functionality.

	- returns:
	The stall velocity value.

	- throws:
	An error or type `PhidgetError`
	*/
	public func getStallVelocity() throws -> Double {
		let result: PhidgetReturnCode
		var stallVelocity: Double = 0
		result = PhidgetBLDCMotor_getStallVelocity(chandle, &stallVelocity)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return stallVelocity
	}

	/**
	Before reading this description, it is important to note the difference between the units of `StallVelocity` and `Velocity`.

	*   `Velocity` is a number between -1 and 1 with units of 'duty cycle'. It simply represents the average voltage across the motor.
	*   `StallVelocity` represents a real velocity (e.g. m/s, RPM, etc.) and the units are determined by the `RescaleFactor`. With a `RescaleFactor` of 1, the default units would be in commutations per second.

	If the load on your motor is large, your motor may begin rotating more slowly, or even fully stall. Depending on the voltage across your motor, this may result in a large amount of current through both the controller and the motor. In order to prevent damage in these situations, you can use the `StallVelocity` property.  
	  
	The `StallVelocity` should be set to the lowest velocity you would expect from your motor. The controller will then monitor the motor's velocity, as well as the `Velocity`, and prevent a 'dangerous stall' from occuring. If the controller detects a dangerous stall, it will immediately reduce the `Velocity` (i.e. average voltage) to 0 and an error will be reported to your program.

	*   A 'dangerous stall' will occur faster when the `Velocity` is higher (i.e. when the average voltage across the motor is higher)
	*   A 'dangerous stall' will occur faster as (`StallVelocity` \- motor velocity) becomes larger .

	Setting `StallVelocity` to 0 will turn off stall protection functionality.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- stallVelocity: The stall velocity value.
	*/
	public func setStallVelocity(_ stallVelocity: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetBLDCMotor_setStallVelocity(chandle, stallVelocity)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The lower bound of `StallVelocity`.

	- returns:
	The velocity value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinStallVelocity() throws -> Double {
		let result: PhidgetReturnCode
		var minStallVelocity: Double = 0
		result = PhidgetBLDCMotor_getMinStallVelocity(chandle, &minStallVelocity)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minStallVelocity
	}

	/**
	The upper bound of `StallVelocity`.

	- returns:
	The velocity value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxStallVelocity() throws -> Double {
		let result: PhidgetReturnCode
		var maxStallVelocity: Double = 0
		result = PhidgetBLDCMotor_getMaxStallVelocity(chandle, &maxStallVelocity)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxStallVelocity
	}

	/**
	When a motor is not being actively driven forward or reverse, you can choose if the motor will be allowed to freely turn, or will resist being turned.

	*   A low `TargetBrakingStrength` value corresponds to free wheeling, this will have the following effects:
	    *   The motor will continue to rotate after the controller is no longer driving the motor (i.e. `Velocity` is 0), due to inertia.
	    *   The motor shaft will provide little resistance to being turned when it is stopped.
	*   A higher `TargetBrakingStrength` value will resist being turned, this will have the following effects:
	    *   The motor will more stop more quickly if it is in motion and braking has been requested. It will fight against the rotation of the shaft.
	*   Braking mode is enabled by setting the `Velocity` to `MinVelocity`

	- returns:
	The braking value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getTargetBrakingStrength() throws -> Double {
		let result: PhidgetReturnCode
		var targetBrakingStrength: Double = 0
		result = PhidgetBLDCMotor_getTargetBrakingStrength(chandle, &targetBrakingStrength)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return targetBrakingStrength
	}

	/**
	When a motor is not being actively driven forward or reverse, you can choose if the motor will be allowed to freely turn, or will resist being turned.

	*   A low `TargetBrakingStrength` value corresponds to free wheeling, this will have the following effects:
	    *   The motor will continue to rotate after the controller is no longer driving the motor (i.e. `Velocity` is 0), due to inertia.
	    *   The motor shaft will provide little resistance to being turned when it is stopped.
	*   A higher `TargetBrakingStrength` value will resist being turned, this will have the following effects:
	    *   The motor will more stop more quickly if it is in motion and braking has been requested. It will fight against the rotation of the shaft.
	*   Braking mode is enabled by setting the `Velocity` to `MinVelocity`

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- targetBrakingStrength: The braking value
	*/
	public func setTargetBrakingStrength(_ targetBrakingStrength: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetBLDCMotor_setTargetBrakingStrength(chandle, targetBrakingStrength)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The average voltage across the motor is based on the `TargetVelocity` value.

	*   At a constant load, increasing the target velocity will increase the speed of the motor.
	*   `TargetVelocity` is bounded by -1×`MaxVelocity` and `MaxVelocity`, where a sign change (±) is indicitave of a direction change.
	*   Setting `TargetVelocity` to `MinVelocity` will stop the motor. See `TargetBrakingStrength` for more information on stopping the motor.
	*   The units of `TargetVelocity` and `Acceleration` refer to 'duty cycle'. This is because the controller must rapidly switch the power on/off (i.e. change the duty cycle) in order to manipulate the voltage across the motor.

	- returns:
	The velocity value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getTargetVelocity() throws -> Double {
		let result: PhidgetReturnCode
		var targetVelocity: Double = 0
		result = PhidgetBLDCMotor_getTargetVelocity(chandle, &targetVelocity)
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
	*   The units of `TargetVelocity` and `Acceleration` refer to 'duty cycle'. This is because the controller must rapidly switch the power on/off (i.e. change the duty cycle) in order to manipulate the voltage across the motor.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- targetVelocity: The velocity value
	*/
	public func setTargetVelocity(_ targetVelocity: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetBLDCMotor_setTargetVelocity(chandle, targetVelocity)
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
		result = PhidgetBLDCMotor_getVelocity(chandle, &velocity)
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
		result = PhidgetBLDCMotor_getMinVelocity(chandle, &minVelocity)
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
		result = PhidgetBLDCMotor_getMaxVelocity(chandle, &maxVelocity)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxVelocity
	}

	internal override func initializeEvents() {
		initializeBaseEvents()
		PhidgetBLDCMotor_setOnBrakingStrengthChangeHandler(chandle, nativeBrakingStrengthChangeHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
		PhidgetBLDCMotor_setOnPositionChangeHandler(chandle, nativePositionChangeHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
		PhidgetBLDCMotor_setOnVelocityUpdateHandler(chandle, nativeVelocityUpdateHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
	}

	internal override func uninitializeEvents() {
		uninitializeBaseEvents()
		PhidgetBLDCMotor_setOnBrakingStrengthChangeHandler(chandle, nil, nil)
		PhidgetBLDCMotor_setOnPositionChangeHandler(chandle, nil, nil)
		PhidgetBLDCMotor_setOnVelocityUpdateHandler(chandle, nil, nil)
	}

	/**
	The most recent braking strength value will be reported in this event, which occurs when the `DataInterval` has elapsed.

	*   Regardless of the `DataInterval`, this event will occur only when the braking strength value has changed from the previous value reported.
	*   Braking mode is enabled by setting the `Velocity` to `MinVelocity`

	---
	## Parameters:
	*   `brakingStrength`: The braking strength value
	*/
	public let brakingStrengthChange = Event<BLDCMotor, Double> ()
	let nativeBrakingStrengthChangeHandler : PhidgetBLDCMotor_OnBrakingStrengthChangeCallback = { ch, ctx, brakingStrength in
		let me = Unmanaged<BLDCMotor>.fromOpaque(ctx!).takeUnretainedValue()
		me.brakingStrengthChange.raise(me, brakingStrength);
	}

	/**
	The most recent position value will be reported in this event, which occurs when the `DataInterval` has elapsed.

	*   Regardless of the `DataInterval`, this event will occur only when the position value has changed from the previous value reported.
	*   Position values are calculated using Hall Effect sensors mounted on the motor, therefore, the resolution of position depends on the motor you are using.
	*   Units for `Position` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees. For more information on how to apply the `RescaleFactor` to your application, see your controller's User Guide.

	---
	## Parameters:
	*   `position`: The position value
	*/
	public let positionChange = Event<BLDCMotor, Double> ()
	let nativePositionChangeHandler : PhidgetBLDCMotor_OnPositionChangeCallback = { ch, ctx, position in
		let me = Unmanaged<BLDCMotor>.fromOpaque(ctx!).takeUnretainedValue()
		me.positionChange.raise(me, position);
	}

	/**
	The most recent velocity value will be reported in this event, which occurs when the `DataInterval` has elapsed.

	*   This event will **always** occur when the `DataInterval` elapses. You can depend on this event for constant timing when implementing control loops in code. This is the last event to fire, giving you up-to-date access to all properties.

	---
	## Parameters:
	*   `velocity`: The velocity value
	*/
	public let velocityUpdate = Event<BLDCMotor, Double> ()
	let nativeVelocityUpdateHandler : PhidgetBLDCMotor_OnVelocityUpdateCallback = { ch, ctx, velocity in
		let me = Unmanaged<BLDCMotor>.fromOpaque(ctx!).takeUnretainedValue()
		me.velocityUpdate.raise(me, velocity);
	}

}
