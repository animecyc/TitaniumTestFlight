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

#import "TiModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TestFlight.h"

@interface ComAnimecycTestflightModule : TiModule
{
    @protected
    BOOL debugging;
    BOOL didTakeOff;
}

@property (nonatomic, readwrite, assign) NSDictionary* optionWhitelist;

- (void)logDebug:(NSString *)format, ...;
- (void)grounded;
- (void)takeOff:(id)args;
- (void)checkpoint:(id)checkpointName;
- (void)feedback:(id)feedback;
- (void)log:(id)message;
- (void)setDebugging:(id)debug;
- (id)getDebugging:(id)debug;

@end