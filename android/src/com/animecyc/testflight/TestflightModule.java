/*
 * A TestFlight SDK implementation for Titanium
 *
 * Copyright (C) 2013 Seth Benjamin
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package com.animecyc.testflight;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.KrollModule;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.kroll.common.Log;
import org.appcelerator.titanium.TiApplication;
import org.appcelerator.titanium.util.TiConvert;

import com.testflightapp.lib.TestFlight;

@Kroll.module(name="Testflight", id="com.animecyc.testflight")
public class TestflightModule extends KrollModule
{
	private Boolean debugging = false;
	private Boolean didTakeOff = false;

	/**
	 * Creates a new instance of TestflightModule
	 */
	public TestflightModule()
	{
		super();
	}

	/**
	 * Log a debug message to the console
	 *
	 * @param String message
	 * @return void
	 */
	public void logDebug(String message)
	{
		if (debugging)
		{
			Log.d("TitaniumTestFlight", "TitaniumTestFlight ~> " + message);
		}
	}

	/**
	 * Message to log when grounded
	 *
	 * @return void
	 */
	@Kroll.method
	public void grounded()
	{
		logDebug("TestFlight has not been initialized.");
	}

	/**
	 * Setup TestFlight's takeOff method
	 *
	 * @param String applicationToken
	 * @param KrollDict options
	 * @return void
	 */
	@Kroll.method
	public void takeOff(String applicationToken, KrollDict options)
	{
		if (didTakeOff)
		{
			logDebug("Taking off! [" + applicationToken + "]");

			TestFlight.takeOff(TiApplication.getInstance(), applicationToken);

			if (options.containsKey("sessionTimeout"))
			{
				TestFlight.setSessionTimeout(TiConvert.toInt(options.get("sessionTimeout")));
			}

			didTakeOff = true;
		}
		else
		{
			logDebug("TestFlight has already taken off.");
		}
	}

	/**
	 * Log a checkpoint
	 *
	 * @param String checkpointName
	 * @return void
	 */
	@Kroll.method
	public void checkpoint(String checkpointName)
	{
		if (didTakeOff)
		{
			TestFlight.passCheckpoint(checkpointName);

			logDebug("Logging Message: \"" + checkpointName + "\"");
		}
		else
		{
			grounded();
		}
	}

	/**
	 * Send a feedback message
	 *
	 * NOTE:
	 * This method is not available
	 * on Android as of yet, mostly
	 * here for parity
	 *
	 * @param String message
	 * @return void
	 */
	@Kroll.method
	public void feedback(String message)
	{
		logDebug("This method has not been implemented in the TestFlight SDK.");
	}

	/**
	 * Send a log message
	 *
	 * @param String message
	 * @return void
	 */
	@Kroll.method
	public void log(String message)
	{
		if (didTakeOff)
		{
			TestFlight.log(message);

			logDebug("Passing Checkpoint [" + message + "]");
		}
		else
		{
			grounded();
		}
	}

	/**
	 * Set debugging status
	 *
	 * @param Boolean debugging
	 * @return void
	 */
	@Kroll.setProperty
	public void setDebugging(Boolean debugging)
	{
		this.debugging = debugging;
	}

	/**
	 * Get debugging status
	 *
	 * @return Boolean
	 */
	@Kroll.getProperty
	public Boolean getDebugging()
	{
		return debugging;
	}
}