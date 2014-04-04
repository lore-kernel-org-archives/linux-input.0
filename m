From: simon@mungewell.org
Subject: Re: [PATCH v4 7/7] HID: sony: Add blink support to the Sixaxis and
 DualShock 4 LEDs
Date: Fri, 4 Apr 2014 12:11:51 -0400
Message-ID: <9eabb4ae4fb93b4c51816953fc453e4f.squirrel@mungewell.org>
References: <1396456285-23755-1-git-send-email-frank.praznik@oh.rr.com>
    <1396456285-23755-8-git-send-email-frank.praznik@oh.rr.com>
    <fe23d57ea4d63af433e87f6641e5c339.squirrel@mungewell.org>
    <533EBE48.5010100@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:37810 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbaDDQLx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Apr 2014 12:11:53 -0400
In-Reply-To: <533EBE48.5010100@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: HID CORE LAYER <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Frank Praznik <frank.praznik@oh.rr.com>

DS3:
>> blinking sometimes got confused, setting trigger to none and back to
>> timer resolved.

> Could you elaborate on how the blinking became confused?

When blink was enabled the led would turn off (from being statically on),
but never turn on/blink... I'll try to do some more 'structured' testing
over the weekend. Seen on the 3rd led, which might be a clue.

DS4:
> Yeah, if you set different LEDs to different triggers the light can get
> stuck since the triggers will constantly override each other. I'm
> thinking that an extra "blink" LED just to control the global blink rate
> would be a better solution since the hardware blink setting isn't really
> LED specific.

Why not make the triggers/etc apply across the board, so it doesn't matter
which led the command is sent to - it's just registered/copied to the
first (red?) led data[].

IIRC the weirdness I saw was:
--
cd red
echo 80 > brightness # now red
cd blue
echo 80 > brightness # now purple
cd red
echo timer > trigger # now flashing blue....
--

>> 3rd Party Intec - Was unable to get any controlled blinking.

> It sounds like this controller just doesn't implement all of the
> behavior of the official controller.  I'm not sure how to fix it if it's
> not obeying the instructions in valid output reports and I don't have
> one to test personally.  Do the lights flash properly when the
> controller is used with a PS3?

I presume that they just reversed engineered what they thought to be
correct, I don't have a Playstation so can't confirm for certain.

In my testing from a year ago or so, I could make the blink work via
sending data with python. The script can be found here:
http://www.spinics.net/lists/linux-input/msg28271.html

Note: "Which LED to enable(LED1..4 << 1, 0x20=none)"

Cheers,
Simon

