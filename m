From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Handling touchscreen buttons
Date: Sun, 23 Sep 2007 21:39:13 -0700
Message-ID: <20070923213913.15c12c3b.Kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: dmitry.torokhov@gmail.com
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Greetings,

On my jornada7xx I have 4 buttons on the rightside of the screen (going from Y-low -> Y-high). They are part of the touchscreen.
Since they aren't usually used in normal X window handling I was thinking that I should have the driver detect if the touch happend on one of those buttons.
The general idea is that I could somehow export detection into /sys so that ordinary applications could make use of them. Example would be that touching one button could be scripted to start an xterm or anything else.

Im interested to know if anyone has any examples or suggestion how to best accomplish this?

Best wishes
Kristoffer Ericson
Maintainer : HP7xx & HP6xx
