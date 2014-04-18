From: simon@mungewell.org
Subject: Re: [PATCH v5 0/7] HID: sony: More Sony controller fixes and
 improvements.
Date: Fri, 18 Apr 2014 13:24:42 -0400
Message-ID: <dc5ee3d9ee47d1c6ccb5c6d632f0200f.squirrel@mungewell.org>
References: <1397484697-2389-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20140418132441_33771"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:59874 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbaDRRYo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Apr 2014 13:24:44 -0400
In-Reply-To: <1397484697-2389-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>

------=_20140418132441_33771
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

>  -The new patch adds a 'global' LED to the DualShock 4 for synchronously
>   controlling the whole light bar and setting hardware blink rate.  Under
> the
>   old system where all of the LEDs mapped to one global blink rate
> triggers
>   would constantly override each other if different ones were assigned to
>   different color LEDs and triggers that run their own timers and adjust
> the
>   brightness directly couldn't be synchronously applied to the whole light
> bar.
>   Now, the global LED controls the hardware blink rate and can
> synchronously
>   toggle the state of the whole light bar without disturbing the
> individual
>   colors.  Additionally, if the user wants to apply different triggers to
>   the individual colors, that works as well.

Hi all,
I tested these patches again my controllers (USB connected DS4, DS3-SA and
Intec) and they seem to work OK. I did see some weirdness with DS4,
however I think that this is probably unavoidable with current LED class
and this controller - it probably needs some overall discussion how the
LED class treats RGB leds.

I'd suggest that we use this patch series.
Thanks,
Simon.

<tested-by> Simon Wood <simon@mungewell.org>


------=_20140418132441_33771
Content-Type: text/plain; name="ds4leds.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="ds4leds.txt"

DS4 failure when using 'global/timer', only reset by unplugging controller
--
# echo 80 > 0003\:054C\:05C4.0007\:green/brightness	[green]
# echo timer > 0003\:054C\:05C4.0007\:global/trigger	[flashing green]
# echo none > 0003\:054C\:05C4.0007\:global/trigger 	[off]
# echo 80 > 0003\:054C\:05C4.0007\:green/brightness	[off????]
--

DS3SA weirdness before PS button pressed (no jstest activity), works OK 
afer PS button is pressed
--
							[all flashing]
# echo 1 > 0003\:054C\:0268.0008\:\:sony1/brightness	[1 lit]
							[after a few sec starts all flashing]
--

DSA3SA wrong led, controller plugged in while 'on'. Only happened sometimes
--
							[1 lit automatically]
# echo 1 > 0003\:054C\:0268.0009\:\:sony1/brightness 	[1 lit]
# echo 2 > 0003\:054C\:0268.0009\:\:sony2/brightness 	[1+3 lit???]
--

Intec flashing does not (which we knew anyhow/expected)
--
# echo 1 > 0003\:054C\:0268.000D\:\:sony1/brightness 	[1 lit]
# echo timer > 0003\:054C\:0268.000D\:\:sony1/trigger 	[1 lit, not flashing]
--
------=_20140418132441_33771--


