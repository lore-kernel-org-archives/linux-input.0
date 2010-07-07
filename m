From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Some issues with imon input driver
Date: Wed, 7 Jul 2010 05:36:45 +0300
Message-ID: <201007070536.45900.anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sirokuusama.dnainternet.net ([83.102.40.133]:40931 "EHLO
	sirokuusama.dnainternet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752131Ab0GGCpV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jul 2010 22:45:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@wilsonet.com>
Cc: linux-input@vger.kernel.org

Hi!

I tried to set up my imon remote, but run into the issue of buttons getting 
easily stuck. And while looking at the code, I noticed some more issues :)

So here they all are (on 2.6.35-rc4):

- There is no fallback timer if a release code is missed (i.e. remote pointed 
away from receiver or some other anomaly), causing a key stuck on autorepeat. 
The driver should inject a release code itself if there is no release/repeat 
code in 500ms after initial press or in 120ms after a repeat code.

- No release code is sent for 0x02XXXXXX keys if pressing any other button 
before release, examples:

example 1:
hold '5', then press 'Play' once, then release '5'
The 'Play' codes are relayed properly, but the release code for '5' (the 'all 
0x02XXXXXX keys released' (i.e. empty HID input report) which the hardware 
does send properly) is wrongly interpreted as a release code for 'Play'.
The driver should either release '5' when the empty report is received, or, as 
this is just a remote control, just inject a release code for '5' when 'Play' 
is pressed.

example 2:
hold '5', then hold '4', then release '5', then release '4'
As the 0x02XXXXXX range is not completely released until after '4' is 
released, the zeroed bitfield is not sent until after '4', and the driver 
doesn't release '5' at this point anymore. The driver should've injected a 
release code for '5' when '4' was pressed.

- imon_mce_timeout() timer function seems to access ictx->last_keycode without 
locking

- imon_parse_press_type() tests for ictx->release_code which is in an 
undefined state if ktype isn't IMON_KEY_IMON

- when the dpad is in keyboard mode and you hold it down to one direction, 
instead of autorepeat there is a constant stream of release/press events


I may get around to fix these (if I find time and an MCE remote for testing), 
but that won't probably happen soon, thus I'm reporting these here if someone 
else wants to fix them.

-- 
Anssi Hannula

