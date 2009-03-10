From: Neil Brown <neilb@suse.de>
Subject: Advice requested on reporting 'tap' events from accelerometers.
Date: Tue, 10 Mar 2009 11:15:57 +1100
Message-ID: <18869.45373.570953.22321@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:32807 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760AbZCJAQB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Mar 2009 20:16:01 -0400
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 6AE3B46CC8
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2009 01:15:59 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


Hi experts in the 'input' subsystem...

I have been playing with the Neo Freerunner from Openmoko, and
particularly with the accelerometers lately.

The device has two accelerometers (in slightly different orientations)
which can, among other things, detect taps and double-taps.
A 'tap' involves the acceleration in a particular access crossing a
given threshold and going back below that threshold within a given
time.
A 'double tap' includes 2 such events within a set window.

I would like to program the accelerometers to detect those events and
report them through the input subsystem.

The obvious choice for event type is EV_KEY as it is much like a key
press.  What is less obvious, and what I seek advice on, is what event
codes to use.

Each accelerometer has 2 axes (x,y,z) and can detect taps and double
taps on each axis.  So that is a total of 6 different event codes
needed.
I don't think the device distinguished between taps from one direction
and taps from the opposite direction - if it did we would need 12!!

Looking through the values defined in input.h,
  BTN_X BTN_Y BTN_Z
seem like they could reasonably be used for single taps.
Nothing stands out for double taps, though it did cross my mind to use 
 BTX_A BTN_B BTN_C :-)

I guess I could just report two consecutive BTN_X up/down events...

So my questions are:

1/ Is it best to use EV_KEY for these tap events?

2/ Is it reasonable to use BTN_{X,Y,Z} for taps on the 3 axes?

3/ If there anything better for double-tap than just repeating the
   event?

4/ If I could e.g. differentiate taps from one direction against taps
   from the opposite direction and so needed 6 tap events, what would I
   use?

5/ Turning the device over, and hence reversing the acceleration in
   one axis, is a bit like turning a switch.  It has occurred to me
   that it could be useful to generate EV_SW events on this sort of
   action.   Might this be a reasonable thing to do?  If so what
   event codes might be appropriate?  Is it possible to increase
   SW_MAX  and add some directional switches (SW_X SW_Y SW_Z) ??


Thanks for your time.

NeilBrown

