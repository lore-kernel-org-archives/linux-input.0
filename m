From: Jean-Michel Bruenn <jean.bruenn@ip-minds.de>
Subject: Solution to get Gigabyte K8100 Aivia USB Gaming Keyboard working in
 Linux
Date: Sun, 24 Feb 2013 17:19:37 +0100
Message-ID: <20130224171937.1bf957f01fb482186cbb134d@ip-minds.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from alia.ip-minds.de ([84.201.38.2]:59765 "EHLO alia.ip-minds.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757309Ab3BXQ2P (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Feb 2013 11:28:15 -0500
Received: from vulkan (p5B10BB7E.dip.t-dialin.net [91.16.187.126])
	by alia.ip-minds.de (Postfix) with ESMTPA id 324D4C32092
	for <linux-input@vger.kernel.org>; Sun, 24 Feb 2013 17:20:19 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

in short:
this mail is about the "Gigabyte K8100 Aivia USB Gaming Keyboard" which
is not working in Linux (xev, usbmon, showkey gives no output except
for backspace+multimedia keys, keyboard works in BIOS and at the
bootloader, dmesg reports: "usage index exceeded"). The solution to
make it working is to higher the value of HID_MAX_USAGES from 12K to
64K.

in long:
in January 2012 a user started a thread about this device on the usb
maillinglist: http://www.spinics.net/lists/linux-usb/msg57559.html
in April 2012 I joined that and added information plus the solution:
http://www.spinics.net/lists/linux-usb/msg60822.html (Solution:
http://www.spinics.net/lists/linux-usb/msg60859.html)

Unfortunately nobody fixed this issue in the past months (probably
I've been on the wrong maillinglist. Hopefully this one is the correct
one). I'm not very familiar with kernel-/driver development and I'm not
sure what side-effects the change might introduce (I couldn't find any,
tested my fix up to kernel 3.3.1), hence I didn't submit a patch. I
wrote to the developer listed in the file but got no response (which is
okay to me, no worries). Now that I've shown the solution in a German
board I'm getting PMs of users with the same or similar keyboard asking
me how they can compile the kernel themselves to make their keyboard
working (so I assume this is not just some rare-used device).

Current state is, that the keyboard is still not working (last tested
kernel: 3.5.0). The keyboard works fine in BIOS and at the bootloader.
Within Linux no keys except for Backslash and the multimedia keys work.
xev shows output for backspace + the 5 multimedia keys. showkey on
the console works only for backspace. the approach using usbmon with
"7u" produces output for backspace and the multimedia keys. just to
verify I tried 0u with the same result: backspace + multimedia keys
work. All other keys aren't working.

dmesg/syslog reports: usage index exceeded

Hence I played around with HID_MAX_USAGES in include/linux/hid.h on
line 346 and I found out that a setting of 32K won't help. A setting
HIGHER than 32K (I would need to test again to give the exact value)
made the keyboard working - I've just changed it to 64K and all was
working as expected:

#define HID_MAX_USAGES 65534

If I plug the usb keyboard in, the following three devices are added in
"lsusb":

Bus 007 Device 006: ID 05e3:0608 Genesys Logic, Inc. USB-2.0 4-Port
HUB Bus 007 Device 007: ID 1044:7a02 Chu Yuen Enterprise Co., Ltd 
Bus 007 Device 008: ID 060b:2270 Solid Year

Thanks for your attention, I hope someone on this list is able to help
and make a fix so that this keyboard will work in newer kernels without
the requirement to manually higher the HID_MAX_USAGES and
recompile of the kernel.

If I can provide any further information, please let me know. I can
send debug output (just tell me the commands you're interested in) and
I can test fixes (just send me a patch).

Jean
