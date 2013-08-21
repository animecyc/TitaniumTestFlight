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

#import "ComAnimecycTestflightModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation ComAnimecycTestflightModule

#pragma mark Internal

/**
 * Returns the module GUID
 *
 * @return {NSString*}
 */
- (id)moduleGUID
{
	return @"96DF9FA3-5AE7-4873-8CAE-A1A1B63C3AED";
}

/**
 * Returns the moduleId
 *
 * @return {NSString*}
 */
- (NSString*)moduleId
{
	return @"com.animecyc.testflight";
}

/**
 * Lof debug messages to the console
 *
 * @param {NSString *} format
 * @param {...}
 * @return void
 */
- (void)logDebug:(NSString*)format, ...
{
    if (debugging)
    {
        va_list arguments;
        va_start(arguments, format);

        NSLog(@"[INFO] TitaniumTestFlight ~> %@", [[NSString alloc] initWithFormat:format arguments:arguments]);
    }
}

/**
 * Method to be called if TestFlight has
 * not flown and we try to send data
 *
 * @return void
 */
- (void)grounded
{
    [self logDebug:@"TestFlight has not been initialized."];
}

#pragma mark Lifecycle

/**
 * Module startup
 *
 * @return void
 */
- (void)startup
{
	[super startup];

    debugging = NO;
    didTakeOff = NO;
    optionWhitelist = [[NSDictionary alloc] initWithObjectsAndKeys:
                         TFOptionDisableInAppUpdates, @"inAppUpdates",
                         TFOptionFlushSecondsInterval, @"flushInterval",
                         TFOptionLogOnCheckpoint, @"logonCheckpoint",
                         TFOptionLogToConsole, @"logToStderr",
                         TFOptionReportCrashes, @"reportCrashes",
                         TFOptionSendLogOnlyOnCrash, @"logOnlyOnCrash",
                         TFOptionSessionKeepAliveTimeout, @"sessionTimeout", nil];
}

#pragma mark Cleanup

/**
 * Garbage collection
 *
 * @return void
 */
- (void)dealloc
{
	[super dealloc];
}

#pragma mark Public APIs

/**
 * Preps all data passed to `args`
 * for [TestFlight takeOff:]
 *
 * @param {id} args
 * @return void
 */
- (void)takeOff:(id)args
{
    if (! didTakeOff)
    {
        NSString *applicationToken;
        NSDictionary *options;

        ENSURE_ARG_AT_INDEX(applicationToken, args, 0, NSString);
        ENSURE_ARG_AT_INDEX(options, args, 1, NSDictionary);

        if (options)
        {
            id reportOptions = [options valueForKey:@"options"];

            if ([reportOptions isKindOfClass:[NSDictionary class]])
            {
                for (NSString *key in reportOptions)
                {
                    NSString * testflightConst= [optionWhitelist objectForKey:key];

                    if (testflightConst)
                    {
                        [TestFlight setOptions:@{ [optionWhitelist objectForKey:key] :
                                                      [TiUtils numberFromObject:[reportOptions objectForKey:key]] }];

                        [self logDebug:@"Setting Option: %@ => \"%@\"", key, [reportOptions objectForKey:key]];
                    }
                }
            }

            id environment = [options valueForKey:@"environment"];

            if ([environment isKindOfClass:[NSDictionary class]])
            {
                for (NSString *key in environment)
                {
                    [TestFlight addCustomEnvironmentInformation:[environment valueForKey:key] forKey:key];
                    [self logDebug:@"Setting Environment Information: %@ => \"%@\"", key, [environment valueForKey:key]];
                }
            }
        }

        [self logDebug:@"Taking Off! [%@]", applicationToken];

        [TestFlight takeOff:applicationToken];

        didTakeOff = YES;
    }
    else
    {
        [self logDebug:@"TestFlight has already taken off."];
    }
}

/**
 * Log a checkpoint
 *
 * @param {id} checkpointName
 * @return void
 */
- (void)checkpoint:(id)checkpointName
{
    ENSURE_SINGLE_ARG(checkpointName, NSString);

    if (didTakeOff)
    {
        [TestFlight passCheckpoint:checkpointName];

        [self logDebug:@"Passing Checkpoint [%@]", checkpointName];
    }
    else
    {
        [self grounded];
    }
}

/**
 * Send feeback
 *
 * @param {id} feedback
 * @return void
 */
- (void)feedback:(id)feedback
{
    ENSURE_SINGLE_ARG(feedback, NSString);

    if (didTakeOff)
    {
        [TestFlight submitFeedback:feedback];

        [self logDebug:@"Sending Feedback: \"%@\"", feedback];
    }
    else
    {
        [self grounded];
    }
}

/**
 * Send a log message
 *
 * @param {id} message
 * @return void
 */
- (void)log:(id)message
{
    ENSURE_SINGLE_ARG(message, NSString);

    if (didTakeOff)
    {
        TFLogPreFormatted(message);

        [self logDebug:@"Logging Message: \"%@\"", message];
    }
    else
    {
        [self grounded];
    }
}

/**
 * Set debugging status
 *
 * @param {id} debug
 * @return void
 */
- (void)setDebugging:(id)debug
{
    ENSURE_SINGLE_ARG(debug, NSNumber);

    debugging = [debug boolValue];
}

/**
 * Get debugging status
 *
 * @param {id} debug
 * @return {BOOL}
 */
- (id)getDebugging:(id)debug
{
    return debugging;
}

@end