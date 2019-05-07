import Foundation
import Phidget22_C

/**
The Stepper class powers and controls the stepper motor connected to the Phidget controller, allowing you to change the position, velocity, acceleration, and current limit.
*/
public class StepperBase : Phidget {

	public init() {
		var h: PhidgetHandle?
		PhidgetStepper_create(&h)
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
			PhidgetStepper_delete(&chandle)
		}
	}

	/**
	The rate at which the controller can change the motor's `Velocity`.

	*   Units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The acceleration value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getAcceleration() throws -> Double {
		let result: PhidgetReturnCode
		var acceleration: Double = 0
		result = PhidgetStepper_getAcceleration(chandle, &acceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return acceleration
	}

	/**
	The rate at which the controller can change the motor's `Velocity`.

	*   Units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- acceleration: The acceleration value
	*/
	public func setAcceleration(_ acceleration: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetStepper_setAcceleration(chandle, acceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `Acceleration` can be set to.

	*   Units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The acceleration value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinAcceleration() throws -> Double {
		let result: PhidgetReturnCode
		var minAcceleration: Double = 0
		result = PhidgetStepper_getMinAcceleration(chandle, &minAcceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minAcceleration
	}

	/**
	The maximum value that `Acceleration` can be set to.

	*   Units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The acceleration value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxAcceleration() throws -> Double {
		let result: PhidgetReturnCode
		var maxAcceleration: Double = 0
		result = PhidgetStepper_getMaxAcceleration(chandle, &maxAcceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxAcceleration
	}

	/**
	Use step mode when you want to set a `TargetPosition` for the Stepper motor. Use run mode when you simply want the Stepper motor to rotate continuously in a specific direction.

	- returns:
	The control mode value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getControlMode() throws -> StepperControlMode {
		let result: PhidgetReturnCode
		var controlMode: PhidgetStepper_ControlMode = CONTROL_MODE_STEP
		result = PhidgetStepper_getControlMode(chandle, &controlMode)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return StepperControlMode(rawValue: controlMode.rawValue)!
	}

	/**
	Use step mode when you want to set a `TargetPosition` for the Stepper motor. Use run mode when you simply want the Stepper motor to rotate continuously in a specific direction.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- controlMode: The control mode value
	*/
	public func setControlMode(_ controlMode: StepperControlMode) throws {
		let result: PhidgetReturnCode
		result = PhidgetStepper_setControlMode(chandle, PhidgetStepper_ControlMode(controlMode.rawValue))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The current through the motor will be limited by the `CurrentLimit`.

	*   See your Stepper motor's data sheet for more information about what value the `CurrentLimit` should be.

	- returns:
	The current limit value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getCurrentLimit() throws -> Double {
		let result: PhidgetReturnCode
		var currentLimit: Double = 0
		result = PhidgetStepper_getCurrentLimit(chandle, &currentLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return currentLimit
	}

	/**
	The current through the motor will be limited by the `CurrentLimit`.

	*   See your Stepper motor's data sheet for more information about what value the `CurrentLimit` should be.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- currentLimit: The current limit value
	*/
	public func setCurrentLimit(_ currentLimit: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetStepper_setCurrentLimit(chandle, currentLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `CurrentLimit` and `HoldingCurrentLimit` can be set to.

	*   Reference your controller's User Guide for more information about how the `HoldingCurrentLimit` and `CurrentLimit` can be used in your application.

	- returns:
	The current limit

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinCurrentLimit() throws -> Double {
		let result: PhidgetReturnCode
		var minCurrentLimit: Double = 0
		result = PhidgetStepper_getMinCurrentLimit(chandle, &minCurrentLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minCurrentLimit
	}

	/**
	The maximum value that `CurrentLimit` and `HoldingCurrentLimit` can be set to.

	*   Reference your controller's User Guide for more information about how the `HoldingCurrentLimit` and `CurrentLimit` can be used in your application.

	- returns:
	The current limit

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxCurrentLimit() throws -> Double {
		let result: PhidgetReturnCode
		var maxCurrentLimit: Double = 0
		result = PhidgetStepper_getMaxCurrentLimit(chandle, &maxCurrentLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxCurrentLimit
	}

	/**
	The `DataInterval` is the time that must elapse before the controller will fire another `PositionChange`/`VelocityChange` event.

	*   The data interval is bounded by `MinDataInterval` and `MaxDataInterval`.

	- returns:
	The data interval value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getDataInterval() throws -> UInt32 {
		let result: PhidgetReturnCode
		var dataInterval: UInt32 = 0
		result = PhidgetStepper_getDataInterval(chandle, &dataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return dataInterval
	}

	/**
	The `DataInterval` is the time that must elapse before the controller will fire another `PositionChange`/`VelocityChange` event.

	*   The data interval is bounded by `MinDataInterval` and `MaxDataInterval`.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- dataInterval: The data interval value
	*/
	public func setDataInterval(_ dataInterval: UInt32) throws {
		let result: PhidgetReturnCode
		result = PhidgetStepper_setDataInterval(chandle, dataInterval)
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
		result = PhidgetStepper_getMinDataInterval(chandle, &minDataInterval)
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
		result = PhidgetStepper_getMaxDataInterval(chandle, &maxDataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxDataInterval
	}

	/**
	When this property is true, the controller will supply power to the motor coils.

	*   The controller must be `Engaged` in order to move the Stepper motor, or have it hold position.

	- returns:
	The engaged state

	- throws:
	An error or type `PhidgetError`
	*/
	public func getEngaged() throws -> Bool {
		let result: PhidgetReturnCode
		var engaged: Int32 = 0
		result = PhidgetStepper_getEngaged(chandle, &engaged)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return (engaged == 0 ? false : true)
	}

	/**
	When this property is true, the controller will supply power to the motor coils.

	*   The controller must be `Engaged` in order to move the Stepper motor, or have it hold position.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- engaged: The engaged state
	*/
	public func setEngaged(_ engaged: Bool) throws {
		let result: PhidgetReturnCode
		result = PhidgetStepper_setEngaged(chandle, (engaged ? 1 : 0))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The `HoldingCurrentLimit` will activate when the `TargetPosition` has been reached. It will limit current through the motor.

	*   When the motor is not stopped, the current through the motor is limited by the `CurrentLimit`.
	*   If no `HoldingCurrentLimit` is specified, the `CurrentLimit` value will persist when the motor is stopped.
	*   Reference your controller's User Guide for more information about how the `HoldingCurrentLimit` and `CurrentLimit` can be used in your application.

	- returns:
	The current value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getHoldingCurrentLimit() throws -> Double {
		let result: PhidgetReturnCode
		var holdingCurrentLimit: Double = 0
		result = PhidgetStepper_getHoldingCurrentLimit(chandle, &holdingCurrentLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return holdingCurrentLimit
	}

	/**
	The `HoldingCurrentLimit` will activate when the `TargetPosition` has been reached. It will limit current through the motor.

	*   When the motor is not stopped, the current through the motor is limited by the `CurrentLimit`.
	*   If no `HoldingCurrentLimit` is specified, the `CurrentLimit` value will persist when the motor is stopped.
	*   Reference your controller's User Guide for more information about how the `HoldingCurrentLimit` and `CurrentLimit` can be used in your application.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- holdingCurrentLimit: The current value
	*/
	public func setHoldingCurrentLimit(_ holdingCurrentLimit: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetStepper_setHoldingCurrentLimit(chandle, holdingCurrentLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	`IsMoving` returns true while the controller is sending commands to the motor. Note: there is no feedback to the controller, so it does not know whether the motor shaft is actually moving or not.

	- returns:
	The moving state

	- throws:
	An error or type `PhidgetError`
	*/
	public func getIsMoving() throws -> Bool {
		let result: PhidgetReturnCode
		var isMoving: Int32 = 0
		result = PhidgetStepper_getIsMoving(chandle, &isMoving)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return (isMoving == 0 ? false : true)
	}

	/**
	The most recent position value that the controller has reported.

	*   This value will always be between `MinPosition` and `MaxPosition`.
	*   Units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The position value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getPosition() throws -> Double {
		let result: PhidgetReturnCode
		var position: Double = 0
		result = PhidgetStepper_getPosition(chandle, &position)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return position
	}

	/**
	The minimum value that `TargetPosition` can be set to.

	*   Units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The position value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinPosition() throws -> Double {
		let result: PhidgetReturnCode
		var minPosition: Double = 0
		result = PhidgetStepper_getMinPosition(chandle, &minPosition)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minPosition
	}

	/**
	The maximum value that `TargetPosition` can be set to.

	*   Units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The position value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxPosition() throws -> Double {
		let result: PhidgetReturnCode
		var maxPosition: Double = 0
		result = PhidgetStepper_getMaxPosition(chandle, &maxPosition)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxPosition
	}

	/**
	Adds an offset (positive or negative) to the current position and target position.

	*   This is especially useful for zeroing position.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- positionOffset: Amount to offset the position by
	*/
	public func addPositionOffset(positionOffset: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetStepper_addPositionOffset(chandle, positionOffset)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	Applies a factor to the \[user units\] per step to all movement parameters to make the units in your application is more intuitive.

	*   For example, starting from position 0 and setting a new position with a rescale factor, the stepper will move `Position` / `RescaleFactor` steps.
	*   In this way, units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The rescale factor value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getRescaleFactor() throws -> Double {
		let result: PhidgetReturnCode
		var rescaleFactor: Double = 0
		result = PhidgetStepper_getRescaleFactor(chandle, &rescaleFactor)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return rescaleFactor
	}

	/**
	Applies a factor to the \[user units\] per step to all movement parameters to make the units in your application is more intuitive.

	*   For example, starting from position 0 and setting a new position with a rescale factor, the stepper will move `Position` / `RescaleFactor` steps.
	*   In this way, units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- rescaleFactor: The rescale factor value
	*/
	public func setRescaleFactor(_ rescaleFactor: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetStepper_setRescaleFactor(chandle, rescaleFactor)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	If the controller is configured and the `TargetPosition` is set, the Stepper motor will move towards the `TargetPosition` at the specified `Acceleration` and `Velocity`.

	*   `TargetPosition` is only used when the `ControlMode` is set to step mode.
	*   Units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The position value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getTargetPosition() throws -> Double {
		let result: PhidgetReturnCode
		var targetPosition: Double = 0
		result = PhidgetStepper_getTargetPosition(chandle, &targetPosition)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return targetPosition
	}

	/**
	If the controller is configured and the `TargetPosition` is set, the Stepper motor will move towards the `TargetPosition` at the specified `Acceleration` and `Velocity`.

	*   `TargetPosition` is only used when the `ControlMode` is set to step mode.
	*   Units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- targetPosition: The position value
	*/
	public func setTargetPosition(_ targetPosition: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetStepper_setTargetPosition(chandle, targetPosition)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	If the controller is configured and the `TargetPosition` is set, the Stepper motor will move towards the `TargetPosition` at the specified `Acceleration` and `Velocity`.

	*   `TargetPosition` is only used when the `ControlMode` is set to step mode.
	*   Units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- parameters:
		- targetPosition: The position value
		- completion: Asynchronous completion callback
	*/
	public func setTargetPosition(_ targetPosition: Double, completion: @escaping (ErrorCode) -> ()) {
		let callback = AsyncCallback(completion)
		let callbackCtx = Unmanaged.passRetained(callback)
		PhidgetStepper_setTargetPosition_async(chandle, targetPosition, AsyncCallback.nativeAsyncCallback, UnsafeMutableRawPointer(callbackCtx.toOpaque()))
	}

	/**
	The most recent velocity value that the controller has reported.

	*   This value is bounded by `MinVelocityLimit` and `MaxVelocityLimit`.
	*   Units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The velocity value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getVelocity() throws -> Double {
		let result: PhidgetReturnCode
		var velocity: Double = 0
		result = PhidgetStepper_getVelocity(chandle, &velocity)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return velocity
	}

	/**
	When moving, the Stepper motor velocity will be limited by this value.

	*   The `VelocityLimit` is bounded by `MinVelocityLimit` and `MaxVelocityLimit`.
	*   When in step mode, the `MinVelocityLimit` has a value of 0. This is because the sign (±) of the `TargetPosition` will indicate the direction.
	*   When in run mode, the `MinVelocityLimit` has a value of -`MaxVelocityLimit`. This is because there is no target position, so the direction is defined by the sign (±) of the `VelocityLimit`.
	*   Units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	Velocity limit

	- throws:
	An error or type `PhidgetError`
	*/
	public func getVelocityLimit() throws -> Double {
		let result: PhidgetReturnCode
		var velocityLimit: Double = 0
		result = PhidgetStepper_getVelocityLimit(chandle, &velocityLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return velocityLimit
	}

	/**
	When moving, the Stepper motor velocity will be limited by this value.

	*   The `VelocityLimit` is bounded by `MinVelocityLimit` and `MaxVelocityLimit`.
	*   When in step mode, the `MinVelocityLimit` has a value of 0. This is because the sign (±) of the `TargetPosition` will indicate the direction.
	*   When in run mode, the `MinVelocityLimit` has a value of -`MaxVelocityLimit`. This is because there is no target position, so the direction is defined by the sign (±) of the `VelocityLimit`.
	*   Units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- velocityLimit: Velocity limit
	*/
	public func setVelocityLimit(_ velocityLimit: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetStepper_setVelocityLimit(chandle, velocityLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `VelocityLimit` can be set to.

	*   Units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The velocity limit value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinVelocityLimit() throws -> Double {
		let result: PhidgetReturnCode
		var minVelocityLimit: Double = 0
		result = PhidgetStepper_getMinVelocityLimit(chandle, &minVelocityLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minVelocityLimit
	}

	/**
	The maximum value that `VelocityLimit` can be set to.

	*   Units for `Position`, `Velocity`, and `Acceleration` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The velocity value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxVelocityLimit() throws -> Double {
		let result: PhidgetReturnCode
		var maxVelocityLimit: Double = 0
		result = PhidgetStepper_getMaxVelocityLimit(chandle, &maxVelocityLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxVelocityLimit
	}

	internal override func initializeEvents() {
		initializeBaseEvents()
		PhidgetStepper_setOnPositionChangeHandler(chandle, nativePositionChangeHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
		PhidgetStepper_setOnStoppedHandler(chandle, nativeStoppedHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
		PhidgetStepper_setOnVelocityChangeHandler(chandle, nativeVelocityChangeHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
	}

	internal override func uninitializeEvents() {
		uninitializeBaseEvents()
		PhidgetStepper_setOnPositionChangeHandler(chandle, nil, nil)
		PhidgetStepper_setOnStoppedHandler(chandle, nil, nil)
		PhidgetStepper_setOnVelocityChangeHandler(chandle, nil, nil)
	}

	/**
	Occurs when the controller updates the stepper motor position.

	*   This event will still fire even if the motor is blocked from physically moving or misses steps.

	---
	## Parameters:
	*   `position`: The current stepper position
	*/
	public let positionChange = Event<Stepper, Double> ()
	let nativePositionChangeHandler : PhidgetStepper_OnPositionChangeCallback = { ch, ctx, position in
		let me = Unmanaged<Stepper>.fromOpaque(ctx!).takeUnretainedValue()
		me.positionChange.raise(me, position);
	}

	/**
	Occurs when the motor controller stops.

	*   The motor may still be physically moving if the inertia is great enough to make it misstep.
	*/
	public let stopped = SimpleEvent<Stepper> ()
	let nativeStoppedHandler : PhidgetStepper_OnStoppedCallback = { ch, ctx in
		let me = Unmanaged<Stepper>.fromOpaque(ctx!).takeUnretainedValue()
		me.stopped.raise(me);
	}

	/**
	Occurs when the stepper motor velocity changes.

	---
	## Parameters:
	*   `velocity`: Velocity of the stepper. Sign indicates direction.
	*/
	public let velocityChange = Event<Stepper, Double> ()
	let nativeVelocityChangeHandler : PhidgetStepper_OnVelocityChangeCallback = { ch, ctx, velocity in
		let me = Unmanaged<Stepper>.fromOpaque(ctx!).takeUnretainedValue()
		me.velocityChange.raise(me, velocity);
	}

}
