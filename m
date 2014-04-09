From: simon@mungewell.org
Subject: Re: [PATCH v4 7/7] HID: sony: Add blink support to the Sixaxis and
 DualShock 4 LEDs
Date: Wed, 9 Apr 2014 01:51:23 -0400
Message-ID: <5ab597fe6a7cc937a8d41df6df7adc47.squirrel@mungewell.org>
References: <1396456285-23755-1-git-send-email-frank.praznik@oh.rr.com>
    <1396456285-23755-8-git-send-email-frank.praznik@oh.rr.com>
    <fe23d57ea4d63af433e87f6641e5c339.squirrel@mungewell.org>
    <533EBE48.5010100@oh.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20140409015122_88963"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:58094 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaDIFvZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Apr 2014 01:51:25 -0400
In-Reply-To: <533EBE48.5010100@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: HID CORE LAYER <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Frank Praznik <frank.praznik@oh.rr.com>

------=_20140409015122_88963
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Unfortunately I was unable to find the 'led chaining' code I mentioned. I
guess it has been lost to the sands of time....

>> 3rd Party Intec - Was unable to get any controlled blinking. As
>> previously
>> mentioned all leds flash (automatic, as if first plugged in) whenever
>> all
>> leds are turned off.
>> I can control all leds in a static on/off mode, but can't set any
>> blinking/timer behaviour
>
> It sounds like this controller just doesn't implement all of the
> behavior of the official controller.  I'm not sure how to fix it if it's
> not obeying the instructions in valid output reports and I don't have
> one to test personally.  Do the lights flash properly when the
> controller is used with a PS3?

I was able to patch the code so that I could turn all LEDs off my Intec
controller, see attached. Tested this against the Intec and the SixAxis.

I was not able to make the LEDs flash in a controlled fashion, so you
might be right about the controller not working properly - although my
comments in python script suggests I did have something going.... must be
missing a snippet of info.


I also found that on the SixAxis, when I reported that I had to set 1st
LED off before I could set it on.... this only applies when the controller
was off and then plugged into USB. At this point the LEDs are slow
flashing, and the 'brightness' reports as 1 (driver code only writes to
device if value is changed).

If the device was already on (LEDs flashing) then only the 1st LED is set
on plug in, and I can turn LEDs off/on straight away.

Cheers,
Simon

------=_20140409015122_88963
Content-Type: text/x-patch;
 name="0001-HID-hid-sony-allow-3rd-party-INTEC-controller-to-tur.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-HID-hid-sony-allow-3rd-party-INTEC-controller-to-tur.patch"

>From a0597309d26ddecb5d4662d9e3bcb4d2689b7ed5 Mon Sep 17 00:00:00 2001
From: Simon Wood <simon@mungewell.org>
Date: Tue, 8 Apr 2014 21:39:59 -0600
Subject: [PATCH] HID: hid-sony - allow 3rd party INTEC controller to turn off
 all leds

Without this patch the 3rd party INTEC (PS3) controller will blink all
leds when user turns them off, it appears to require an extra flag set.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-sony.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index aa5ece5..45cb8b6 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1423,6 +1423,10 @@ static void sixaxis_state_worker(struct work_struct *work)
 	report.data.leds_bitmap |= sc->led_state[2] << 3;
 	report.data.leds_bitmap |= sc->led_state[3] << 4;
 
+	/* Set flag for all leds off, required for 3rd party INTEC controller */
+	if ((report.data.leds_bitmap & 0x1E) == 0)
+		report.data.leds_bitmap |= 0x20;
+
 	/*
 	 * The LEDs in the report are indexed in reverse order to their
 	 * corresponding light on the controller.
-- 
1.8.1.2

------=_20140409015122_88963--


