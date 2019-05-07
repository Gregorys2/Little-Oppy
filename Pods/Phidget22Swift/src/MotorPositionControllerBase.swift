import Foundation
import Phidget22_C

/**
The Motor Position Controller class controlls the position, velocity and acceleration of the attached motor. It also contains various other control and monitoring functions that aid in the control of the motor.

For specifics on how to use this class, we recommend watching our video on the [Phidget Motor Position Controller](https://www.youtube.com/watch?v=zI0DJgnzSUw&t=43s) class.
*/
public class MotorPositionControllerBase : Phidget {

	public init() {
		var h: PhidgetHandle?
		PhidgetMotorPositionController_create(&h)
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
			PhidgetMotorPositionController_delete(&chandle)
		}
	}

	/**
	The rate at which the controller can change the motor's velocity.

	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The acceleration value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getAcceleration() throws -> Double {
		let result: PhidgetReturnCode
		var acceleration: Double = 0
		result = PhidgetMotorPositionController_getAcceleration(chandle, &acceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return acceleration
	}

	/**
	The rate at which the controller can change the motor's velocity.

	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- acceleration: The acceleration value
	*/
	public func setAcceleration(_ acceleration: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetMotorPositionController_setAcceleration(chandle, acceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `Acceleration` can be set to.

	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The acceleration value.

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinAcceleration() throws -> Double {
		let result: PhidgetReturnCode
		var minAcceleration: Double = 0
		result = PhidgetMotorPositionController_getMinAcceleration(chandle, &minAcceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minAcceleration
	}

	/**
	The maximum value that `Acceleration` can be set to.

	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The acceleration value.

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxAcceleration() throws -> Double {
		let result: PhidgetReturnCode
		var maxAcceleration: Double = 0
		result = PhidgetMotorPositionController_getMaxAcceleration(chandle, &maxAcceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxAcceleration
	}

	/**
	The controller will limit the current through the motor to this value.

	- returns:
	Motor current limit

	- throws:
	An error or type `PhidgetError`
	*/
	public func getCurrentLimit() throws -> Double {
		let result: PhidgetReturnCode
		var currentLimit: Double = 0
		result = PhidgetMotorPositionController_getCurrentLimit(chandle, &currentLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return currentLimit
	}

	/**
	The controller will limit the current through the motor to this value.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- currentLimit: Motor current limit
	*/
	public func setCurrentLimit(_ currentLimit: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetMotorPositionController_setCurrentLimit(chandle, currentLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum current limit that can be set for the device.

	- returns:
	Minimum current limit

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinCurrentLimit() throws -> Double {
		let result: PhidgetReturnCode
		var minCurrentLimit: Double = 0
		result = PhidgetMotorPositionController_getMinCurrentLimit(chandle, &minCurrentLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minCurrentLimit
	}

	/**
	The maximum current limit that can be set for the device.

	- returns:
	Maximum current limit

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxCurrentLimit() throws -> Double {
		let result: PhidgetReturnCode
		var maxCurrentLimit: Double = 0
		result = PhidgetMotorPositionController_getMaxCurrentLimit(chandle, &maxCurrentLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxCurrentLimit
	}

	/**
	Depending on power supply voltage and motor coil inductance, current through the motor can change relatively slowly or extremely rapidly. A physically larger DC Motor will typically have a lower inductance, requiring a higher current regulator gain. A higher power supply voltage will result in motor current changing more rapidly, requiring a higher current regulator gain. If the current regulator gain is too small, spikes in current will occur, causing large variations in torque, and possibly damaging the motor controller. If the current regulator gain is too high, the current will jitter, causing the motor to sound 'rough', especially when changing directions. Each DC Motor we sell specifies a suitable current regulator gain.

	- returns:
	Current Regulator Gain

	- throws:
	An error or type `PhidgetError`
	*/
	public func getCurrentRegulatorGain() throws -> Double {
		let result: PhidgetReturnCode
		var currentRegulatorGain: Double = 0
		result = PhidgetMotorPositionController_getCurrentRegulatorGain(chandle, &currentRegulatorGain)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return currentRegulatorGain
	}

	/**
	Depending on power supply voltage and motor coil inductance, current through the motor can change relatively slowly or extremely rapidly. A physically larger DC Motor will typically have a lower inductance, requiring a higher current regulator gain. A higher power supply voltage will result in motor current changing more rapidly, requiring a higher current regulator gain. If the current regulator gain is too small, spikes in current will occur, causing large variations in torque, and possibly damaging the motor controller. If the current regulator gain is too high, the current will jitter, causing the motor to sound 'rough', especially when changing directions. Each DC Motor we sell specifies a suitable current regulator gain.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- currentRegulatorGain: Current Regulator Gain
	*/
	public func setCurrentRegulatorGain(_ currentRegulatorGain: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetMotorPositionController_setCurrentRegulatorGain(chandle, currentRegulatorGain)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum current regulator gain for the device.

	- returns:
	Minimum current regulator gain

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinCurrentRegulatorGain() throws -> Double {
		let result: PhidgetReturnCode
		var minCurrentRegulatorGain: Double = 0
		result = PhidgetMotorPositionController_getMinCurrentRegulatorGain(chandle, &minCurrentRegulatorGain)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minCurrentRegulatorGain
	}

	/**
	The maximum current regulator gain for the device.

	- returns:
	Maximum current regulator gain

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxCurrentRegulatorGain() throws -> Double {
		let result: PhidgetReturnCode
		var maxCurrentRegulatorGain: Double = 0
		result = PhidgetMotorPositionController_getMaxCurrentRegulatorGain(chandle, &maxCurrentRegulatorGain)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxCurrentRegulatorGain
	}

	/**
	The `DataInterval` is the time that must elapse before the controller will fire another `CurrentChange` event.

	*   The data interval is bounded by `MinDataInterval` and `MaxDataInterval`.
	*   The timing between `CurrentChange` events can also affected by the `CurrentChangeTrigger`.

	- returns:
	The data interval value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getDataInterval() throws -> UInt32 {
		let result: PhidgetReturnCode
		var dataInterval: UInt32 = 0
		result = PhidgetMotorPositionController_getDataInterval(chandle, &dataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return dataInterval
	}

	/**
	The `DataInterval` is the time that must elapse before the controller will fire another `CurrentChange` event.

	*   The data interval is bounded by `MinDataInterval` and `MaxDataInterval`.
	*   The timing between `CurrentChange` events can also affected by the `CurrentChangeTrigger`.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- dataInterval: The data interval value
	*/
	public func setDataInterval(_ dataInterval: UInt32) throws {
		let result: PhidgetReturnCode
		result = PhidgetMotorPositionController_setDataInterval(chandle, dataInterval)
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
		result = PhidgetMotorPositionController_getMinDataInterval(chandle, &minDataInterval)
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
		result = PhidgetMotorPositionController_getMaxDataInterval(chandle, &maxDataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxDataInterval
	}

	/**
	Depending on your system, it may not be possible to bring the position error (`TargetPosition` \- `Position`) to zero. A small error can lead to the motor continually 'hunting' for a target position, which can cause unwanted effects. By setting a non-zero `DeadBand`, the position controller will relax control of the motor within the deadband, preventing the 'hunting' behavior.

	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The dead band value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getDeadBand() throws -> Double {
		let result: PhidgetReturnCode
		var deadBand: Double = 0
		result = PhidgetMotorPositionController_getDeadBand(chandle, &deadBand)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return deadBand
	}

	/**
	Depending on your system, it may not be possible to bring the position error (`TargetPosition` \- `Position`) to zero. A small error can lead to the motor continually 'hunting' for a target position, which can cause unwanted effects. By setting a non-zero `DeadBand`, the position controller will relax control of the motor within the deadband, preventing the 'hunting' behavior.

	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- deadBand: The dead band value
	*/
	public func setDeadBand(_ deadBand: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetMotorPositionController_setDeadBand(chandle, deadBand)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The most recent duty cycle value that the controller has reported.

	*   This value will be between -1 and 1 where a sign change (±) is indicitave of a direction change.
	*   Note that `DutyCycle` is merely an indication of the average voltage across the motor. At a constant load, an increase in `DutyCycle` indicates an increase in motor speed.
	*   The units of `DutyCycle` refer to 'duty cycle'. This is because the controller must rapidly switch the power on/off (i.e. change the duty cycle) in order to manipulate the voltage across the motor.

	- returns:
	The duty cycle value.

	- throws:
	An error or type `PhidgetError`
	*/
	public func getDutyCycle() throws -> Double {
		let result: PhidgetReturnCode
		var dutyCycle: Double = 0
		result = PhidgetMotorPositionController_getDutyCycle(chandle, &dutyCycle)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return dutyCycle
	}

	/**
	When engaged, a motor has the ability to be positioned. When disengaged, no commands are sent to the motor.

	*   This function is useful for completely relaxing a motor once it has reached the target position.

	- returns:
	The engaged value.

	- throws:
	An error or type `PhidgetError`
	*/
	public func getEngaged() throws -> Bool {
		let result: PhidgetReturnCode
		var engaged: Int32 = 0
		result = PhidgetMotorPositionController_getEngaged(chandle, &engaged)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return (engaged == 0 ? false : true)
	}

	/**
	When engaged, a motor has the ability to be positioned. When disengaged, no commands are sent to the motor.

	*   This function is useful for completely relaxing a motor once it has reached the target position.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- engaged: The engaged value.
	*/
	public func setEngaged(_ engaged: Bool) throws {
		let result: PhidgetReturnCode
		result = PhidgetMotorPositionController_setEngaged(chandle, (engaged ? 1 : 0))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
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
		result = PhidgetMotorPositionController_getFanMode(chandle, &fanMode)
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
		result = PhidgetMotorPositionController_setFanMode(chandle, Phidget_FanMode(fanMode.rawValue))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The encoder interface mode. Match the mode to the type of encoder you have attached.

	*   It is recommended to only change this when the encoder disabled in order to avoid unexpected results.

	- returns:
	The IO mode value.

	- throws:
	An error or type `PhidgetError`
	*/
	public func getIOMode() throws -> EncoderIOMode {
		let result: PhidgetReturnCode
		var iOMode: Phidget_EncoderIOMode = ENCODER_IO_MODE_PUSH_PULL
		result = PhidgetMotorPositionController_getIOMode(chandle, &iOMode)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return EncoderIOMode(rawValue: iOMode.rawValue)!
	}

	/**
	The encoder interface mode. Match the mode to the type of encoder you have attached.

	*   It is recommended to only change this when the encoder disabled in order to avoid unexpected results.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- IOMode: The IO mode value.
	*/
	public func setIOMode(_ IOMode: EncoderIOMode) throws {
		let result: PhidgetReturnCode
		result = PhidgetMotorPositionController_setIOMode(chandle, Phidget_EncoderIOMode(IOMode.rawValue))
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	Derivative gain constant. A higher `Kd` will help reduce oscillations.

	- returns:
	The Kd value.

	- throws:
	An error or type `PhidgetError`
	*/
	public func getKd() throws -> Double {
		let result: PhidgetReturnCode
		var kd: Double = 0
		result = PhidgetMotorPositionController_getKd(chandle, &kd)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return kd
	}

	/**
	Derivative gain constant. A higher `Kd` will help reduce oscillations.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- kd: The Kd value.
	*/
	public func setKd(_ kd: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetMotorPositionController_setKd(chandle, kd)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	Integral gain constant. The integral term will help eliminate steady-state error.

	- returns:
	The Ki value.

	- throws:
	An error or type `PhidgetError`
	*/
	public func getKi() throws -> Double {
		let result: PhidgetReturnCode
		var ki: Double = 0
		result = PhidgetMotorPositionController_getKi(chandle, &ki)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return ki
	}

	/**
	Integral gain constant. The integral term will help eliminate steady-state error.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- ki: The Ki value.
	*/
	public func setKi(_ ki: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetMotorPositionController_setKi(chandle, ki)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	Proportional gain constant. A small `Kp` value will result in a less responsive controller, however, if `Kp` is too high, the system can become unstable.

	- returns:
	The Kp value.

	- throws:
	An error or type `PhidgetError`
	*/
	public func getKp() throws -> Double {
		let result: PhidgetReturnCode
		var kp: Double = 0
		result = PhidgetMotorPositionController_getKp(chandle, &kp)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return kp
	}

	/**
	Proportional gain constant. A small `Kp` value will result in a less responsive controller, however, if `Kp` is too high, the system can become unstable.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- kp: The Kp value.
	*/
	public func setKp(_ kp: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetMotorPositionController_setKp(chandle, kp)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The most recent position value that the controller has reported.

	*   This value will always be between `MinPosition` and `MaxPosition`.
	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The position value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getPosition() throws -> Double {
		let result: PhidgetReturnCode
		var position: Double = 0
		result = PhidgetMotorPositionController_getPosition(chandle, &position)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return position
	}

	/**
	The minimum value that `TargetPosition` can be set to.

	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The position value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinPosition() throws -> Double {
		let result: PhidgetReturnCode
		var minPosition: Double = 0
		result = PhidgetMotorPositionController_getMinPosition(chandle, &minPosition)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minPosition
	}

	/**
	The maximum value that `TargetPosition` can be set to.

	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The position value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxPosition() throws -> Double {
		let result: PhidgetReturnCode
		var maxPosition: Double = 0
		result = PhidgetMotorPositionController_getMaxPosition(chandle, &maxPosition)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxPosition
	}

	/**
	Adds an offset (positive or negative) to the current position. Useful for zeroing position.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- positionOffset: Amount to offset the position by
	*/
	public func addPositionOffset(positionOffset: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetMotorPositionController_addPositionOffset(chandle, positionOffset)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	Change the units of your parameters so that your application is more intuitive.

	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The rescale factor value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getRescaleFactor() throws -> Double {
		let result: PhidgetReturnCode
		var rescaleFactor: Double = 0
		result = PhidgetMotorPositionController_getRescaleFactor(chandle, &rescaleFactor)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return rescaleFactor
	}

	/**
	Change the units of your parameters so that your application is more intuitive.

	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- rescaleFactor: The rescale factor value
	*/
	public func setRescaleFactor(_ rescaleFactor: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetMotorPositionController_setRescaleFactor(chandle, rescaleFactor)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	Before reading this description, it is important to note the difference between the units of `StallVelocity` and `Velocity`.

	*   `Velocity` is a number between -1 and 1 with units of 'duty cycle'. It simply represents the average voltage across the motor.
	*   `StallVelocity` represents a real velocity (e.g. m/s, RPM, etc.) and the units are determined by the `RescaleFactor`. With a `RescaleFactor` of 1, the default units would be in commutations per second.

	If the load on your motor is large, your motor may begin rotating more slowly, or even fully stall. Depending on the voltage across your motor, this may result in a large amount of current through both the controller and the motor. In order to prevent damage in these situations, you can use the `StallVelocity` property.  
	  
	The `StallVelocity` should be set to the lowest velocity you would expect from your motor. The controller will then monitor the motor's velocity, as well as the `Velocity`, and prevent a 'dangerous stall' from occuring. If the controller detects a dangerous stall, it will immediately disengage the motor (i.e. `Engaged` will be set to false) and an error will be reported to your program.

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
		result = PhidgetMotorPositionController_getStallVelocity(chandle, &stallVelocity)
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
	  
	The `StallVelocity` should be set to the lowest velocity you would expect from your motor. The controller will then monitor the motor's velocity, as well as the `Velocity`, and prevent a 'dangerous stall' from occuring. If the controller detects a dangerous stall, it will immediately disengage the motor (i.e. `Engaged` will be set to false) and an error will be reported to your program.

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
		result = PhidgetMotorPositionController_setStallVelocity(chandle, stallVelocity)
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
		result = PhidgetMotorPositionController_getMinStallVelocity(chandle, &minStallVelocity)
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
		result = PhidgetMotorPositionController_getMaxStallVelocity(chandle, &maxStallVelocity)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxStallVelocity
	}

	/**
	If the controller is configured and the `TargetPosition` is set, the motor will try to reach the `TargetPostiion`.

	*   If the `DeadBand` is non-zero, the final position of the motor may not match the `TargetPosition`
	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The position value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getTargetPosition() throws -> Double {
		let result: PhidgetReturnCode
		var targetPosition: Double = 0
		result = PhidgetMotorPositionController_getTargetPosition(chandle, &targetPosition)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return targetPosition
	}

	/**
	If the controller is configured and the `TargetPosition` is set, the motor will try to reach the `TargetPostiion`.

	*   If the `DeadBand` is non-zero, the final position of the motor may not match the `TargetPosition`
	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- parameters:
		- targetPosition: The position value
		- completion: Asynchronous completion callback
	*/
	public func setTargetPosition(_ targetPosition: Double, completion: @escaping (ErrorCode) -> ()) {
		let callback = AsyncCallback(completion)
		let callbackCtx = Unmanaged.passRetained(callback)
		PhidgetMotorPositionController_setTargetPosition_async(chandle, targetPosition, AsyncCallback.nativeAsyncCallback, UnsafeMutableRawPointer(callbackCtx.toOpaque()))
	}

	/**
	If the controller is configured and the `TargetPosition` is set, the motor will try to reach the `TargetPostiion`.

	*   If the `DeadBand` is non-zero, the final position of the motor may not match the `TargetPosition`
	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- targetPosition: The position value
	*/
	public func setTargetPosition(_ targetPosition: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetMotorPositionController_setTargetPosition(chandle, targetPosition)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	When moving, the motor velocity will be limited by this value.

	*   `VelocityLimit` is bounded by `MinVelocityLimit` and `MaxVelocityLimit`.
	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The velocity value.

	- throws:
	An error or type `PhidgetError`
	*/
	public func getVelocityLimit() throws -> Double {
		let result: PhidgetReturnCode
		var velocityLimit: Double = 0
		result = PhidgetMotorPositionController_getVelocityLimit(chandle, &velocityLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return velocityLimit
	}

	/**
	When moving, the motor velocity will be limited by this value.

	*   `VelocityLimit` is bounded by `MinVelocityLimit` and `MaxVelocityLimit`.
	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- velocityLimit: The velocity value.
	*/
	public func setVelocityLimit(_ velocityLimit: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetMotorPositionController_setVelocityLimit(chandle, velocityLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `VelocityLimit` can be set to.

	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The velocity value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinVelocityLimit() throws -> Double {
		let result: PhidgetReturnCode
		var minVelocityLimit: Double = 0
		result = PhidgetMotorPositionController_getMinVelocityLimit(chandle, &minVelocityLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minVelocityLimit
	}

	/**
	The maximum value that `VelocityLimit` can be set to.

	*   Units for `Position`, `VelocityLimit`, `Acceleration`, and `DeadBand` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	- returns:
	The velocity value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxVelocityLimit() throws -> Double {
		let result: PhidgetReturnCode
		var maxVelocityLimit: Double = 0
		result = PhidgetMotorPositionController_getMaxVelocityLimit(chandle, &maxVelocityLimit)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxVelocityLimit
	}

	internal override func initializeEvents() {
		initializeBaseEvents()
		PhidgetMotorPositionController_setOnDutyCycleUpdateHandler(chandle, nativeDutyCycleUpdateHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
		PhidgetMotorPositionController_setOnPositionChangeHandler(chandle, nativePositionChangeHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
	}

	internal override func uninitializeEvents() {
		uninitializeBaseEvents()
		PhidgetMotorPositionController_setOnDutyCycleUpdateHandler(chandle, nil, nil)
		PhidgetMotorPositionController_setOnPositionChangeHandler(chandle, nil, nil)
	}

	/**
	The most recent duty cycle value will be reported in this event, which occurs when the `DataInterval` has elapsed.

	*   This event will **always** occur when the `DataInterval` elapses. You can depend on this event for constant timing when implementing control loops in code. This is the last event to fire, giving you up-to-date access to all properties.

	---
	## Parameters:
	*   `dutyCycle`: The duty cycle value
	*/
	public let dutyCycleUpdate = Event<MotorPositionController, Double> ()
	let nativeDutyCycleUpdateHandler : PhidgetMotorPositionController_OnDutyCycleUpdateCallback = { ch, ctx, dutyCycle in
		let me = Unmanaged<MotorPositionController>.fromOpaque(ctx!).takeUnretainedValue()
		me.dutyCycleUpdate.raise(me, dutyCycle);
	}

	/**
	The most recent position value will be reported in this event, which occurs when the `DataInterval` has elapsed.

	*   Regardless of the `DataInterval`, this event will occur only when the position value has changed from the previous value reported.
	*   Units for `Position` can be set by the user through the `RescaleFactor`. The `RescaleFactor` allows you to use more intuitive units such as rotations, or degrees.

	---
	## Parameters:
	*   `position`: The position value
	*/
	public let positionChange = Event<MotorPositionController, Double> ()
	let nativePositionChangeHandler : PhidgetMotorPositionController_OnPositionChangeCallback = { ch, ctx, position in
		let me = Unmanaged<MotorPositionController>.fromOpaque(ctx!).takeUnretainedValue()
		me.positionChange.raise(me, position);
	}

}
