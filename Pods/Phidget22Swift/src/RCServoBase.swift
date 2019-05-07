import Foundation
import Phidget22_C

/**
The RC Servo class controls the signal being sent to the servo motors from the Phidget controller in order to control their position. This class provides control of the position, velocity, acceleration, and supply voltage of the attached servo.
*/
public class RCServoBase : Phidget {

	public init() {
		var h: PhidgetHandle?
		PhidgetRCServo_create(&h)
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
			PhidgetRCServo_delete(&chandle)
		}
	}

	/**
	When changing velocity, the RC servo motor will accelerate/decelerate at this rate.

	*   The acceleration is bounded by `MaxAcceleration` and `MinAcceleration`.
	*   `SpeedRampingState` controls whether or not the acceleration value is actually applied when trying to reach a target position.
	*   There is a practical limit on how fast your RC servo motor can accelerate. This is based on the load and physical design of the motor.
	*   The units for `Position`,`Velocity`, and `Acceleration` are configured by scaling the internal timing (set with `MinPulseWidth` and `MaxPulseWidth`) to a user specified range with `MinPosition` and `MaxPosition`.

	- returns:
	The acceleration value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getAcceleration() throws -> Double {
		let result: PhidgetReturnCode
		var acceleration: Double = 0
		result = PhidgetRCServo_getAcceleration(chandle, &acceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return acceleration
	}

	/**
	When changing velocity, the RC servo motor will accelerate/decelerate at this rate.

	*   The acceleration is bounded by `MaxAcceleration` and `MinAcceleration`.
	*   `SpeedRampingState` controls whether or not the acceleration value is actually applied when trying to reach a target position.
	*   There is a practical limit on how fast your RC servo motor can accelerate. This is based on the load and physical design of the motor.
	*   The units for `Position`,`Velocity`, and `Acceleration` are configured by scaling the internal timing (set with `MinPulseWidth` and `MaxPulseWidth`) to a user specified range with `MinPosition` and `MaxPosition`.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- acceleration: The acceleration value
	*/
	public func setAcceleration(_ acceleration: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetRCServo_setAcceleration(chandle, acceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `Acceleration` can be set to

	*   This value depends on `MinPosition`/`MaxPosition` and `MinPulseWidth`/`MaxPulseWidth`
	.

	- returns:
	The acceleration value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinAcceleration() throws -> Double {
		let result: PhidgetReturnCode
		var minAcceleration: Double = 0
		result = PhidgetRCServo_getMinAcceleration(chandle, &minAcceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minAcceleration
	}

	/**
	The maximum acceleration that `Acceleration` can be set to.

	*   This value depends on `MinPosition`/`MaxPosition` and `MinPulseWidth`/`MaxPulseWidth`.

	- returns:
	The acceleration value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxAcceleration() throws -> Double {
		let result: PhidgetReturnCode
		var maxAcceleration: Double = 0
		result = PhidgetRCServo_getMaxAcceleration(chandle, &maxAcceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxAcceleration
	}

	/**
	The `DataInterval` is the time that must elapse before the controller will fire another `PositionChange` event.

	*   The data interval is bounded by `MinDataInterval` and `MaxDataInterval`.

	- returns:
	The data interval value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getDataInterval() throws -> UInt32 {
		let result: PhidgetReturnCode
		var dataInterval: UInt32 = 0
		result = PhidgetRCServo_getDataInterval(chandle, &dataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return dataInterval
	}

	/**
	The `DataInterval` is the time that must elapse before the controller will fire another `PositionChange` event.

	*   The data interval is bounded by `MinDataInterval` and `MaxDataInterval`.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- dataInterval: The data interval value
	*/
	public func setDataInterval(_ dataInterval: UInt32) throws {
		let result: PhidgetReturnCode
		result = PhidgetRCServo_setDataInterval(chandle, dataInterval)
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
		result = PhidgetRCServo_getMinDataInterval(chandle, &minDataInterval)
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
		result = PhidgetRCServo_getMaxDataInterval(chandle, &maxDataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxDataInterval
	}

	/**
	When engaged, a RC servo motor has the ability to be positioned. When disengaged, no commands are sent to the RC servo motor.

	*   There is no position feedback to the controller, so the RC servo motor will immediately snap to the `TargetPosition` after being engaged from a disengaged state.
	*   This property is useful for relaxing a servo once it has reached a given position.
	*   If you are concerned about tracking position accurately, you should not disengage the motor while `IsMoving` is true.

	- returns:
	The engaged value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getEngaged() throws -> Bool {
		let result: PhidgetReturnCode
		var engaged: Int32 = 0
		result = PhidgetRCServo_getEngaged(chandle, &engaged)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return (engaged == 0 ? false : true)
	}

	/**
	When engaged, a RC servo motor has the ability to be positioned. When disengaged, no commands are sent to the RC servo motor.

	*   There is no position feedback to the controller, so the RC servo motor will immediately snap to the `TargetPosition` after being engaged from a disengaged state.
	*   This property is useful for relaxing a servo once it has reached a given position.
	*   If you are concerned about tracking position accurately, you should not disengage the motor while `IsMoving` is true.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- engaged: The engaged value
	*/
	public func setEngaged(_ engaged: Bool) throws {
		let result: PhidgetReturnCode
		result = PhidgetRCServo_setEngaged(chandle, (engaged ? 1 : 0))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	`IsMoving` returns true if the RC servo motor is currently in motion.

	*   The controller cannot know if the RC servo motor is physically moving. When < code > IsMoving is false, it simply means there are no commands in the pipeline to the RC servo motor.

	- returns:
	The moving value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getIsMoving() throws -> Bool {
		let result: PhidgetReturnCode
		var isMoving: Int32 = 0
		result = PhidgetRCServo_getIsMoving(chandle, &isMoving)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return (isMoving == 0 ? false : true)
	}

	/**
	The most recent position of the RC servo motor that the controller has reported.

	*   This value will always be between `MinPosition` and `MaxPosition`.

	- returns:
	The position value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getPosition() throws -> Double {
		let result: PhidgetReturnCode
		var position: Double = 0
		result = PhidgetRCServo_getPosition(chandle, &position)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return position
	}

	/**
	The minimum position that `TargetPosition` can be set to.

	*   The units for `Position`,`Velocity`, and `Acceleration` are configured by scaling the internal timing (set with `MinPulseWidth` and `MaxPulseWidth`) to a user specified range with `MinPosition` and `MaxPosition`.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- minPosition: The position value
	*/
	public func setMinPosition(_ minPosition: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetRCServo_setMinPosition(chandle, minPosition)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum position that `TargetPosition` can be set to.

	*   The units for `Position`,`Velocity`, and `Acceleration` are configured by scaling the internal timing (set with `MinPulseWidth` and `MaxPulseWidth`) to a user specified range with `MinPosition` and `MaxPosition`.

	- returns:
	The position value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinPosition() throws -> Double {
		let result: PhidgetReturnCode
		var minPosition: Double = 0
		result = PhidgetRCServo_getMinPosition(chandle, &minPosition)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minPosition
	}

	/**
	The maximum position `TargetPosition` can be set to.

	*   The units for `Position`,`Velocity`, and `Acceleration` are configured by scaling the internal timing (set with `MinPulseWidth` and `MaxPulseWidth`) to a user specified range with `MinPosition` and `MaxPosition`.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- maxPosition: The position value
	*/
	public func setMaxPosition(_ maxPosition: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetRCServo_setMaxPosition(chandle, maxPosition)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The maximum position `TargetPosition` can be set to.

	*   The units for `Position`,`Velocity`, and `Acceleration` are configured by scaling the internal timing (set with `MinPulseWidth` and `MaxPulseWidth`) to a user specified range with `MinPosition` and `MaxPosition`.

	- returns:
	The position value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxPosition() throws -> Double {
		let result: PhidgetReturnCode
		var maxPosition: Double = 0
		result = PhidgetRCServo_getMaxPosition(chandle, &maxPosition)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxPosition
	}

	/**
	The `MinPulseWidth` represents the minimum pulse width that your RC servo motor specifies.

	*   This value can be found in the data sheet of most RC servo motors.
	*   The units for `Position`,`Velocity`, and `Acceleration` are configured by scaling the internal timing (set with `MinPulseWidth` and `MaxPulseWidth`) to a user specified range with `MinPosition` and `MaxPosition`.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- minPulseWidth: The pulse width value
	*/
	public func setMinPulseWidth(_ minPulseWidth: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetRCServo_setMinPulseWidth(chandle, minPulseWidth)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The `MinPulseWidth` represents the minimum pulse width that your RC servo motor specifies.

	*   This value can be found in the data sheet of most RC servo motors.
	*   The units for `Position`,`Velocity`, and `Acceleration` are configured by scaling the internal timing (set with `MinPulseWidth` and `MaxPulseWidth`) to a user specified range with `MinPosition` and `MaxPosition`.

	- returns:
	The pulse width value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinPulseWidth() throws -> Double {
		let result: PhidgetReturnCode
		var minPulseWidth: Double = 0
		result = PhidgetRCServo_getMinPulseWidth(chandle, &minPulseWidth)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minPulseWidth
	}

	/**
	The `MaxPulseWidth` represents the maximum pulse width that your RC servo motor specifies.

	*   This value can be found in the data sheet of most RC servo motors.
	*   The units for `Position`,`Velocity`, and `Acceleration` are configured by scaling the internal timing (set with `MinPulseWidth` and `MaxPulseWidth`) to a user specified range with `MinPosition` and `MaxPosition`.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- maxPulseWidth: The pulse width value
	*/
	public func setMaxPulseWidth(_ maxPulseWidth: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetRCServo_setMaxPulseWidth(chandle, maxPulseWidth)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The `MaxPulseWidth` represents the maximum pulse width that your RC servo motor specifies.

	*   This value can be found in the data sheet of most RC servo motors.
	*   The units for `Position`,`Velocity`, and `Acceleration` are configured by scaling the internal timing (set with `MinPulseWidth` and `MaxPulseWidth`) to a user specified range with `MinPosition` and `MaxPosition`.

	- returns:
	The pulse width value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxPulseWidth() throws -> Double {
		let result: PhidgetReturnCode
		var maxPulseWidth: Double = 0
		result = PhidgetRCServo_getMaxPulseWidth(chandle, &maxPulseWidth)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxPulseWidth
	}

	/**
	The minimum pulse width that `MinPulseWidth` can be set to.

	- returns:
	The pulse width value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinPulseWidthLimit() throws -> Double {
		let result: PhidgetReturnCode
		var minPulseWidthLimit: Double = 0
		result = PhidgetRCServo_getMinPulseWidthLimit(chandle, &minPulseWidthLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minPulseWidthLimit
	}

	/**
	The maximum pulse width that `MaxPulseWidth` can be set to.

	- returns:
	The pulse width value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxPulseWidthLimit() throws -> Double {
		let result: PhidgetReturnCode
		var maxPulseWidthLimit: Double = 0
		result = PhidgetRCServo_getMaxPulseWidthLimit(chandle, &maxPulseWidthLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxPulseWidthLimit
	}

	/**
	When speed ramping state is enabled, the controller will take the `Acceleration` and `Velocity` properties into account when moving the RC servo motor, usually resulting in smooth motion. If speed ramping state is not enabled, the controller will simply set the RC servo motor to the requested position.

	- returns:
	The speed ramping state value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getSpeedRampingState() throws -> Bool {
		let result: PhidgetReturnCode
		var speedRampingState: Int32 = 0
		result = PhidgetRCServo_getSpeedRampingState(chandle, &speedRampingState)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return (speedRampingState == 0 ? false : true)
	}

	/**
	When speed ramping state is enabled, the controller will take the `Acceleration` and `Velocity` properties into account when moving the RC servo motor, usually resulting in smooth motion. If speed ramping state is not enabled, the controller will simply set the RC servo motor to the requested position.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- speedRampingState: The speed ramping state value
	*/
	public func setSpeedRampingState(_ speedRampingState: Bool) throws {
		let result: PhidgetReturnCode
		result = PhidgetRCServo_setSpeedRampingState(chandle, (speedRampingState ? 1 : 0))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	If the RC servo motor is configured and `TargetPosition` is set, the controller will continuously try to reach targeted position.

	*   The target position is bounded by `MinPosition` and `MaxPosition`.
	*   If the RC servo motor is not engaged, then the position cannot be read.
	*   The position can still be set while the RC servo motor is not engaged. Once engaged, the RC servo motor will snap to position, assuming it is not there already.
	*   The units for `Position`,`Velocity`, and `Acceleration` are configured by scaling the internal timing (set with `MinPulseWidth` and `MaxPulseWidth`) to a user specified range with `MinPosition` and `MaxPosition`.

	- returns:
	The position value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getTargetPosition() throws -> Double {
		let result: PhidgetReturnCode
		var targetPosition: Double = 0
		result = PhidgetRCServo_getTargetPosition(chandle, &targetPosition)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return targetPosition
	}

	/**
	If the RC servo motor is configured and `TargetPosition` is set, the controller will continuously try to reach targeted position.

	*   The target position is bounded by `MinPosition` and `MaxPosition`.
	*   If the RC servo motor is not engaged, then the position cannot be read.
	*   The position can still be set while the RC servo motor is not engaged. Once engaged, the RC servo motor will snap to position, assuming it is not there already.
	*   The units for `Position`,`Velocity`, and `Acceleration` are configured by scaling the internal timing (set with `MinPulseWidth` and `MaxPulseWidth`) to a user specified range with `MinPosition` and `MaxPosition`.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- targetPosition: The position value
	*/
	public func setTargetPosition(_ targetPosition: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetRCServo_setTargetPosition(chandle, targetPosition)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	If the RC servo motor is configured and `TargetPosition` is set, the controller will continuously try to reach targeted position.

	*   The target position is bounded by `MinPosition` and `MaxPosition`.
	*   If the RC servo motor is not engaged, then the position cannot be read.
	*   The position can still be set while the RC servo motor is not engaged. Once engaged, the RC servo motor will snap to position, assuming it is not there already.
	*   The units for `Position`,`Velocity`, and `Acceleration` are configured by scaling the internal timing (set with `MinPulseWidth` and `MaxPulseWidth`) to a user specified range with `MinPosition` and `MaxPosition`.

	- parameters:
		- targetPosition: The position value
		- completion: Asynchronous completion callback
	*/
	public func setTargetPosition(_ targetPosition: Double, completion: @escaping (ErrorCode) -> ()) {
		let callback = AsyncCallback(completion)
		let callbackCtx = Unmanaged.passRetained(callback)
		PhidgetRCServo_setTargetPosition_async(chandle, targetPosition, AsyncCallback.nativeAsyncCallback, UnsafeMutableRawPointer(callbackCtx.toOpaque()))
	}

	/**
	The `Torque` is a ratio of the maximum available torque.

	*   The torque is bounded by `MinTorque` and `MaxTorque`
	*   Increasing the torque will increase the speed and power consumption of the RC servo motor.

	- returns:
	The torque value.

	- throws:
	An error or type `PhidgetError`
	*/
	public func getTorque() throws -> Double {
		let result: PhidgetReturnCode
		var torque: Double = 0
		result = PhidgetRCServo_getTorque(chandle, &torque)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return torque
	}

	/**
	The `Torque` is a ratio of the maximum available torque.

	*   The torque is bounded by `MinTorque` and `MaxTorque`
	*   Increasing the torque will increase the speed and power consumption of the RC servo motor.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- torque: The torque value.
	*/
	public func setTorque(_ torque: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetRCServo_setTorque(chandle, torque)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `Torque` can be set to.

	*   `Torque` is a ratio of the maximum available torque, therefore the minimum torque is a unitless constant.

	- returns:
	The torque value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinTorque() throws -> Double {
		let result: PhidgetReturnCode
		var minTorque: Double = 0
		result = PhidgetRCServo_getMinTorque(chandle, &minTorque)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minTorque
	}

	/**
	The maximum value that `Torque` can be set to.

	*   `Torque` is a ratio of the maximum available torque, therefore the minimum torque is a unitless constant.

	- returns:
	The torque value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxTorque() throws -> Double {
		let result: PhidgetReturnCode
		var maxTorque: Double = 0
		result = PhidgetRCServo_getMaxTorque(chandle, &maxTorque)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxTorque
	}

	/**
	The velocity that the RC servo motor is being driven at.

	*   A negative value means the RC servo motor is moving towards a lower position.
	*   The velocity range of the RC servo motor will be from `-VelocityLimit` to `VelocityLimit`, depending on direction.
	*   This is not the actual physical velocity of the RC servo motor.

	- returns:
	The velocity value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getVelocity() throws -> Double {
		let result: PhidgetReturnCode
		var velocity: Double = 0
		result = PhidgetRCServo_getVelocity(chandle, &velocity)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return velocity
	}

	/**
	When moving, the RC servo motor velocity will be limited by this value.*   The velocity limit is bounded by `MinVelocityLimit` and `MaxVelocityLimit`.
	*   `SpeedRampingState` controls whether or not the velocity limit value is actually applied when trying to reach a target position.
	*   The velocity range of the RC servo motor will be from `-VelocityLimit` to `VelocityLimit`, depending on direction.
	*   Note that when this value is set to 0, the RC servo motor will not move.
	*   There is a practical limit on how fast your servo can rotate, based on the physical design of the motor.
	*   The units for `Position`,`Velocity`, and `Acceleration` are configured by scaling the internal timing (set with `MinPulseWidth` and `MaxPulseWidth`) to a user specified range with `MinPosition` and `MaxPosition`.

	- returns:
	The velocity value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getVelocityLimit() throws -> Double {
		let result: PhidgetReturnCode
		var velocityLimit: Double = 0
		result = PhidgetRCServo_getVelocityLimit(chandle, &velocityLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return velocityLimit
	}

	/**
	When moving, the RC servo motor velocity will be limited by this value.*   The velocity limit is bounded by `MinVelocityLimit` and `MaxVelocityLimit`.
	*   `SpeedRampingState` controls whether or not the velocity limit value is actually applied when trying to reach a target position.
	*   The velocity range of the RC servo motor will be from `-VelocityLimit` to `VelocityLimit`, depending on direction.
	*   Note that when this value is set to 0, the RC servo motor will not move.
	*   There is a practical limit on how fast your servo can rotate, based on the physical design of the motor.
	*   The units for `Position`,`Velocity`, and `Acceleration` are configured by scaling the internal timing (set with `MinPulseWidth` and `MaxPulseWidth`) to a user specified range with `MinPosition` and `MaxPosition`.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- velocityLimit: The velocity value
	*/
	public func setVelocityLimit(_ velocityLimit: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetRCServo_setVelocityLimit(chandle, velocityLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum velocity `VelocityLimit` can be set to.

	- returns:
	The velocity value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinVelocityLimit() throws -> Double {
		let result: PhidgetReturnCode
		var minVelocityLimit: Double = 0
		result = PhidgetRCServo_getMinVelocityLimit(chandle, &minVelocityLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minVelocityLimit
	}

	/**
	The maximum velocity `VelocityLimit` can be set to. This value depends on `MinPosition`/`MaxPosition` and `MinPulseWidth`/`MaxPulseWidth`.

	- returns:
	The velocity value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxVelocityLimit() throws -> Double {
		let result: PhidgetReturnCode
		var maxVelocityLimit: Double = 0
		result = PhidgetRCServo_getMaxVelocityLimit(chandle, &maxVelocityLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxVelocityLimit
	}

	/**
	The supply voltage for the RC servo motor.

	*   If your controller supports multiple RC servo motors, every motor will have the same supply voltage. It is not possible to set individual supply voltages.

	- returns:
	The voltage value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getVoltage() throws -> RCServoVoltage {
		let result: PhidgetReturnCode
		var voltage: PhidgetRCServo_Voltage = RCSERVO_VOLTAGE_5V
		result = PhidgetRCServo_getVoltage(chandle, &voltage)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return RCServoVoltage(rawValue: voltage.rawValue)!
	}

	/**
	The supply voltage for the RC servo motor.

	*   If your controller supports multiple RC servo motors, every motor will have the same supply voltage. It is not possible to set individual supply voltages.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- voltage: The voltage value
	*/
	public func setVoltage(_ voltage: RCServoVoltage) throws {
		let result: PhidgetReturnCode
		result = PhidgetRCServo_setVoltage(chandle, PhidgetRCServo_Voltage(voltage.rawValue))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	internal override func initializeEvents() {
		initializeBaseEvents()
		PhidgetRCServo_setOnPositionChangeHandler(chandle, nativePositionChangeHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
		PhidgetRCServo_setOnTargetPositionReachedHandler(chandle, nativeTargetPositionReachedHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
		PhidgetRCServo_setOnVelocityChangeHandler(chandle, nativeVelocityChangeHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
	}

	internal override func uninitializeEvents() {
		uninitializeBaseEvents()
		PhidgetRCServo_setOnPositionChangeHandler(chandle, nil, nil)
		PhidgetRCServo_setOnTargetPositionReachedHandler(chandle, nil, nil)
		PhidgetRCServo_setOnVelocityChangeHandler(chandle, nil, nil)
	}

	/**
	An event that occurs when the position changes on a RC servo motor.

	---
	## Parameters:
	*   `position`: The position value
	*/
	public let positionChange = Event<RCServo, Double> ()
	let nativePositionChangeHandler : PhidgetRCServo_OnPositionChangeCallback = { ch, ctx, position in
		let me = Unmanaged<RCServo>.fromOpaque(ctx!).takeUnretainedValue()
		me.positionChange.raise(me, position);
	}

	/**
	Occurs when the RC servo motor has reached the `TargetPosition`.

	*   The controller cannot know if the RC servo motor has physically reached the target position. When `TargetPosition` is reached, it simply means the controller pulse width output is matching its target.

	---
	## Parameters:
	*   `position`: The position value
	*/
	public let targetPositionReached = Event<RCServo, Double> ()
	let nativeTargetPositionReachedHandler : PhidgetRCServo_OnTargetPositionReachedCallback = { ch, ctx, position in
		let me = Unmanaged<RCServo>.fromOpaque(ctx!).takeUnretainedValue()
		me.targetPositionReached.raise(me, position);
	}

	/**
	An event that occurs when the velocity changes on a RC servo motor.

	---
	## Parameters:
	*   `velocity`: The velocity value
	*/
	public let velocityChange = Event<RCServo, Double> ()
	let nativeVelocityChangeHandler : PhidgetRCServo_OnVelocityChangeCallback = { ch, ctx, velocity in
		let me = Unmanaged<RCServo>.fromOpaque(ctx!).takeUnretainedValue()
		me.velocityChange.raise(me, velocity);
	}

}
