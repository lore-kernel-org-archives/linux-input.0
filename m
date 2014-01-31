From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/7] Input: xpad: Fix wireless controller connection and leds
Date: Fri, 31 Jan 2014 14:03:27 +0100
Message-ID: <1391173414-6199-1-git-send-email-gregkh@linuxfoundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47817 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241AbaAaNCq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 08:02:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Here's a series of patches from Pierre-Loup and I that rework the xpad
driver to fix the issue where when a wireless xpad controller is plugged
in, 4 joystick devices are created, no matter how many are really
attached to the system.  Pierre-Loup's patches fix this by dynamically
creating the devices only when they are found by the wireless
controller.

Bonus is that the LEDs now work correctly with this series too, when
mixing wireless and wired, we can properly identify which device is
which on the X-LED.  We also now name the LED device based on the
joystick id, not on an atomic number that keeps incrementing, never
decrementing when removed from the system.

Note, patch 4/7 is a crazy hack to get the minor number of the joystick
id that we have registered with the system.  Pierre-Loup came up with
this, and I really can't figure out any other way to do it, the joydev
layer doesn't even know this information, otherwise I would have added
it to that layer so the xpad driver could call it.  Am I missing
something here that we could do instead?

The first patch in the series fixes a really annoying bug when plugging
in one of these controllers to a USB 3 system.  The URB type is
incorrect so the xhci driver complains about it, rightly so.  I think
the original code was incorrect, but left it alone incase there is
really a crazy device with a bulk endpoint instead of interrupt.

Also, even with this series applied, the xpad driver needs a bunch of
work.  The LED device seems pointless as it doesn't actually work, and
given that the number/name of the LED device was impossible to actually
map to the proper xpad device, there's no way userspace code could ever
actually use it.  I think it should be removed entirely.  There's also
some other USB things that should be cleaned up, the bulk urb doesn't
need to be always running (with lots of disconnect/connect cycles you
can get a warning about it running when trying to submit it again), and
the urb callbacks seem a bit strange.  I'll work on those issues next...

This series was based on a larger patch from Pierre-Loup that I broke up
into pieces, and added some of my own where needed to resolve other
issues.

