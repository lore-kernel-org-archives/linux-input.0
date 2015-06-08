From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/3] Switch input leds over to standard LED class devices
Date: Mon,  8 Jun 2015 14:43:07 -0700
Message-ID: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34273 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbbFHVnY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Jun 2015 17:43:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi,

I finally was able to spend some time looking over Samuel's patch set
switching input LEDs from custom implementation over to standard LED class
devices and I think this is the shape I am reasonably happy with. The
changes:

1. Instead of making LED class devices part of the input device they are
implemented as an input handler (and thus are completely separate from
input core). The old way of controlling the leds (via writing
EV_LED/LED_XXX events into an event device) is still there and may override
LED state set up via a trigger or through sysfs attribute. Also when input
device is "grabbed" requests coming from LED subsystem are ignored until
the device is released.

2. There are no per-input device triggers. Input devices only carry LEDs
and those LEDs use one of the system-wide triggers. Which ones is to user
to decide. The default triggers are the one defines by keyboard handler for
it's standard LED states.

3. There are no VT "LEDs" combining state of multiple keyboards/input
devices anymore. Having such virtual multiplexing object just adds
complexity and is hard to untange (see /dev/input/mice and all the issues
we had with synaptics driver trying to exclude it's data stream from it).
If user wants all keyboards to light up CapsLock LED when VT state locks
CtrlL modifier they need to write a udev rule or similar to set up
"kbd-ctrlllock" trigger for all appearing "input%::capslock" LED class
devices.

Please take a look and see if you see any holes.

Thanks.

-- 
Dmitry

