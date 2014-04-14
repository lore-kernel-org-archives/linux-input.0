From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v5 0/7] HID: sony: More Sony controller fixes and improvements.
Date: Mon, 14 Apr 2014 10:11:30 -0400
Message-ID: <1397484697-2389-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:44173 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750853AbaDNOLs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2014 10:11:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>

v5 has the following changes:

 -Addresses some usability issues with the hardware blink support in the LED
  code. The Sixaxis has some odd behavior where, on USB, the controller
  overrides user LED settings and blinks the whole light bar until the PS button
  is pushed.  The new patch doesn't filter redundant state for the Sixaxis on
  USB so the blinking can be stopped by the user without having to toggle the
  state of an LED that is already set correctly.
  
 -The new patch adds a 'global' LED to the DualShock 4 for synchronously
  controlling the whole light bar and setting hardware blink rate.  Under the
  old system where all of the LEDs mapped to one global blink rate triggers
  would constantly override each other if different ones were assigned to
  different color LEDs and triggers that run their own timers and adjust the
  brightness directly couldn't be synchronously applied to the whole light bar.
  Now, the global LED controls the hardware blink rate and can synchronously
  toggle the state of the whole light bar without disturbing the individual
  colors.  Additionally, if the user wants to apply different triggers to
  the individual colors, that works as well.
  
 -A patch from Simon Wood is included to fix a glitch with a third-party INTEC
  controllers where the LEDs would blink when they were set to 'all-off'.

These are made to be applied on top of the latest code in
jikos/hid.git/for-3.15/upstream
