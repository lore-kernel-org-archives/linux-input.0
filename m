From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 0/6] HID: sony: More Sony controller fixes and
 improvements.
Date: Sat, 1 Mar 2014 14:53:46 +0100
Message-ID: <20140301145346.d1b3305ba0b186d452a34beb@ao2.it>
References: <1393646341-16947-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:61779 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547AbaCANxv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 1 Mar 2014 08:53:51 -0500
In-Reply-To: <1393646341-16947-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, dh.herrmann@gmail.com

Hi Frank,

On Fri, 28 Feb 2014 22:58:55 -0500
Frank Praznik <frank.praznik@oh.rr.com> wrote:

> This set consists of one bugfix, two mostly cosmetic changes and three larger
> patches for the LED subsystem.
> 
> Patch #4 adds hardware blink support to the controller LEDs.  Values from 0 to
> 2.5 seconds are supported by the hardware.  The Sixaxis can set all of the LEDs
> individually, but the DualShock 4 only has one global setting for the entire
> light bar so only the value from the most recently set LED is used.
>

Adding this is OK, as it adds access to something supported by the
hardware.

> Patch #5 adds an LED trigger that reports the controller battery status via the
> registered LEDs.  The LEDs will flash if the controller is charging or if the
> battery is low, and remain solid otherwise.
>

This kind of logic _may_ belong to userspace. More comments in the
actual patch.

> Patch #6 initializes the LEDs to a default value of LED 1 on the Sixaxis and
> blue on the DualShock 4 so there is some indication that the controller is
> powered on and connected in the case of Bluetooth.  The code can be used to set
> the LEDs based on the device number, but I'm not sure how to actually retrieve
> the controller number from the system.  I saw the xpad patches posted a few
> weeks ago where the minor number of the joydev device was used, but I'm under
> the impression that doing that is not ideal.  Any suggestions?

Setting the controller number is done by the bluez sixaxis plugin[1]
(in bluez 5.x) following the X in /dev/input/jsX, this covers the
case of a mixed-joypad scenario, IMHO it makes sense that the
controller number matches the joystick device number.
Imagine js0->Sixaxis1, js1->wiimote, js2->Sixaxis2, I think it make
sense to have the LEDs on Sixaxis2 say "controller 3", not 2.

This has been done in userspace with libudev for 2 reasons:
  1. the hid drivers should not have knowledge of the joystick layer;
  2. kernel drivers should be as simple as possible, and try to just
     exposing hardware functionalities but with as less "business logic"
     as possible in them.

The current implementation in the bluez plugin uses hidraw, but support
for the sysfs led class could be added in order to avoid conflicts with
the rumble; IIRC, currently, setting rumble values could override the
LED settings done via hidraw, because the LEDs state is not tracked in
the latter case.

Ciao,
   Antonio

[1]
http://git.kernel.org/cgit/bluetooth/bluez.git/tree/plugins/sixaxis.c

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
