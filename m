From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: Samsung series 5 ultra keyboard
Date: Sat, 27 Jul 2013 15:06:42 -0300
Message-ID: <20130727150642.5a1f26cd@infradead.org>
References: <20130727101153.6a3ece65@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:52137 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610Ab3G0SGw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Jul 2013 14:06:52 -0400
In-Reply-To: <20130727101153.6a3ece65@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Em Sat, 27 Jul 2013 10:11:53 -0300
Mauro Carvalho Chehab <m.chehab@samsung.com> escreveu:

> Hi Dmitry,
> 
> I received a new notebook those days that has an extra feature of a "Fn Lock"
> key.
> 
> When this key is pressed, it produces a scan code 0xa8, and the direction
> keys (and other keys) start to produce different codes. When pressed again,
> it produces a scan code 0xa9, and the keys return to their normal behavior.
> 
> The input layer doesn't currently produce any EV_KEY event for those two
> scancodes. It produces just EV_MSC events (and, of course, EV_SYN).
> 
> I was wandering that the better would be to have a LED indicator to
> track this, and maybe have two new keycodes, like KEY_FN_LOCK_ON and
> KEY_FN_LOCK_OFF.
> 
> This way, some userspace program, like mate-lockkeys-applet could be
> presenting not only the CAPS LOCK indicator, but also the FN LOCK
> indicator.
> 
> Do you think it would be doable?
> 
> FYI, this is how this keyboard identifies itself:
> 
> $ cat /sys/class/input/event3/device/uevent 
> PRODUCT=11/1/1/ab41
> NAME="AT Translated Set 2 keyboard"
> PHYS="isa0060/serio0/input0"
> PROP=0
> EV=120013
> KEY=500f02000403 3803078f870d001 feffffdffbefffff fffffffffffffffe
> MSC=10
> LED=7
> MODALIAS=input:b0011v0001p0001eAB41-e0,1,4,11,14,k71,72,73,74,75,76,77,79,7A,7B,7C,7D,7E,7F,80,8C,8E,8F,94,95,96,9B,9C,9D,9E,9F,A3,A4,A5,A6,AC,AD,B7,B8,B9,C0,C1,CA,D9,E0,E1,E2,E3,EC,EE,ram4,l0,1,2,sfw
> 
> I'm not sure if the PRODUCT there is unique, and if it could be used
> to add this kind of extra feature to the input subsystem (or if it would
> be just fine to add those extra features at the standard AT keyboard
> driver, although I personally don't like this idea, as other keyboards
> might be using scancodes 0xa8/0xa9 for other meanings).
> 
> What do you think?

Just discovered something weird while trying to write some code for
systemd/udev: there are a few keys that only produce key down events:
	Fn + F1 (KEY_SETUP)
	Fn + F12 (KEY_WLAN)
	Fn Lock (both scan codes 0xa8 and 0xa9)

See:

# ir-keytable -d /dev/input/event3 -t
Testing events. Please, press CTRL-C to abort.
1374948216.879719: event type EV_MSC(0x04): scancode = 0xce
1374948216.879719: event type EV_KEY(0x01) key_down: KEY_SETUP(0x0001)
1374948216.879719: event type EV_SYN(0x00).
1374948218.420177: event type EV_MSC(0x04): scancode = 0xce
1374948218.420177: event type EV_KEY(0x01) key_down: KEY_SETUP(0x0001)
1374948218.420177: event type EV_SYN(0x00).
1374948219.362185: event type EV_MSC(0x04): scancode = 0x89
1374948219.362185: event type EV_KEY(0x01) key_down: KEY_BRIGHTNESSDOWN(0x0001)
1374948219.362185: event type EV_SYN(0x00).
1374948219.362218: event type EV_KEY(0x01) key_up: KEY_BRIGHTNESSDOWN(0x0001)
1374948219.362218: event type EV_SYN(0x00).
1374948222.746160: event type EV_MSC(0x04): scancode = 0xce
1374948222.746160: event type EV_KEY(0x01) key_down: KEY_SETUP(0x0001)
1374948222.746160: event type EV_SYN(0x00).
1374948223.348321: event type EV_MSC(0x04): scancode = 0x89
1374948223.348321: event type EV_KEY(0x01) key_down: KEY_BRIGHTNESSDOWN(0x0001)
1374948223.348321: event type EV_SYN(0x00).
1374948223.348356: event type EV_KEY(0x01) key_up: KEY_BRIGHTNESSDOWN(0x0001)
1374948223.348356: event type EV_SYN(0x00).
1374948224.864993: event type EV_MSC(0x04): scancode = 0xce
1374948224.864993: event type EV_KEY(0x01) key_down: KEY_SETUP(0x0001)
1374948224.864993: event type EV_SYN(0x00).
1374948227.762895: event type EV_MSC(0x04): scancode = 0x82
1374948227.762895: event type EV_KEY(0x01) key_down: KEY_SWITCHVIDEOMODE(0x0001)
1374948227.762895: event type EV_SYN(0x00).
1374948227.762930: event type EV_KEY(0x01) key_up: KEY_SWITCHVIDEOMODE(0x0001)
1374948227.762930: event type EV_SYN(0x00).
1374948229.212478: event type EV_MSC(0x04): scancode = 0x82
1374948229.212478: event type EV_KEY(0x01) key_down: KEY_SWITCHVIDEOMODE(0x0001)
1374948229.212478: event type EV_SYN(0x00).
1374948229.212513: event type EV_KEY(0x01) key_up: KEY_SWITCHVIDEOMODE(0x0001)
1374948229.212513: event type EV_SYN(0x00).
1374948232.961500: event type EV_MSC(0x04): scancode = 0xd5
1374948232.961500: event type EV_KEY(0x01) key_down: KEY_WLAN(0x0001)
1374948232.961500: event type EV_SYN(0x00).
1374948234.377876: event type EV_MSC(0x04): scancode = 0xd5
1374948234.377876: event type EV_KEY(0x01) key_down: KEY_WLAN(0x0001)
1374948234.377876: event type EV_SYN(0x00).
1374948235.090077: event type EV_MSC(0x04): scancode = 0xa8
1374948235.090077: event type EV_KEY(0x01) key_down: KEY_PROG1(0x0001)
1374948235.090077: event type EV_SYN(0x00).
1374948236.650001: event type EV_MSC(0x04): scancode = 0xa9
1374948236.650001: event type EV_KEY(0x01) key_down: KEY_PROG2(0x0001)
1374948236.650001: event type EV_SYN(0x00).
1374948237.094992: event type EV_MSC(0x04): scancode = 0xb7
1374948237.094992: event type EV_KEY(0x01) key_down: KEY_SYSRQ(0x0001)
1374948237.094992: event type EV_SYN(0x00).
1374948237.213233: event type EV_MSC(0x04): scancode = 0xb7
1374948237.213233: event type EV_KEY(0x01) key_up: KEY_SYSRQ(0x0001)
1374948237.213233: event type EV_SYN(0x00).
1374948247.126649: event type EV_MSC(0x04): scancode = 0xb7
1374948247.126649: event type EV_KEY(0x01) key_down: KEY_SYSRQ(0x0001)
1374948247.126649: event type EV_SYN(0x00).
1374948247.299130: event type EV_MSC(0x04): scancode = 0xb7
1374948247.299130: event type EV_KEY(0x01) key_up: KEY_SYSRQ(0x0001)
1374948247.299130: event type EV_SYN(0x00).
1374948249.158131: event type EV_MSC(0x04): scancode = 0xb7
1374948249.158131: event type EV_KEY(0x01) key_down: KEY_SYSRQ(0x0001)
1374948249.158131: event type EV_SYN(0x00).
1374948249.294389: event type EV_MSC(0x04): scancode = 0xb7
1374948249.294389: event type EV_KEY(0x01) key_up: KEY_SYSRQ(0x0001)
1374948249.294389: event type EV_SYN(0x00).
1374948250.904246: event type EV_MSC(0x04): scancode = 0xa8
1374948250.904246: event type EV_KEY(0x01) key_down: KEY_PROG1(0x0001)
1374948250.904246: event type EV_SYN(0x00).
1374948252.938739: event type EV_MSC(0x04): scancode = 0xa9
1374948252.938739: event type EV_KEY(0x01) key_down: KEY_PROG2(0x0001)
1374948252.938739: event type EV_SYN(0x00).

So, perhaps some quirk will be needed at the Kernel driver to artificially
produce KEYUP events for those scancodes.

Cheers,
Mauro
