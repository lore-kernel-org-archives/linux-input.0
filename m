From: simon@mungewell.org
Subject: Re: [PATCH v2 1/3] HID: sony: Add force-feedback support for the
 Dualshock 4
Date: Sat, 11 Jan 2014 19:25:21 -0500
Message-ID: <3d578d7d8524e9e9a16d151507990276.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:37138 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbaALAZX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Jan 2014 19:25:23 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

> Adds the Dualshock 4 to the HID device list and enables force-feedback.
Adds a Dualshock 4 specific worker function since the Dualshock 4 needs
a
> different report than the Sixaxis.
> The right motor in the Dualshock 4 is variable so the full rumble value
is now passed to the worker function and clamped there if necessary.
Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

I was able to build this and the LED patch against the 3.13rc7 kernel
having first applied this sequence of patches:
https://patchwork.kernel.org/patch/3203761/

I can confirm that FF/LEDs appears to work OK with USB connected
Dualshock4, Dualshock3(SixAxis) and 3rd part wired PS3 controller.

I wasn't able to get Dualshock4 working over BT, but I think that the
problem is with my system - I am yet to figure out getting the HIDP
connection to work properly.

I can use the depricated 'HIDD --connect xxx' to have LEDs are listed in
'/sys/class/leds', but they don't change when instructed. They stay solid
white.

Cheers,
Simon

Tested-by: Simon Wood <simon@mungewell.org>




