# TitaniumTestFight

An implementation of the TestFlight SDK for Titanium.

> If you are building the Android module, make sure you update the .classpath and build.properties files to match your setup.

## Usage

```javascript
var TestFlight = require('com.animecyc.testflight'),
    mainWindow = Ti.UI.createWindow({
        backgroundColor : 'white'
    });

TestFlight.takeOff('XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX');

mainWindow.open();
```

## Module Reference

### TestFlight.takeOff(accountToken, options);

Starts the TestFlight service

- accountToken (String):
	- The applications TestFlight application token
- options (Object):
	- An object containing the following:
		- options (Object):
			- inAppUpdates (Boolean)
			- flushInterval (Integer)
			- logonCheckpoint (Boolean)
			- logToStderr (Boolean)
			- reportCrashes (Boolean)
			- logOnlyOnCrash (Boolean)
			- sessionTimeout (Integer)
		- environment (Object)

> Android only supports the `sessionTimeout` option, everything else hasn't been implemented

### TestFlight.checkpoint(checkpointName);

Sends a checkpoint

- checkpointName (String):
	- The name of the checkpoint

### TestFlight.feedback(feedback);

Sends feeback information

> Android does not support this method as of yet; It is safe to call, it just won't do anything.

- feedback (String):
	- A feedback message

### TestFlight.log(message);

Sends log messages to TestFlight

- message (String):
	- A general log message

### TestFlight.getDebugging();

Returns the current debug status flag

*This method takes no paramters.*

### TestFlight.setDebugging(debug);

Sets the debug status flag

- debug (Boolean):
	- Debugging status flag