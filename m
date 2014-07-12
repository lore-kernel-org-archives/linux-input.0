From: Nicole Faerber <nicole.faerber@kernelconcepts.de>
Subject: Synaptics touchpad - lost sync
Date: Sat, 12 Jul 2014 16:37:42 +0200
Message-ID: <53C14836.6060605@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:53666 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbaGLPAZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Jul 2014 11:00:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: nicole.faerber@kernelconcepts.de, Hans de Goede <hdegoede@redhat.com>

Hello all!

I am experiencing an issue on a new Thinkpad Yoga S1 which implements a
touchpad with integrated buttons - I assume this is called a button-pad?
And as with all Thinkpads it also has a trackpoint (the red knob) as
well as a touchscreen and a graphics tablet integrated into the display
(AFAIK Wacom).

All pointing devices work properly for pointing - I can move the mouse
cursor smoothly without any glitch, also using the touchpad. The
touchscreen and the Wacom also work for "clicking".

But as soon as I press one of the buttons on the touchpad I get a
strange behavior. Either the cursor randomly jumps and causes random
button presses and then freezes for some seconds or it just freezes. In
kernel dmesg I see the following when this happens:

[   38.880242] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[   38.881295] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[   38.882452] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[   38.883558] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[   38.884662] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[   38.884673] psmouse serio1: issuing reconnect request

Soon after the reconnect request it starts working again, i.e. I can
move the cursor again but if I press a button on the touchpad it starts
to fail again.

In dmesg I also see this output after boot:

[    2.106803] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1,
id: 0x1e2b1, caps: 0xd001a3/0x940300/0x127c00, board id: 2911, fw id:
1514409
[    2.106813] psmouse serio1: synaptics: serio: Synaptics pass-through
port at isa0060/serio1/input0
[    6.584970] psmouse serio2: alps: Unknown ALPS touchpad: E7=10 00 64,
EC=10 00 64
[    8.532572] psmouse serio2: trackpoint: IBM TrackPoint firmware:
0x0e, buttons: 3/3


Do I have a not yet supported touchpad here? Or does my hardware have a
defect?

The main issue I have now is that I just bought this Thinkpad and I need
to know if this is a software or a hardware issue. If it is software it
can surely be fixed and I can wait for that to happen (or even try to
help doing it). But if it is hardware I need to return the machine ASAP
- which would be the worst case.


If you have an idea what I might do to either fix that or help to debug
I would be very happy if you would let me know.

Many thanks!

PS: Please keep me in CC when replying since I am not subscribed to the
linux-input list.

Cheers
  nicole

-- 
kernel concepts GmbH
Sieghuetter Hauptweg 48
D-57072 Siegen
http://www.kernelconcepts.de
