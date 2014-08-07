From: Dylan Thurston <dpthurst@indiana.edu>
Subject: ALPS v7 touchpad
Date: Thu, 7 Aug 2014 18:46:09 -0400
Message-ID: <20140807224609.GA3629@tulip.bostoncoop.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from whitehail.bostoncoop.net ([74.50.63.164]:34965 "EHLO
	bostoncoop.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbaHGXbd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Aug 2014 19:31:33 -0400
Received: from bostoncoop.net (localhost [127.0.0.1])
	by bostoncoop.net (Postfix) with ESMTP id 2C9E71C1275
	for <linux-input@vger.kernel.org>; Thu,  7 Aug 2014 18:46:11 -0400 (EDT)
Received: from tulip.bostoncoop.net (localhost [127.0.0.1])
	by bostoncoop.net (Postfix) with ESMTP id DA1F21C1274
	for <linux-input@vger.kernel.org>; Thu,  7 Aug 2014 18:46:10 -0400 (EDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm using an ALPS v7 touchpad on an HP Revolve 810. I just compiled
linuxnext-20140807, which has the recent patches discussed on this
list to give it support. But there's an issue: selecting text doesn't
really work, as the driver gives multiple ButtonPress and
ButtonRelease events when I attempt a click-drag.

Here's the relevant line from the current dmesg:

Aug  7 17:37:17 tulip kernel: [    4.092326] input: AlpsPS/2 ALPS DualPoint TouchPad as /devices/platform/i8042/serio4/input/input11

Since that's maybe not so informative, here's an older kernel that didn't recognize it:

Aug  7 17:23:28 tulip kernel: [    3.671749] psmouse serio4: alps: ALPS touchpad: E7=73 03 0a, EC=88 b3 18

I've attached some xev output where I attempted a click-drag. In the
first I clicked with my index finger and then moved it; in the second
I clicked with my thumb, then put down my index finger and attempted
to drag. The first log gives only a single ButtonPress event, but it's
really difficult to execute.

Any help is greatly appreciated! I had previously been using a patch
from Elaine Chen that she wrote back in January-February; she
indicated there are slightly different versions of the firmware.

--Dylan Thurston

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=xev-1

Outer window is 0x2600001, inner window is 0x2600002

PropertyNotify event, serial 8, synthetic NO, window 0x2600001,
    atom 0x27 (WM_NAME), time 3867426, state PropertyNewValue

PropertyNotify event, serial 9, synthetic NO, window 0x2600001,
    atom 0x22 (WM_COMMAND), time 3867426, state PropertyNewValue

PropertyNotify event, serial 10, synthetic NO, window 0x2600001,
    atom 0x28 (WM_NORMAL_HINTS), time 3867426, state PropertyNewValue

CreateNotify event, serial 11, synthetic NO, window 0x2600001,
    parent 0x2600001, window 0x2600002, (10,10), width 50, height 50
border_width 4, override NO

PropertyNotify event, serial 14, synthetic NO, window 0x2600001,
    atom 0x14e (WM_PROTOCOLS), time 3867426, state PropertyNewValue

MapNotify event, serial 15, synthetic NO, window 0x2600001,
    event 0x2600001, window 0x2600002, override NO

PropertyNotify event, serial 18, synthetic NO, window 0x2600001,
    atom 0x15c (_NET_WM_STATE), time 3867427, state PropertyNewValue

PropertyNotify event, serial 18, synthetic NO, window 0x2600001,
    atom 0x156 (_NET_WM_DESKTOP), time 3867427, state PropertyNewValue

ConfigureNotify event, serial 18, synthetic NO, window 0x2600001,
    event 0x2600001, window 0x2600001, (0,0), width 178, height 178,
    border_width 0, above 0x220106c, override NO

ReparentNotify event, serial 18, synthetic NO, window 0x2600001,
    event 0x2600001, window 0x2600001, parent 0x1805c6a,
    (1,22), override NO

ConfigureNotify event, serial 18, synthetic NO, window 0x2600001,
    event 0x2600001, window 0x2600001, (1,22), width 178, height 178,
    border_width 0, above 0x1805c79, override NO

ConfigureNotify event, serial 18, synthetic YES, window 0x2600001,
    event 0x2600001, window 0x2600001, (612,304), width 178, height 178,
    border_width 0, above 0x1805c6a, override NO

MapNotify event, serial 18, synthetic NO, window 0x2600001,
    event 0x2600001, window 0x2600001, override NO

VisibilityNotify event, serial 18, synthetic NO, window 0x2600001,
    state VisibilityUnobscured

Expose event, serial 18, synthetic NO, window 0x2600001,
    (0,0), width 178, height 10, count 3

Expose event, serial 18, synthetic NO, window 0x2600001,
    (0,10), width 10, height 58, count 2

Expose event, serial 18, synthetic NO, window 0x2600001,
    (68,10), width 110, height 58, count 1

Expose event, serial 18, synthetic NO, window 0x2600001,
    (0,68), width 178, height 110, count 0

PropertyNotify event, serial 18, synthetic NO, window 0x2600001,
    atom 0x187 (WM_STATE), time 3867432, state PropertyNewValue

PropertyNotify event, serial 18, synthetic NO, window 0x2600001,
    atom 0x1b9 (_NET_WM_ALLOWED_ACTIONS), time 3867433, state PropertyNewValue

PropertyNotify event, serial 18, synthetic NO, window 0x2600001,
    atom 0x15c (_NET_WM_STATE), time 3867433, state PropertyNewValue

FocusIn event, serial 18, synthetic NO, window 0x2600001,
    mode NotifyNormal, detail NotifyNonlinear

KeymapNotify event, serial 18, synthetic NO, window 0x0,
    keys:  4294967227 0   0   0   16  0   0   0   0   0   0   0   0   0   0   0   
           0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   

PropertyNotify event, serial 18, synthetic NO, window 0x2600001,
    atom 0x153 (_NET_FRAME_EXTENTS), time 3867433, state PropertyNewValue

PropertyNotify event, serial 18, synthetic NO, window 0x2600001,
    atom 0x15c (_NET_WM_STATE), time 3867433, state PropertyNewValue

KeyRelease event, serial 20, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3867439, (167,-8), root:(779,296),
    state 0x0, keycode 36 (keysym 0xff0d, Return), same_screen YES,
    XLookupString gives 1 bytes: (0d) "
"
    XFilterEvent returns: False

PropertyNotify event, serial 36, synthetic NO, window 0x2600001,
    atom 0x1bc (_NET_WM_ICON_GEOMETRY), time 3867450, state PropertyNewValue

PropertyNotify event, serial 37, synthetic NO, window 0x2600001,
    atom 0x1bc (_NET_WM_ICON_GEOMETRY), time 3867450, state PropertyNewValue

EnterNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868128, (154,2), root:(766,306),
    mode NotifyNormal, detail NotifyNonlinear, same_screen YES,
    focus YES, state 0

KeymapNotify event, serial 37, synthetic NO, window 0x0,
    keys:  92  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   
           0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868333, (154,2), root:(766,306),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868345, (153,4), root:(765,308),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868359, (152,7), root:(764,311),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868371, (150,10), root:(762,314),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868383, (147,13), root:(759,317),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868395, (145,15), root:(757,319),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868407, (142,17), root:(754,321),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868419, (140,20), root:(752,324),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868431, (137,22), root:(749,326),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868443, (135,25), root:(747,329),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868454, (133,28), root:(745,332),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868466, (130,31), root:(742,335),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868478, (129,34), root:(741,338),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868490, (127,36), root:(739,340),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868502, (126,38), root:(738,342),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868514, (125,40), root:(737,344),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868526, (124,41), root:(736,345),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868538, (123,42), root:(735,346),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868552, (122,44), root:(734,348),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868564, (121,46), root:(733,350),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868576, (119,48), root:(731,352),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868588, (117,50), root:(729,354),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868602, (115,52), root:(727,356),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868614, (112,53), root:(724,357),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868626, (111,54), root:(723,358),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868638, (110,55), root:(722,359),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3868652, (110,56), root:(722,360),
    state 0x0, is_hint 0, same_screen YES

ButtonPress event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3869751, (110,56), root:(722,360),
    state 0x0, button 1, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3869851, (110,56), root:(722,360),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3869863, (110,56), root:(722,360),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3869946, (110,56), root:(722,360),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870078, (110,55), root:(722,359),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870090, (110,54), root:(722,358),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870104, (110,53), root:(722,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870124, (110,53), root:(722,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870136, (111,53), root:(723,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870149, (112,53), root:(724,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870161, (112,53), root:(724,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870173, (113,53), root:(725,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870185, (113,53), root:(725,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870197, (114,53), root:(726,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870209, (115,53), root:(727,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870221, (116,53), root:(728,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870233, (118,53), root:(730,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870245, (119,53), root:(731,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870257, (120,53), root:(732,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870269, (120,53), root:(732,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870281, (121,53), root:(733,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870295, (121,53), root:(733,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870307, (121,53), root:(733,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870345, (122,53), root:(734,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870363, (122,53), root:(734,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870377, (122,53), root:(734,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870388, (123,53), root:(735,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870402, (123,53), root:(735,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870414, (124,53), root:(736,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870426, (124,53), root:(736,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870438, (124,53), root:(736,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870485, (124,53), root:(736,357),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870498, (128,52), root:(740,356),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870510, (132,49), root:(744,353),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870522, (136,45), root:(748,349),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870534, (142,41), root:(754,345),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870548, (146,38), root:(758,342),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870568, (149,37), root:(761,341),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870580, (151,36), root:(763,340),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870594, (151,36), root:(763,340),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870629, (151,36), root:(763,340),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870641, (151,36), root:(763,340),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870665, (152,36), root:(764,340),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870690, (152,36), root:(764,340),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870703, (152,36), root:(764,340),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870787, (152,36), root:(764,340),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870833, (153,36), root:(765,340),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870868, (153,36), root:(765,340),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870880, (153,36), root:(765,340),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870895, (153,36), root:(765,340),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870906, (153,36), root:(765,340),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870918, (154,34), root:(766,338),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870930, (156,32), root:(768,336),
    state 0x100, is_hint 0, same_screen YES

ButtonRelease event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870944, (156,32), root:(768,336),
    state 0x100, button 1, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870964, (157,32), root:(769,336),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870976, (157,32), root:(769,336),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3870989, (159,31), root:(771,335),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3871002, (160,31), root:(772,335),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3871014, (161,31), root:(773,335),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3871026, (162,31), root:(774,335),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3871039, (170,31), root:(782,335),
    state 0x0, is_hint 0, same_screen YES

KeyPress event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3872075, (170,31), root:(782,335),
    state 0x0, keycode 133 (keysym 0xffeb, Super_L), same_screen YES,
    XLookupString gives 0 bytes: 
    XmbLookupString gives 0 bytes: 
    XFilterEvent returns: False

FocusOut event, serial 37, synthetic NO, window 0x2600001,
    mode NotifyGrab, detail NotifyAncestor

LeaveNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3872269, (170,31), root:(782,335),
    mode NotifyGrab, detail NotifyAncestor, same_screen YES,
    focus YES, state 64

VisibilityNotify event, serial 37, synthetic NO, window 0x2600001,
    state VisibilityPartiallyObscured

Expose event, serial 37, synthetic NO, window 0x2600001,
    (71,145), width 24, height 33, count 1

Expose event, serial 37, synthetic NO, window 0x2600001,
    (100,145), width 78, height 33, count 0

Expose event, serial 37, synthetic NO, window 0x2600001,
    (95,0), width 5, height 15, count 1

Expose event, serial 37, synthetic NO, window 0x2600001,
    (95,145), width 5, height 33, count 0

FocusOut event, serial 37, synthetic NO, window 0x2600001,
    mode NotifyWhileGrabbed, detail NotifyNonlinear

Expose event, serial 37, synthetic NO, window 0x2600001,
    (0,15), width 10, height 53, count 2

Expose event, serial 37, synthetic NO, window 0x2600001,
    (68,15), width 27, height 53, count 1

Expose event, serial 37, synthetic NO, window 0x2600001,
    (0,68), width 95, height 77, count 0

PropertyNotify event, serial 37, synthetic NO, window 0x2600001,
    atom 0x1bc (_NET_WM_ICON_GEOMETRY), time 3872459, state PropertyNewValue

PropertyNotify event, serial 37, synthetic NO, window 0x2600001,
    atom 0x1bc (_NET_WM_ICON_GEOMETRY), time 3872459, state PropertyNewValue

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=xev-2

Outer window is 0x2600001, inner window is 0x2600002

PropertyNotify event, serial 8, synthetic NO, window 0x2600001,
    atom 0x27 (WM_NAME), time 3980006, state PropertyNewValue

PropertyNotify event, serial 9, synthetic NO, window 0x2600001,
    atom 0x22 (WM_COMMAND), time 3980006, state PropertyNewValue

PropertyNotify event, serial 10, synthetic NO, window 0x2600001,
    atom 0x28 (WM_NORMAL_HINTS), time 3980006, state PropertyNewValue

CreateNotify event, serial 11, synthetic NO, window 0x2600001,
    parent 0x2600001, window 0x2600002, (10,10), width 50, height 50
border_width 4, override NO

PropertyNotify event, serial 14, synthetic NO, window 0x2600001,
    atom 0x14e (WM_PROTOCOLS), time 3980007, state PropertyNewValue

MapNotify event, serial 15, synthetic NO, window 0x2600001,
    event 0x2600001, window 0x2600002, override NO

PropertyNotify event, serial 18, synthetic NO, window 0x2600001,
    atom 0x15c (_NET_WM_STATE), time 3980009, state PropertyNewValue

PropertyNotify event, serial 18, synthetic NO, window 0x2600001,
    atom 0x156 (_NET_WM_DESKTOP), time 3980009, state PropertyNewValue

ConfigureNotify event, serial 18, synthetic NO, window 0x2600001,
    event 0x2600001, window 0x2600001, (0,0), width 178, height 178,
    border_width 0, above 0x220106c, override NO

ReparentNotify event, serial 18, synthetic NO, window 0x2600001,
    event 0x2600001, window 0x2600001, parent 0x18061c2,
    (1,22), override NO

ConfigureNotify event, serial 18, synthetic NO, window 0x2600001,
    event 0x2600001, window 0x2600001, (1,22), width 178, height 178,
    border_width 0, above 0x18061d1, override NO

ConfigureNotify event, serial 18, synthetic YES, window 0x2600001,
    event 0x2600001, window 0x2600001, (612,304), width 178, height 178,
    border_width 0, above 0x18061c2, override NO

MapNotify event, serial 18, synthetic NO, window 0x2600001,
    event 0x2600001, window 0x2600001, override NO

VisibilityNotify event, serial 18, synthetic NO, window 0x2600001,
    state VisibilityUnobscured

Expose event, serial 18, synthetic NO, window 0x2600001,
    (0,0), width 178, height 10, count 3

Expose event, serial 18, synthetic NO, window 0x2600001,
    (0,10), width 10, height 58, count 2

Expose event, serial 18, synthetic NO, window 0x2600001,
    (68,10), width 110, height 58, count 1

Expose event, serial 18, synthetic NO, window 0x2600001,
    (0,68), width 178, height 110, count 0

PropertyNotify event, serial 18, synthetic NO, window 0x2600001,
    atom 0x187 (WM_STATE), time 3980016, state PropertyNewValue

PropertyNotify event, serial 18, synthetic NO, window 0x2600001,
    atom 0x1b9 (_NET_WM_ALLOWED_ACTIONS), time 3980016, state PropertyNewValue

PropertyNotify event, serial 18, synthetic NO, window 0x2600001,
    atom 0x15c (_NET_WM_STATE), time 3980016, state PropertyNewValue

FocusIn event, serial 18, synthetic NO, window 0x2600001,
    mode NotifyNormal, detail NotifyNonlinear

KeymapNotify event, serial 18, synthetic NO, window 0x0,
    keys:  4294967227 0   0   0   16  0   0   0   0   0   0   0   0   0   0   0   
           0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   

PropertyNotify event, serial 18, synthetic NO, window 0x2600001,
    atom 0x153 (_NET_FRAME_EXTENTS), time 3980016, state PropertyNewValue

PropertyNotify event, serial 18, synthetic NO, window 0x2600001,
    atom 0x15c (_NET_WM_STATE), time 3980016, state PropertyNewValue

PropertyNotify event, serial 33, synthetic NO, window 0x2600001,
    atom 0x1bc (_NET_WM_ICON_GEOMETRY), time 3980036, state PropertyNewValue

PropertyNotify event, serial 33, synthetic NO, window 0x2600001,
    atom 0x1bc (_NET_WM_ICON_GEOMETRY), time 3980036, state PropertyNewValue

KeyRelease event, serial 34, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3980038, (281,248), root:(893,552),
    state 0x0, keycode 36 (keysym 0xff0d, Return), same_screen YES,
    XLookupString gives 1 bytes: (0d) "
"
    XFilterEvent returns: False

EnterNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3981944, (167,176), root:(779,480),
    mode NotifyNormal, detail NotifyNonlinear, same_screen YES,
    focus YES, state 0

KeymapNotify event, serial 37, synthetic NO, window 0x0,
    keys:  83  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   
           0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982003, (167,176), root:(779,480),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982015, (166,174), root:(778,478),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982027, (164,172), root:(776,476),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982039, (162,171), root:(774,475),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982053, (160,169), root:(772,473),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982064, (158,168), root:(770,472),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982076, (155,167), root:(767,471),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982091, (153,166), root:(765,470),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982102, (151,166), root:(763,470),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982114, (148,166), root:(760,470),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982126, (146,165), root:(758,469),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982138, (144,165), root:(756,469),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982150, (142,164), root:(754,468),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982162, (140,163), root:(752,467),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982174, (138,162), root:(750,466),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982186, (136,161), root:(748,465),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982198, (135,160), root:(747,464),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982210, (134,159), root:(746,463),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3982222, (133,159), root:(745,463),
    state 0x0, is_hint 0, same_screen YES

ButtonPress event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983252, (133,159), root:(745,463),
    state 0x0, button 1, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983373, (133,159), root:(745,463),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983385, (133,159), root:(745,463),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983397, (133,159), root:(745,463),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983410, (133,159), root:(745,463),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983433, (132,159), root:(744,463),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983445, (132,159), root:(744,463),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983457, (132,159), root:(744,463),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983469, (131,159), root:(743,463),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983495, (131,159), root:(743,463),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983507, (130,159), root:(742,463),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983519, (130,159), root:(742,463),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983531, (129,159), root:(741,463),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983543, (129,159), root:(741,463),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983555, (129,159), root:(741,463),
    state 0x100, is_hint 0, same_screen YES

ButtonRelease event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983566, (129,159), root:(741,463),
    state 0x100, button 1, same_screen YES

ButtonPress event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983580, (129,159), root:(741,463),
    state 0x0, button 1, same_screen YES

ButtonRelease event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983617, (129,159), root:(741,463),
    state 0x100, button 1, same_screen YES

ButtonPress event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983629, (129,159), root:(741,463),
    state 0x0, button 1, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983736, (129,158), root:(741,462),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983748, (130,157), root:(742,461),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983760, (130,156), root:(742,460),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983772, (131,154), root:(743,458),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983784, (131,152), root:(743,456),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983796, (131,150), root:(743,454),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983808, (131,148), root:(743,452),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983820, (131,146), root:(743,450),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983832, (131,144), root:(743,448),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983843, (131,143), root:(743,447),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983855, (131,142), root:(743,446),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983867, (131,141), root:(743,445),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983879, (131,141), root:(743,445),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983892, (131,139), root:(743,443),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983903, (132,137), root:(744,441),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983915, (132,134), root:(744,438),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983927, (133,131), root:(745,435),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983939, (133,129), root:(745,433),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983951, (133,129), root:(745,433),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983963, (134,129), root:(746,433),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983975, (134,129), root:(746,433),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3983987, (134,129), root:(746,433),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984035, (134,128), root:(746,432),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984047, (135,127), root:(747,431),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984059, (135,127), root:(747,431),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984071, (135,126), root:(747,430),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984085, (136,125), root:(748,429),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984096, (136,125), root:(748,429),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984120, (136,125), root:(748,429),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984156, (136,125), root:(748,429),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984168, (136,124), root:(748,428),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984180, (137,123), root:(749,427),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984192, (138,122), root:(750,426),
    state 0x100, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984204, (138,122), root:(750,426),
    state 0x100, is_hint 0, same_screen YES

ButtonRelease event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984395, (138,122), root:(750,426),
    state 0x100, button 1, same_screen YES

ButtonPress event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984407, (138,122), root:(750,426),
    state 0x0, button 1, same_screen YES

ButtonRelease event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984457, (138,122), root:(750,426),
    state 0x100, button 1, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984778, (141,122), root:(753,426),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984790, (147,122), root:(759,426),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984802, (155,122), root:(767,426),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984814, (163,122), root:(775,426),
    state 0x0, is_hint 0, same_screen YES

MotionNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984826, (170,122), root:(782,426),
    state 0x0, is_hint 0, same_screen YES

LeaveNotify event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3984458, (180,122), root:(792,426),
    mode NotifyNormal, detail NotifyNonlinear, same_screen YES,
    focus YES, state 0

KeyPress event, serial 37, synthetic NO, window 0x2600001,
    root 0xa5, subw 0x0, time 3985628, (298,144), root:(910,448),
    state 0x0, keycode 133 (keysym 0xffeb, Super_L), same_screen YES,
    XLookupString gives 0 bytes: 
    XmbLookupString gives 0 bytes: 
    XFilterEvent returns: False

FocusOut event, serial 37, synthetic NO, window 0x2600001,
    mode NotifyGrab, detail NotifyAncestor

VisibilityNotify event, serial 37, synthetic NO, window 0x2600001,
    state VisibilityPartiallyObscured

Expose event, serial 37, synthetic NO, window 0x2600001,
    (71,145), width 24, height 33, count 1

Expose event, serial 37, synthetic NO, window 0x2600001,
    (100,145), width 78, height 33, count 0

Expose event, serial 37, synthetic NO, window 0x2600001,
    (95,0), width 5, height 15, count 1

Expose event, serial 37, synthetic NO, window 0x2600001,
    (95,145), width 5, height 33, count 0

FocusOut event, serial 37, synthetic NO, window 0x2600001,
    mode NotifyWhileGrabbed, detail NotifyNonlinear

Expose event, serial 37, synthetic NO, window 0x2600001,
    (0,15), width 10, height 53, count 2

Expose event, serial 37, synthetic NO, window 0x2600001,
    (68,15), width 27, height 53, count 1

Expose event, serial 37, synthetic NO, window 0x2600001,
    (0,68), width 95, height 77, count 0

PropertyNotify event, serial 37, synthetic NO, window 0x2600001,
    atom 0x1bc (_NET_WM_ICON_GEOMETRY), time 3986184, state PropertyNewValue

PropertyNotify event, serial 37, synthetic NO, window 0x2600001,
    atom 0x1bc (_NET_WM_ICON_GEOMETRY), time 3986184, state PropertyNewValue

--6c2NcOVqGQ03X4Wi--
