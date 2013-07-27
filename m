From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Samsung series 5 ultra keyboard
Date: Sat, 27 Jul 2013 10:11:53 -0300
Message-ID: <20130727101153.6a3ece65@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]:63093 "EHLO
	usmailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab3G0NWA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Jul 2013 09:22:00 -0400
Received: from uscpsbgm1.samsung.com
 (u114.gpu85.samsung.co.kr [203.254.195.114]) by usmailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MQL00GKTJBXU520@usmailout3.samsung.com> for
 linux-input@vger.kernel.org; Sat, 27 Jul 2013 09:11:57 -0400 (EDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>

Hi Dmitry,

I received a new notebook those days that has an extra feature of a "Fn Lock"
key.

When this key is pressed, it produces a scan code 0xa8, and the direction
keys (and other keys) start to produce different codes. When pressed again,
it produces a scan code 0xa9, and the keys return to their normal behavior.

The input layer doesn't currently produce any EV_KEY event for those two
scancodes. It produces just EV_MSC events (and, of course, EV_SYN).

I was wandering that the better would be to have a LED indicator to
track this, and maybe have two new keycodes, like KEY_FN_LOCK_ON and
KEY_FN_LOCK_OFF.

This way, some userspace program, like mate-lockkeys-applet could be
presenting not only the CAPS LOCK indicator, but also the FN LOCK
indicator.

Do you think it would be doable?

FYI, this is how this keyboard identifies itself:

$ cat /sys/class/input/event3/device/uevent 
PRODUCT=11/1/1/ab41
NAME="AT Translated Set 2 keyboard"
PHYS="isa0060/serio0/input0"
PROP=0
EV=120013
KEY=500f02000403 3803078f870d001 feffffdffbefffff fffffffffffffffe
MSC=10
LED=7
MODALIAS=input:b0011v0001p0001eAB41-e0,1,4,11,14,k71,72,73,74,75,76,77,79,7A,7B,7C,7D,7E,7F,80,8C,8E,8F,94,95,96,9B,9C,9D,9E,9F,A3,A4,A5,A6,AC,AD,B7,B8,B9,C0,C1,CA,D9,E0,E1,E2,E3,EC,EE,ram4,l0,1,2,sfw

I'm not sure if the PRODUCT there is unique, and if it could be used
to add this kind of extra feature to the input subsystem (or if it would
be just fine to add those extra features at the standard AT keyboard
driver, although I personally don't like this idea, as other keyboards
might be using scancodes 0xa8/0xa9 for other meanings).

What do you think?

Thanks!
Mauro
