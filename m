From: Harald Albrecht <harald.albrecht@gmx.net>
Subject: ShuttlePROv2 jog dial reports EV_REL events with absolute position
 event values; pos 0 events get dropped
Date: Fri, 07 Feb 2014 08:51:02 +0100
Message-ID: <52F49066.7040405@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:52988 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbaBGHvF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Feb 2014 02:51:05 -0500
Received: from [192.168.178.21] ([87.149.18.58]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0LdYSM-1VU8FZ262U-00imjs for
 <linux-input@vger.kernel.org>; Fri, 07 Feb 2014 08:51:03 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I have a ShuttlePRO v2 (Contour Design Inc) that identifies itself as a 
USB HID. The kernel properly detects its and I can receive events from 
the device. The ShuttlePRO v2 is a media controller for use with video 
editing software, as well as for many other applications. The controller 
itself has a jog dial for frame-by-frame movement. Next, it has a 
so-called shuttle, which is ring around the dial, but separate from it. 
The shuttle can be turned CW and CCW up to 7 positions and a spring 
ensures it returns to its center position when you take your hand off of 
it. The shuttle is used to play video or audio forwards or backwards, 
with varying speed. Finally, there are 15 buttons on the ShuttlePRO v2.

However, there is an annoying quirk of which I don't at this time where 
it comes from. The Linux event/input system does not report when the 
shuttle returns to its home/center position. It seems as if the event 
sent by the device gets swallowed. I know that the device sends such an 
event, as in Windows there is no such problem. Similar, when turning the 
jog dial, every 256th position gets swallowed as well.

I suspect the device manufacturer to have messed up this, but I may be 
wrong. Anyway, I'm looking for help to get around this annoying quirk.

When I point evtest at the ShuttlePro v2, it reports the following 
information:

Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0xb33 product 0x30 version 0x110
Input device name: "Contour Design ShuttlePRO v2"
Supported events:
   Event type 0 (EV_SYN)
   Event type 1 (EV_KEY)
     Event code 256 (BTN_0)
     Event code 257 (BTN_1)
     Event code 258 (BTN_2)
     Event code 259 (BTN_3)
     Event code 260 (BTN_4)
     Event code 261 (BTN_5)
     Event code 262 (BTN_6)
     Event code 263 (BTN_7)
     Event code 264 (BTN_8)
     Event code 265 (BTN_9)
     Event code 266 (?)
     Event code 267 (?)
     Event code 268 (?)
     Event code 269 (?)
     Event code 270 (?)
   Event type 2 (EV_REL)
     Event code 7 (REL_DIAL)
     Event code 8 (REL_WHEEL)
   Event type 4 (EV_MSC)
     Event code 4 (MSC_SCAN)

Please notice that for whatever reason, the ShuttlePRO v2 uses relative 
events for the dial and shuttle (wheel). Unfortunately, the device sends 
events that contain the dial and shuttle absolute positions.

Please notice that for whatever reason, the ShuttlePRO v2 uses relative 
events for the dial and shuttle (wheel). At least that is my 
understanding of the output from evtest. Unfortunately, the ShuttlePRO 
device sends events that contain the dial and shuttle absolute 
positions. This can be clearly seen from evtest output:

Event: type 2 (EV_REL), code 8 (REL_WHEEL), value 1
Event: -------------- SYN_REPORT ------------
Event: type 2 (EV_REL), code 8 (REL_WHEEL), value 2
Event: -------------- SYN_REPORT ------------
Event: type 2 (EV_REL), code 8 (REL_WHEEL), value 1
Event: -------------- SYN_REPORT ------------
Event: type 2 (EV_REL), code 8 (REL_WHEEL), value -1
Event: -------------- SYN_REPORT ------------

My impression is that the Linux HID module correctly assumes that 
relative events without any position movement can be dropped. Can 
someone please confirm, if this actually is the case?

The issue for the jog dial is similar, here whenever the position 
counter which is in the range of 0 to 255 doesn't get reported when it 
reaches pos 0.

Event: type 2 (EV_REL), code 7 (REL_DIAL), value 2
Event: -------------- SYN_REPORT ------------
Event: type 2 (EV_REL), code 7 (REL_DIAL), value 1
Event: -------------- SYN_REPORT ------------
Event: type 2 (EV_REL), code 7 (REL_DIAL), value 255
Event: -------------- SYN_REPORT ------------

Is there any change of getting the handling of the ShuttlePRO v2 fixed 
i? I asked on the linux-usb mailing list and someone pointed me in the 
direction of this mailing list. As I see the situation, it would be 
preferable if dropping the events could be fixed because then existing 
software does not need to be changed, as it currently expects REL_DIAL 
and REL_WHEEL events. In contrast, trying to fix the issue by mapping 
the EV_REL to EV_ABS events, would cause all existing software that 
works with the ShuttlePRO v2 to break completely.

Any help and points greatly appreciated!
-- TheDiveO
