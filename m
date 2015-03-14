From: Pavel Machek <pavel@ucw.cz>
Subject: Fun with sony motion controllers: navigation controller
Date: Sat, 14 Mar 2015 20:19:17 +0100
Message-ID: <20150314191917.GA3680@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: vojtech@suse.cz, mike-@cinci.rr.com, jslaby@suse.cz, dave@thedillows.org, jikos@suse.cz, colin.leitner@gmail.com, frank.praznik@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi!

After oopsing kernel with ps/3 peripherals, I decided to play some
more.

First "sony motion controller" (part of ps/3 move without the
led). Good news is that it no longer oopses. After pressing the PS
button, it seems to work, but it produces endless stream of events in
evtest:

Event: time 1426360519.967818, type 3 (EV_ABS), code 0 (ABS_X), value 131
Event: time 1426360519.967818, type 3 (EV_ABS), code 1 (ABS_Y), value 129
Event: time 1426360519.967818, type 3 (EV_ABS), code 59 (ABS_MT_DISTANCE), value 513
Event: time 1426360519.967818, type 3 (EV_ABS), code 60 (ABS_MT_TOOL_X), value 513

Should it really produce multitouch events?

Force feedback does not seem to work:

root@amd:~# fftest /dev/input/event7
Force feedback test program.
HOLD FIRMLY YOUR WHEEL OR JOYSTICK TO PREVENT DAMAGES

Device /dev/input/event7 opened
Features:
  * Absolute axes: X, Y, Z, RZ, Misc ,
      [27 00 00 00 00 FF FF 7F ]
  * Relative axes:
	    [00 00 ]
  * Force feedback effects types:
   Force feedback periodic effects:
     [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ]
  * Number of simultaneous effects: 0

Uploading effect #0 (Periodic sinusoidal) ... Error:: Function not implemented
Uploading effect #1 (Constant) ... Error: Function not implemented
Uploading effect #2 (Spring) ... Error: Function not implemented
Uploading effect #3 (Damper) ... Error: Function not implemented
Uploading effect #4 (Strong rumble, with heavy motor) ... Error: Function not implemented
Uploading effect #5 (Weak rumble, with light motor) ... Error: Function not implemented
Enter effect number, -1 to exit

Battery status reporting seems to work. Unfortunately, desktop (Mate on
Debian 8) seems to think it is system battery, and acts funny.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
