From: Jason Flatt <jflatt@cox.net>
Subject: Sony NSG-MR5-U / NSG-MR5-E
Date: Tue, 22 Jan 2013 21:41:08 -0800
Message-ID: <11234027.59Rv6QzWVQ@desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fed1rmfepi201.cox.net ([68.230.241.140]:59468 "EHLO
	fed1rmfepi201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab3AWGCc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2013 01:02:32 -0500
Received: from fed1rmimpo110 ([68.230.241.159]) by fed1rmfepo203.cox.net
          (InterMail vM.8.01.04.00 201-2260-137-20101110) with ESMTP
          id <20130123054505.UDQU23677.fed1rmfepo203.cox.net@fed1rmimpo110>
          for <linux-input@vger.kernel.org>;
          Wed, 23 Jan 2013 00:45:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I am trying to add the newer Sony Google TV remote, and am looking for some 
advice on how to get this implemented.  This is my first experience with hid 
drivers and multitouch.

Some base info:
Bluetooth only
Keyboard
Multitouch trackpad
Accelerometer
http://discover.store.sony.com/googletv/#remote

Below is the original report descriptor with my annotations.  In kernel 3.6.11 
the keyboard works great, but the trackpad and accelerometer don't work out of 
the box.  I can get the trackpad to work as a one-button mouse by rewriting 
the report descriptor in a custom hid device module.

I am thinking the 0xff01 usage page is what keeps it from being detected as a 
pointing device to begin with, requiring a rewrite of the report descriptor.  
Is this kind of approach frowned upon?

There are some quirks that I believe might make this device unusual compared 
to others.  The entire trackpad surface acts as a mechanical button, i.e. the 
trackpad physically pushes into the remote body, so using tapping movements 
may be confusing to the user.  The remote also has a 'drag' button that acts 
like a mouse button but is only active when held down and there is trackpad 
motion.  I think it was intended for one-handed dragging, so would have to 
utilize some kind of dragging-on/dragging-off state.  I understand the 
individual mouse reports, which always contain X and Y absolute values for 
both contact points.  There are two values that seem to be some sort of 
contact identifier, we'll call them a and b.  With no fingers touching, a=0, 
b=0.  With just the first finger touching, a=1, b=0.  With both the first and 
second finger touching, a=2, b=2.  Then, with just the second finger touching, 
a=0, b=1.  Has this been seen before?  Would that be used to translate into a 
contact identifier?

The accelerometer doesn't seem to show any events, I saw the sixaxis driver 
needs some kind of set_operational command before it begins working, I'd have 
to investigate if that sort of thing is necessary for this remote control.  If 
I get the accelerometer working, do I leave it as-is, and leave the 
implementation up to userspace?  What would the accelerometer do?  Mimic a 
mouse?  Mimic a joystick?

Also, the remote has a power button and when it is pressed the bluetooth 
connection is dropped, just the same as when it goes to sleep.  Is there a way 
of handling the power button?  Is that something that would have to happen on 
the bluez, or bluetooth side of things?

One more thing, the report ids 5, 6, and 8.  Any idea what those could be?  
They have output values, and there are 3 LEDs on the device, including a data 
indicator and two Fn lights, but the amount of data in those report 
descriptors are quite large.

Does anybody have an example rdesc of a similar multitouch trackpad that I 
could use in my custom rdesc to enable multitouch?

Thanks for the help.


05 01    // USAGE_PAGE (Generic Desktop)
09 06    // USAGE (Keyboard)
a1 01    // COLLECTION (Application)
85 01    //     REPORT_ID (1)
75 01    //     REPORT_SIZE (1)
95 08    //     REPORT_COUNT (8)
05 07    //     USAGE_PAGE (Keyboard/Keypad)
19 e0    //     USAGE_MINIMUM (224) <- Left ctrl
29 e7    //     USAGE_MAXIMIUM (231) <- Right GUI
15 00    //     LOGICAL_MINIMUM (0)
25 01    //     LOGICAL_MAXIMUM (1)
81 02    //     INPUT (Data,Variable,Absolute) <- Usual modifier keys
95 01    //     REPORT_COUNT (1)
75 08    //     REPORT_SIZE (8)
81 03    //     INPUT (Constant,Variable,Absolute)
95 06    //     REPORT_COUNT (6)
75 08    //     REPORT_SIZE (8)
15 00    //     LOGICAL_MINIMUM (0)
26 ff 00 //     LOGICAL_MAXIMUM (255)
05 07    //     USAGE_PAGE (Keyboard/Keypad)
19 00    //     USAGE_MINIMUM (0)
29 ff    //     USAGE_MAXIMIUM (255)
81 00    //     INPUT (Data,Array,Absolute) <- Regular keyboard keys
c0       // END_COLLECTION
06 01 ff // USAGE_PAGE (Generic Device Reserved) <- Vendor specific?
09 01    // USAGE (Pointer) <- A multitouch trackpad
a1 01    // COLLECTION (Application)
85 02    //     REPORT_ID (2)
19 01    //     USAGE_MINIMUM (1) <- Main mechanical touchpad button
29 04    //     USAGE_MAXIMUM (4) <- Button 3 is drag, other values appear 
constant
15 00    //     LOGICAL_MINIMUM (0)
25 01    //     LOGICAL_MAXIMUM (1)
75 01    //     REPORT_SIZE (1)
95 04    //     REPORT_COUNT (4)
81 02    //     INPUT (Data,Variable,Absolute)
19 00    //     USAGE_MINIMUM (0)
29 01    //     USAGE_MAXIMUM (1)
15 00    //     LOGICAL_MINIMUM (0)
25 03    //     LOGICAL_MAXIMUM (3)
75 02    //     REPORT_SIZE (2)
95 02    //     REPORT_COUNT (2)
81 02    //     INPUT (Data,Variable,Absolute) <- Contact identifiers
09 30    //     USAGE (X)
09 31    //     USAGE (Y)
16 01 f8 //     LOGICAL_MINIMUM (-2047)
26 ff 07 //     LOGICAL_MAXIMUM (2047)
75 0c    //     REPORT_SIZE (12)
95 02    //     REPORT_COUNT(2)
81 02    //     INPUT (Data,Variable,Absolute) <- First contact coordinates
19 00    //     USAGE_MINIMUM (0)
29 0f    //     USAGE_MAXIMUM (15)
15 00    //     LOGICAL_MINIMUM (0)
25 0f    //     LOGICAL_MAXIMUM (15)
75 04    //     REPORT_SIZE (4)
95 02    //     REPORT_COUNT (2)
81 02    //     INPUT (Data,Variable,Absolute) <- First contact width and 
height
09 30    //     USAGE (X)
15 81    //     LOGICAL_MINIMUM (-127)
25 7f    //     LOGICAL_MAXIMUM (127)
75 08    //     REPORT_SIZE (8)
95 01    //     REPORT_COUNT (1)
81 06    //     INPUT (Data,Variable,Relative) <- X axis relative
09 30    //     USAGE (X)
09 31    //     USAGE (Y)
16 01 f8 //     LOGICAL_MINIMUM (-2047)
26 ff 07 //     LOGICAL_MAXIMUM (2047)
75 0c    //     REPORT_SIZE (12)
95 02    //     REPORT_COUNT (2)
81 02    //     INPUT (Data,Variable,Absolute) <- Second contact coordinates
19 00    //     USAGE_MINIMUM (0)
29 0f    //     USAGE_MAXIMUM (15)
15 00    //     LOGICAL_MINIMUM (0)
25 0f    //     LOGICAL_MAXIMUM (15)
75 04    //     REPORT_SIZE (4)
95 02    //     REPORT_COUNT (2)
81 02    //     INPUT (Data,Variable,Absolute) <- Second contact width and 
height
09 31    //     USAGE (Y)
15 81    //     LOGICAL_MINIMUM (-127)
25 7f    //     LOGICAL_MAXIMUM (127)
75 08    //     REPORT_SIZE (8)
95 01    //     REPORT_COUNT (1)
81 06    //     INPUT (Data,Variable,Relative) <- Y axis relative
c0       // END_COLLECTION
05 0c    // USAGE_PAGE (Consumer Device)
09 01    // USAGE (Consumer Control)
a1 01    // COLLECTION (Application)
85 03    //     REPORT_ID (3)
19 00    //     USAGE_MINIMUM (0)
2a 9c 02 //     USAGE_MAXIMUM (668)
15 00    //     LOGICAL_MINIMUM (0)
26 9c 02 //     LOGICAL_MAXIMUM (668)
75 10    //     REPORT_SIZE (16)
95 01    //     REPORT_COUNT (1)
81 00    //     INPUT (Data,Array,Absolute) <- Additional remote buttons, on, 
off, etc.
c0       // END_COLLECTION
05 01    // USAGE_PAGE (Generic Desktop)
09 08    // USAGE (Multi-axis Controller)
a1 01    // COLLECTION (Application)
85 04    //     REPORT_ID (4)
09 40    //     USAGE (Vx)
09 41    //     USAGE (Vy)
09 42    //     USAGE (Vz)
66 11 e0 //     UNIT (SI Linear: Centimeter*Seconds^-2)
16 00 80 //     LOGICAL_MINIMUM (-32768)
26 ff 7f //     LOGICAL_MAXIMUM (32767)
75 10    //     REPORT_SIZE (16)
95 03    //     REPORT_COUNT (3)
81 02    //     INPUT (Data,Variable,Absolute) <- 3-axis accelerometer
09 00    //     USAGE ()
15 00    //     LOGICAL_MINIMUM (0)
26 ff 00 //     LOGICAL_MAXIMUM (255)
75 08    //     REPORT_SIZE (8)
95 01    //     REPORT_COUNT (1)
81 02    //     INPUT (Data,Variable,Absolute) <- motion intensity?
c0       // END_COLLECTION
06 01 ff // USAGE_PAGE (Generic Device Reserved) <- Vendor specific
09 02    // USAGE () <- Trying to look like a Generic Desktop Mouse?
a1 01    // COLLECTION (Application)
85 05    //     REPORT_ID (5)
19 01    //     USAGE_MINIMUM (1)
29 ff    //     USAGE_MAXIMUM (255)
15 00    //     LOGICAL_MINIMUM (0)
26 ff 00 //     LOGICAL_MAXIMUM (255)
75 08    //     REPORT_SIZE (8)
95 06    //     REPORT_COUNT (6)
81 00    //     INPUT (Data,Array,Absolute)
19 01    //     USAGE_MINIMUM (1)
29 ff    //     USAGE_MAXIMUM (255)
15 00    //     LOGICAL_MINIMUM (0)
26 ff 00 //     LOGICAL_MAXIMUM (255)
75 08    //     REPORT_SIZE (8)
95 06    //     REPORT_COUNT (6)
91 00    //     OUTPUT (Data,Array,Absolute) <- eh?
c0       // END_COLLECTION
06 01 ff // USAGE_PAGE (Generic Device Reserved) <- Vendor specific
09 03    // USAGE () <- Generic Desktop Reserved?
a1 01    // COLLECTION (Application)
85 06    //     REPORT_ID (6)
19 01    //     USAGE_MINIMUM (1)
29 ff    //     USAGE_MAXIMUM (255)
15 00    //     LOGICAL_MINIMUM (0)
26 ff 00 //     LOGICAL_MAXIMUM (255)
75 08    //     REPORT_SIZE (8)
95 0f    //     REPORT_COUNT (15)
81 00    //     INPUT (Data,Array,Absolute)
19 01    //     USAGE_MINIMUM (1)
29 ff    //     USAGE_MAXIMUM (255)
15 00    //     LOGICAL_MINIMUM (0)
26 ff 00 //     LOGICAL_MAXIMUM (255)
75 08    //     REPORT_SIZE (8)
95 0f    //     REPORT_COUNT (15)
91 00    //     OUTPUT (Data,Array,Absolute)
c0       // END_COLLECTION
06 01 ff // USAGE_PAGE (Generic Device Reserved) <- Vendor specific
09 05    // USAGE () <- Trying to look like a Generic Desktop Game Pad?
a1 01    // COLLECTION (Application)
85 08    //     REPORT_ID (8) <- Where did report id #7 go?
19 01    //     USAGE_MINIMUM (1)
29 ff    //     USAGE_MAXIMUM (255)
15 00    //     LOGICAL_MINIMUM (0)
26 ff 00 //     LOGICAL_MAXIMUM (255)
75 08    //     REPORT_SIZE (8)
95 06    //     REPORT_COUNT (6)
81 00    //     INPUT (Data,Array,Absolute)
19 01    //     USAGE_MINIMUM (1)
29 ff    //     USAGE_MAXIMUM (255)
15 00    //     LOGICAL_MINIMUM (0)
26 ff 00 //     LOGICAL_MAXIMUM (255)
75 08    //     REPORT_SIZE (8)
95 06    //     REPORT_COUNT (6)
91 00    //     OUTPUT (Data,Array,Absolute)
c0       // END_COLLECTION
00       // <- Extra byte, similar to sixaxis report descriptor

