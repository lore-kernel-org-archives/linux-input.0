From: simon@mungewell.org
Subject: Re: Bug: HID-Sony: DS4 touch-pad corrupts Axis0
Date: Mon, 21 Apr 2014 13:18:48 -0400
Message-ID: <3dc737013234f4957803e53edf14cb4e.squirrel@mungewell.org>
References: <23e61b7ee30edafb338935ae40285dce.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:49981 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbaDURSu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2014 13:18:50 -0400
In-Reply-To: <23e61b7ee30edafb338935ae40285dce.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: Frank Praznik <frank.praznik@gmail.com>, Frank Praznik <frank.praznik@oh.rr.com>, HID CORE LAYER <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

> Hi,
> I've noticed a glitch with the Dualshock4 on 3.15rc1 (plus LEDs patch, if
> that makes a difference).

Seems only to work on the the first time the device is connected (with
USB), even in 'repair' mode (with no GUI). Subsequent plug-ins shows axis
0 being corrupted.

Checking through the kernels I have available on this machine, mostly
patched in one way or the other.
--
linux-image-3.11.0-12-generic           - works (no gyros)
linux-image-3.13.0-ds4blink+            - fails
linux-image-3.14.0-ff-memless-next+     - fails
linux-image-3.15.0-rc1-ds4leds+         - fails
--

Booting into a LiveCD of Xubuntu 14.04 (kernel 3.13.0-24) does not show
problem, but it is not using hid-sony for this device. Just shows 8 axis
available.

Simon.

Simon.

