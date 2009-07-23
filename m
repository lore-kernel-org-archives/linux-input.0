From: Andy Isaacson <adi@hexapodia.org>
Subject: Dualpoint button release events quirk (stuck buttons on Dell E4300)
Date: Wed, 22 Jul 2009 17:55:34 -0700
Message-ID: <20090723005534.GA16423@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from straum.hexapodia.org ([64.81.70.185]:41426 "EHLO
	straum.hexapodia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbZGWAze (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2009 20:55:34 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I have a Dell E4300 with a trackpoint + touchpad combo device which
shows up as:

[   17.881956] input: DualPoint Stick as /devices/platform/i8042/serio1/input/input9
[   17.898488] input: AlpsPS/2 ALPS DualPoint TouchPad as /devices/platform/i8042/serio1/input/input10

With 2.6.31-rc3 stock it suffers from
http://bugzilla.kernel.org/show_bug.cgi?id=12577 
which is fixed by
http://lkml.org/lkml/2008/12/8/182

Running with that patch to correctly handle the 9-byte packets, the
combo device exhibits an interesting failure mode -- the buttons
sometimes get stuck.  I finally tracked it down to the following
sequence:

1. press btn1 on deviceA (either touchpad or trackpoint button)
2. press btn1 on deviceB
3. release btn1 on deviceB
4. release btn1 on deviceA

Here's what I get when I do that with i8042.debug=1:

bytes received                  event
--------------                  -----
 09 00 00                       trackpoint click
 08 00 00                       trackpoint release

 cf 06 20 39 4a 00              touchpad click
 cf 06 20 38 4a 00              touchpad release

 09 00 00                       trackpoint click
 cf 06 20 39 4a 00              touchpad click
 cf 06 20 39 4a 00 (*)          touchpad release
 08 00 00                       trackpoint release
 cf 06 20 39 4a 00              touchpad click
 cf 06 20 38 4a 00              touchpad release

The (*)ed release event has the button state incorrect -- byte 4 should
be 0x38 but is 0x39 instead.

Running "xinput query-state 'AlpsPS/2 ALPS DualPoint TouchPad'" I see
that the button gets released at the first motion event on the device
with the stuck button, which works fine if you only have one pointer --
but on this hardware it's easy to have the trackpad button stuck down
while moving with the trackpoint.

So, what's the appropriate way to quirk this hardware?

 - synch the buttons on every button-up event?  (Prevents dual-pointer
   mode from working, but that's not really usable with a combo
   trackpad+touchpoint just from a physical layout point-of-view.)
 - query the device (how?) when getting a down-on-already-down button?
 - something else?

I suspect that there's a separate failure mode that I haven't tracked
down yet, too, because in the above scenario, moving the device with the
stuck button always releases it, while I've also had buttons stick down
that persisted through vigorous wiggling and clicking of both pointing
devices.

-andy
