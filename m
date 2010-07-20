From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: ACRUX gamepads not happy with autosuspend?
Date: Mon, 19 Jul 2010 17:17:45 -0700
Message-ID: <20100720001745.GA17910@core.coreip.homeip.net>
References: <4C3F8A90.3020308@dv-life.ru>
 <20100716080200.GA14120@core.coreip.homeip.net>
 <4C44D236.40002@dv-life.ru>
 <201007191630.07475.dmitry.torokhov@gmail.com>
 <4C44E3A2.8080301@dv-life.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63105 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050Ab0GTARu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Jul 2010 20:17:50 -0400
Content-Disposition: inline
In-Reply-To: <4C44E3A2.8080301@dv-life.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Oliver Neukum <oliver@neukum.org>
Cc: x0r <x0r@dv-life.ru>, Linux Input <linux-input@vger.kernel.org>, Linux USB <linux-usb@vger.kernel.org>

Jiri, Oliver,

It looks like ACRUX game controllers do not like autopm. There is
a bug report over at Ubuntu's launchpad:

	https://bugs.launchpad.net/ubuntu/+source/joystick/+bug/448446

that states that once device is plugged in the light ion it turns on
briefly and then goes off and from that point on nothing comes from
the device. They deal with it by having an application open the jsX
device as soon as it appears and that makes gamepad work - but it
is obviously not a solution.

It looks like we either need to disable autosuspend for these devices
or maybe kick the device harder when userspace tries to open it so
that it wakes up if it went to sleep.

(Sergei, have you tried disabling autosuspend on your box if it is
enabled?)

Also, if one attempts to boot the box with gamepad already connected
then the driver gets confused and will attempt to reset the device
indefinitely:

[   32.430271] drivers/hid/usbhid/hid-core.c: can't reset device, 0000:00:1a.2-1/input0, status -32
[   32.446271] drivers/hid/usbhid/hid-core.c: can't reset device, 0000:00:1a.2-1/input0, status -32
[   32.462271] drivers/hid/usbhid/hid-core.c: can't reset device, 0000:00:1a.2-1/input0, status -32
[   32.478272] drivers/hid/usbhid/hid-core.c: can't reset device, 0000:00:1a.2-1/input0, status -32

Under Windows the device works well with the standard driver; no
vendor specific drivers is required... Any ideas?

Thanks!

-- 
Dmitry
