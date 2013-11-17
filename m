From: simon@mungewell.org
Subject: Re: [PATCH] HID: sony: Add force feedback support for Dualshock3
 USB
Date: Sat, 16 Nov 2013 20:48:59 -0500
Message-ID: <f963c143b30a370dc9d79232dfe59c2f.squirrel@mungewell.org>
References: <1384021557-24106-1-git-send-email-sven@narfation.org>
    <f26febe04a776d22c913ed3ade3a8d90.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20131116204858_78414"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:58499 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab3KQBtA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Nov 2013 20:49:00 -0500
In-Reply-To: <f26febe04a776d22c913ed3ade3a8d90.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: Sven Eckelmann <sven@narfation.org>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>

------=_20131116204858_78414
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit


> The Intec controller works OK up to the point when I start rumble,
> sometimes the motor runs some times it doesn't. I am using SDL2's
> 'testhaptic' application.

That's not quite true. Both SixAxis and Intec lock up machine with
'testhaptic'.

Using 'testrumble' the SixAxis works multiple times, Intec locks up
straight away (sometimes starts motor).

USBMon shows Testrumble does (on SixAxis)
--
e9b23e40 2764496125 S Co:002:00 s 21 09 0201 0000 0023 35 = 00ff01ff
7f000000 0003ff27 100032ff 27100032 ff271000 32ff2710 00320000
e9b23e40 2764507425 C Co:002:00 0 35 >
e99fe840 2766509714 S Co:002:00 s 21 09 0201 0000 0023 35 = 00ff00ff
00000000 0003ff27 100032ff 27100032 ff271000 32ff2710 00320000
e99fe840 2766521086 C Co:002:00 0 35 >
e9b23cc0 2768521311 S Co:002:00 s 21 09 0201 0000 0023 35 = 00ff01ff
4c000000 0003ff27 100032ff 27100032 ff271000 32ff2710 00320000
e9b23cc0 2768532755 C Co:002:00 0 35 >
e9b8e3c0 2770532954 S Co:002:00 s 21 09 0201 0000 0023 35 = 00ff00ff
00000000 0003ff27 100032ff 27100032 ff271000 32ff2710 00320000
e9b8e3c0 2770544425 C Co:002:00 0 35 >
e9b8f780 2770545424 C Ii:002:01 -2 0
--

Attached is a script from a while ago, when I was trying to figure out how
to get the Intec to rumble. Which runs without crashing machine.

Simon
------=_20131116204858_78414
Content-Type: text/x-python; name="intec_rumble.py"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="intec_rumble.py"

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
try:
        dh.detachKernelDriver(0)
except:
        print "Already detached?"
dh.claimInterface(0)

print "Intec - Weak Rumble"
command='\x01\x00\xfe\x80\xfe\x40\x00\x00\x00\x00\x12\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\x00\x00\x00\x00\x00'

dh.bulkWrite(0x02, command, len(command))
time.sleep(3)

print "Intec - Strong Rumble"
command='\x01\x00\xfe\xff\xfe\xff\x00\x00\x00\x00\x0C\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\x00\x00\x00\x00\x00'

dh.bulkWrite(0x02, command, len(command))
time.sleep(3)

'''
New kernel driver - USBMon
e9b23e40 2764496125 S Co:002:00 s 21 09 0201 0000 0023 35 = 00ff01ff 7f000000 0003ff27 100032ff 27100032 ff271000 32ff2710 00320000
e9b23e40 2764507425 C Co:002:00 0 35 >
e99fe840 2766509714 S Co:002:00 s 21 09 0201 0000 0023 35 = 00ff00ff 00000000 0003ff27 100032ff 27100032 ff271000 32ff2710 00320000
e99fe840 2766521086 C Co:002:00 0 35 >
e9b23cc0 2768521311 S Co:002:00 s 21 09 0201 0000 0023 35 = 00ff01ff 4c000000 0003ff27 100032ff 27100032 ff271000 32ff2710 00320000
e9b23cc0 2768532755 C Co:002:00 0 35 >
e9b8e3c0 2770532954 S Co:002:00 s 21 09 0201 0000 0023 35 = 00ff00ff 00000000 0003ff27 100032ff 27100032 ff271000 32ff2710 00320000
e9b8e3c0 2770544425 C Co:002:00 0 35 >
e9b8f780 2770545424 C Ii:002:01 -2 0

But code below does
eb2d3480 2972495664 S Io:002:02 -115 36 = 0100ff01 ff4c0000 000003ff 27100032 ff271000 32ff2710 0032ff27 10003200
eb2d3480 2972497404 C Io:002:02 0 36 >
e9b8dd80 2975502053 S Io:002:02 -115 36 = 0100ff01 ff7f0000 000003ff 27100032 ff271000 32ff2710 0032ff27 10003200
e9b8dd80 2975503910 C Io:002:02 0 36 >
e99e2600 2978507120 S Io:002:02 -115 36 = 0100fe00 fe000000 000020ff 27100032 ff271000 32ff2710 0032ff27 10003200
e99e2600 2978508406 C Io:002:02 0 36 >
'''

'''
print "Sony Six Axis - Weak"
command='\x01\x00\xff\x01\xff\x4c\x00\x00\x00\x00\x03\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\x00\x00\x00\x00\x00'

dh.bulkWrite(0x02, command, len(command))
time.sleep(3)

print "Sony Six Axis - Strong"
command='\x01\x00\xff\x01\xff\x7f\x00\x00\x00\x00\x03\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\x00\x00\x00\x00\x00'

dh.bulkWrite(0x02, command, len(command))
time.sleep(3)
'''

print "Cancel Rumble"
command='\x01\x00\xfe\x00\xfe\x00\x00\x00\x00\x00\x20\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\xff\x27\x10\x00\x32\x00\x00\x00\x00\x00'

dh.bulkWrite(0x02, command, len(command))

------=_20131116204858_78414--


