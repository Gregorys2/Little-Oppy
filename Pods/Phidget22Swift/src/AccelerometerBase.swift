import Foundation
import Phidget22_C

/**
The Accelerometer class is used to gather acceleration data from Phidget accelerometer boards. Phidget accelerometers usually have multiple sensors, each oriented in a different axis, so multiple dimensions of acceleration can be recorded.

If the Phidget you're using also has a gyroscope and a magnetometer, you may want to use the Spatial class in order to get all of the data at the same time, in a single event.
*/
public class AccelerometerBase : Phidget {

	public init() {
		var h: PhidgetHandle?
		PhidgetAccelerometer_create(&h)
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
			PhidgetAccelerometer_delete(&chandle)
		}
	}

	/**
	The most recent acceleration value that the channel has reported.

	*   This value will always be between `MinAcceleration` and `MaxAcceleration`.

	- returns:
	The acceleration values

	- throws:
	An error or type `PhidgetError`
	*/
	public func getAcceleration() throws -> [Double] {
		let result: PhidgetReturnCode
		var acceleration: (Double, Double, Double) = (0, 0, 0)
		result = PhidgetAccelerometer_getAcceleration(chandle, &acceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return [Double](UnsafeBufferPointer(start: &acceleration.0, count: 3))
	}

	/**
	The minimum value the `AccelerationChange` event will report.

	- returns:
	The minimum acceleration value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinAcceleration() throws -> [Double] {
		let result: PhidgetReturnCode
		var minAcceleration: (Double, Double, Double) = (0, 0, 0)
		result = PhidgetAccelerometer_getMinAcceleration(chandle, &minAcceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return [Double](UnsafeBufferPointer(start: &minAcceleration.0, count: 3))
	}

	/**
	The maximum value the `AccelerationChange` event will report.

	- returns:
	The maximum acceleration values

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxAcceleration() throws -> [Double] {
		let result: PhidgetReturnCode
		var maxAcceleration: (Double, Double, Double) = (0, 0, 0)
		result = PhidgetAccelerometer_getMaxAcceleration(chandle, &maxAcceleration)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return [Double](UnsafeBufferPointer(start: &maxAcceleration.0, count: 3))
	}

	/**
	The channel will not issue a `AccelerationChange` event until the acceleration value has changed by the amount specified by the `AccelerationChangeTrigger`.

	*   Setting the `AccelerationChangeTrigger` to 0 will result in the channel firing events every `DataInterval`. This is useful for applications that implement their own data filtering

	- returns:
	The change trigger value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getAccelerationChangeTrigger() throws -> Double {
		let result: PhidgetReturnCode
		var accelerationChangeTrigger: Double = 0
		result = PhidgetAccelerometer_getAccelerationChangeTrigger(chandle, &accelerationChangeTrigger)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return accelerationChangeTrigger
	}

	/**
	The channel will not issue a `AccelerationChange` event until the acceleration value has changed by the amount specified by the `AccelerationChangeTrigger`.

	*   Setting the `AccelerationChangeTrigger` to 0 will result in the channel firing events every `DataInterval`. This is useful for applications that implement their own data filtering

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- accelerationChangeTrigger: The change trigger value
	*/
	public func setAccelerationChangeTrigger(_ accelerationChangeTrigger: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetAccelerometer_setAccelerationChangeTrigger(chandle, accelerationChangeTrigger)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `AccelerationChangeTrigger` can be set to.

	- returns:
	The minimum change trigger value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinAccelerationChangeTrigger() throws -> Double {
		let result: PhidgetReturnCode
		var minAccelerationChangeTrigger: Double = 0
		result = PhidgetAccelerometer_getMinAccelerationChangeTrigger(chandle, &minAccelerationChangeTrigger)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minAccelerationChangeTrigger
	}

	/**
	The maximum value that `AccelerationChangeTrigger` can be set to.

	- returns:
	The maximum change trigger value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxAccelerationChangeTrigger() throws -> Double {
		let result: PhidgetReturnCode
		var maxAccelerationChangeTrigger: Double = 0
		result = PhidgetAccelerometer_getMaxAccelerationChangeTrigger(chandle, &maxAccelerationChangeTrigger)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxAccelerationChangeTrigger
	}

	/**
	The number of axes the channel can measure acceleration on.

	*   See your device's User Guide for more information about the number of axes and their orientation.

	- returns:
	The number of axes

	- throws:
	An error or type `PhidgetError`
	*/
	public func getAxisCount() throws -> Int {
		let result: PhidgetReturnCode
		var axisCount: Int32 = 0
		result = PhidgetAccelerometer_getAxisCount(chandle, &axisCount)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return Int(axisCount)
	}

	/**
	The `DataInterval` is the time that must elapse before the channel will fire another `AccelerationChange` event.

	*   The data interval is bounded by `MinDataInterval` and `MaxDataInterval`.
	*   The timing between `AccelerationChange` events can also affected by the `AccelerationChangeTrigger`.

	- returns:
	The data interval value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getDataInterval() throws -> UInt32 {
		let result: PhidgetReturnCode
		var dataInterval: UInt32 = 0
		result = PhidgetAccelerometer_getDataInterval(chandle, &dataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return dataInterval
	}

	/**
	The `DataInterval` is the time that must elapse before the channel will fire another `AccelerationChange` event.

	*   The data interval is bounded by `MinDataInterval` and `MaxDataInterval`.
	*   The timing between `AccelerationChange` events can also affected by the `AccelerationChangeTrigger`.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- dataInterval: The data interval value
	*/
	public func setDataInterval(_ dataInterval: UInt32) throws {
		let result: PhidgetReturnCode
		result = PhidgetAccelerometer_setDataInterval(chandle, dataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `DataInterval` can be set to.

	- returns:
	The minimum data interval value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinDataInterval() throws -> UInt32 {
		let result: PhidgetReturnCode
		var minDataInterval: UInt32 = 0
		result = PhidgetAccelerometer_getMinDataInterval(chandle, &minDataInterval)
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
		result = PhidgetAccelerometer_getMaxDataInterval(chandle, &maxDataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxDataInterval
	}

	/**
	The most recent timestamp value that the channel has reported. This is an extremely accurate time measurement streamed from the device.

	*   If your application requires a time measurement, you should use this value over a local software timestamp.

	- returns:
	The timestamp value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getTimestamp() throws -> Double {
		let result: PhidgetReturnCode
		var timestamp: Double = 0
		result = PhidgetAccelerometer_getTimestamp(chandle, &timestamp)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return timestamp
	}

	internal override func initializeEvents() {
		initializeBaseEvents()
		PhidgetAccelerometer_setOnAccelerationChangeHandler(chandle, nativeAccelerationChangeHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
	}

	internal override func uninitializeEvents() {
		uninitializeBaseEvents()
		PhidgetAccelerometer_setOnAccelerationChangeHandler(chandle, nil, nil)
	}

	/**
	The most recent acceleration values the channel has measured will be reported in this event, which occurs when the `DataInterval` has elapsed.

	*   If a `AccelerationChangeTrigger` has been set to a non-zero value, the `AccelerationChange` event will not occur until the acceleration has changed by at least the `AccelerationChangeTrigger` value.

	---
	## Parameters:
	*   `acceleration`: The acceleration values
	*   `timestamp`: The timestamp value
	*/
	public let accelerationChange = Event<Accelerometer, (acceleration: [Double], timestamp: Double)> ()
	let nativeAccelerationChangeHandler : PhidgetAccelerometer_OnAccelerationChangeCallback = { ch, ctx, acceleration, timestamp in
		let me = Unmanaged<Accelerometer>.fromOpaque(ctx!).takeUnretainedValue()
		me.accelerationChange.raise(me, ([Double](UnsafeBufferPointer(start: acceleration!, count: 3)), timestamp));
	}

}
