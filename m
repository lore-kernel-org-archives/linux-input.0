From: simon@mungewell.org
Subject: Re: Re: Re: [PATCH] HID: sony: Add force feedback support for
 Dualshock3 USB
Date: Sun, 17 Nov 2013 22:54:55 -0500
Message-ID: <3487f6f36f8add7c5e55dabef8d70a2f.squirrel@mungewell.org>
References: <1384021557-24106-1-git-send-email-sven@narfation.org>
    <5434362.OvDlhOjSJd@sven-edge> <8249378.0C4gn7PafG@sven-desktop>
    <2105006.tGLFZqe9L3@sven-desktop>
    <0d5dd16c7b4799f333fd4b4077e6c75c.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20131117225455_42223"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:53199 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab3KRDy6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 22:54:58 -0500
In-Reply-To: <0d5dd16c7b4799f333fd4b4077e6c75c.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>, Antonio Ospite <ospite@studenti.unina.it>, simon@mungewell.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>

------=_20131117225455_42223
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> This seems to work, however something is causing the LEDs to go out once
> they have been set. This seems to happen a few seconds after they are set,
> but there does not appear too be USB activity (via usbmon).

I tested this on a real machine (as opposed to VM box), and the LEDs
remain set and do not auto cancel. Suspect host OS was doing something to
device.

There is another bit of weirdness though, when plugged in my Intec
controller slow flashes the LEDs. This is overwritten when I set any LED
through the LED class, but returns to flashing when I clear all LEDs via
the class.

IE. there is no way to turn all the the LEDs off.

The DualShock3/SixAxis behaves slightly differently in that the flashing
does not return when all the LEDs are turn off.

>From some of my earlier investigations I had some notes about LED settings
which might be of help.
--
# \x01                          Header
# \x00\x00\x00\x00\x00          ForceFeedback
(\x00\xfe\x00+<rumble,40=weak,80=strong>
# \x00\x00\x00\x00\x1E          Which LED to enable(LED1..4 << 1, 0x20=none)
# \xff\x27\x10\x00\x32          LED 1 (rate,duty factor
# \xff\x27\x10\x00\x32          LED 2
# \xff\x27\x10\x00\x32          LED 3
# \xff\x27\x10\x00\x32          LED 4
# \x00\x00\x00\x00\x00          Footer

#        * the total time the led is active (0xff means forever)
#        * |     duty_length: how long a cycle is in deciseconds (0 means
"blink really fast")
#        * |     |     ??? (Some form of phase shift or duty_length
multiplier?)
#        * |     |     |     % of duty_length the led is off (0xff means
100%)
#        * |     |     |     |     % of duty_length the led is on (0xff
mean 100%)
#        * |     |     |     |     |
#        * 0xff, 0x27, 0x10, 0x00, 0x32,
--

Attached is a script which works with my Intec, but not with the SixAxis.
Simon

------=_20131117225455_42223
Content-Type: text/x-python; name="rumble_pyusb.py"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="rumble_pyusb.py"

#!/usr/bin/python
#
# Small script to test the rumble on a PS3 gamepad
#

import usb
import time

rumble = 0

busses = usb.busses()
for bus in busses:      
  devices = bus.devices   
  for dev in devices:
    if dev.idVendor == 0x054c and dev.idProduct == 0x0268:
      print "Found RumblePad"
      rumble = dev

if rumble == 0:
  print "RumblePad not found"
  exit(0)

# Get a device handler for the usb device and detach it from the kernel
dh = rumble.open()
dh.detachKernelDriver(0)
dh.claimInterface(0)

#command='\x52\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1E\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\x00\x00\x00\x00\x00'

# \x01				Header
# \x00\x00\x00\x00\x00		ForceFeedback (\x00\xfe\x00+<rumble,40=weak,80=strong>
# \x00\x00\x00\x00\x1E		Which LED to enable(LED1..4 << 1, 0x20=none)
# \xff\x27\x10\x00\x32		LED 1 (rate,duty factor
# \xff\x27\x10\x00\x32		LED 2
# \xff\x27\x10\x00\x32		LED 3
# \xff\x27\x10\x00\x32		LED 4
# \x00\x00\x00\x00\x00		Footer

#	 * the total time the led is active (0xff means forever)
#	 * |     duty_length: how long a cycle is in deciseconds (0 means "blink really fast")
#	 * |     |     ??? (Some form of phase shift or duty_length multiplier?)
#	 * |     |     |     % of duty_length the led is off (0xff means 100%)
#	 * |     |     |     |     % of duty_length the led is on (0xff mean 100%)
#	 * |     |     |     |     |
#	 * 0xff, 0x27, 0x10, 0x00, 0x32,

print "LED3 + LED0"
command='\x01' + \
	'\x00\xfe\x00\xfe\x00' + \
	'\x00\x00\x00\x00\x12' + \
	'\xff\x00\x00\x00\x80' + \
	'\xff\x00\x00\x00\x80' + \
	'\xff\x00\x00\x00\x00' + \
	'\xff\x00\x00\x00\x00' + \
	'\x00\x00\x00\x00\x00'

dh.bulkWrite(0x02, command, len(command))
time.sleep(3)

print "LED2 + LED1"
command='\x01' + \
	'\x00\xfe\x00\xfe\x00' + \
	'\x00\x00\x00\x00\x0C' + \
	'\xff\x27\x10\x80\x32' + \
	'\xff\x27\x10\x80\x32' + \
	'\xff\x27\x10\x00\x32' + \
	'\xff\x27\x10\x00\x32' + \
	'\x00\x00\x00\x00\x00'

dh.bulkWrite(0x02, command, len(command))
time.sleep(3)

print "no LEDs"
command='\x01' + \
	'\x00\x00\x00\x00\x00' + \
	'\x00\x00\x00\x00\x20' + \
	'\xff\x07\x10\xff\x00' + \
	'\xff\x07\x10\xff\x00' + \
	'\xff\x07\x10\xff\x00' + \
	'\xff\x07\x10\xff\x00' + \
	'\x00\x00\x00\x00\x00'
	
dh.bulkWrite(0x02, command, len(command))
------=_20131117225455_42223--


