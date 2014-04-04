From: simon@mungewell.org
Subject: Re: [PATCH v4 7/7] HID: sony: Add blink support to the Sixaxis and
 DualShock 4 LEDs
Date: Fri, 4 Apr 2014 01:55:26 -0400
Message-ID: <fe23d57ea4d63af433e87f6641e5c339.squirrel@mungewell.org>
References: <1396456285-23755-1-git-send-email-frank.praznik@oh.rr.com>
    <1396456285-23755-8-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:56127 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbaDDFz1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Apr 2014 01:55:27 -0400
In-Reply-To: <1396456285-23755-8-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

> Add support for setting the blink rate of the LEDs.  The Sixaxis allows
> control
> over each individual LED, but the Dualshock 4 only has one global control
> for
> the light bar so changing any individual color changes the global blink
> rate.

I was able to build this and test on the controllers I have. After
modprobing 'ledtrig-timer', I was able to 'echo timer > trigger' in the
appropriate led directory and confirm that leds blinked without additional
USB traffic seen by USBMON.

DS3 SixAxis - mostly worked, although I hade to set a led to 0, before I
could set to 1 (otherwise all leds just did automatic blinking). I was
able to:
blink single led
blink led while other was statically on
blink multiple leds with different timing
blinking sometimes got confused, setting trigger to none and back to timer
resolved.

DS4 - Worked as descibed in patch, but I feel behaviour is confusing. I
was able to:
blink single led
unable adjust other led whilst blinking (blinking stopped, or wrong colour
started blinking)

3rd Party Intec - Was unable to get any controlled blinking. As previously
mentioned all leds flash (automatic, as if first plugged in) whenever all
leds are turned off.
I can control all leds in a static on/off mode, but can't set any
blinking/timer behaviour

Let me know if there's any other testing I can do,
Simon.


