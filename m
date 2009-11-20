From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] 9-byte Alps, revisited
Date: Thu, 19 Nov 2009 16:34:34 -0800
Message-ID: <20091120003433.GA21522@core.coreip.homeip.net>
References: <1258314158.9416.16.camel@sardelle.necksus.de> <20091118090009.GA2983@core.coreip.homeip.net> <1258675669.5044.540.camel@sardelle.necksus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:44354 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757924AbZKTAeh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2009 19:34:37 -0500
Received: by yxe17 with SMTP id 17so2531746yxe.33
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2009 16:34:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1258675669.5044.540.camel@sardelle.necksus.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Cc: Linux Input ML <linux-input@vger.kernel.org>

Hi Sebastian,

On Fri, Nov 20, 2009 at 01:07:49AM +0100, Sebastian Kapfer wrote:
> 
> Hi Dmitry,
> 
> thank you for your reply.  It is much cleaner now!  I had to make a few
> changes though:
> 
> 1. As posted, the rearranged patch doesn't work properly.

Kinda expected that ;) That's why I asked to try it out.

>  One has to
> retain the sign bits of the PS/2 subpacket.
> 

Yes, indeed.

> 2. I've also pulled the checking of byte0 before the demuxing of the
> PS/2 subpacket.  I think it's safer to desync early if the data is bad.

It does not matter - byte0 does not change when you are receiving bytes 1
through 5 - if you already checked then it is still good.

> 
> 3. The hardware is very broken:  Touchpad and trackpoint share button
> state.  This means that you can trigger this sequence of events:
> 
> 	<user presses button on trackpoint>
> 	3byte:  left down  --> reported to "dev2"
> 	<user moves pointer with touchpad>
> 	6byte:  left down  --> reported to "dev"
> 	<user releases button on trackpoint>
> 	3byte:  left up    --> reported to "dev2"
> 
> The result is that dev has a stuck mouse button, and in X11 the mouse
> button stays down.  That's why I explicitly cloned button events to both
> devices in my first patch. 
> 
> However, this created a different problem:  If the user hammered at the
> mouse button very quickly, the events would be processed out of order,
> e.g.
> 
> 	touch_press touch_release stick_press stick_release
> 
> instead of
> 
> 	touch_press stick_press touch_release stick_release
> 
> As a result of this, a double click was detected in X11.
> 
> I have added logic that assigns each button down event to only one of
> the devices, and also avoids hanging buttons.  This is activated by a
> new flag.
> 

How about we just don't report button presses on the device representing
the stick? This is how Synaptics touchpads with pass-through ports work
(all buttons belong to the touchpad) and it seems to be working very well.

> (I'm pretty sure the shared button state is true for most if not all
> Alps dualpoints, but I made a separate flag out of it for now).
> 
> 4. I've noticed the applied patch for the 4-button Alps device. Is it
> really intended that one of the buttons fires both a BTN_x event and a
> BTN_MIDDLE event?  I don't think so, even tough they share the same bit
> in the packet.  BTN_MIDDLE should never be emitted from a device with
> the ALPS_FOUR_BUTTONS flag IMHO.  I haven't changed this, never having
> seen such a unit.

There is another patch that clears BTN_MIDDLE on the ones that have 4
directional button so input core will deliver either one or the other to
the clients.

> 
> 5. There remains a slight conceptual problem.  The distinction between
> 6-byte and 9-byte packets is not possible only looking at the first 6
> bytes.  (This is a protocoll issue.  We have scrutinized every bit now,
> the protocol just seems to be broken in this regard.)
> 
> This means that if the user triggers a 6-byte message while holding all
> three buttons down (e.g. hold buttons and move pointer via touchpad), we
> run into de-sync.
> 
> We can't solve this without knowing the message size in the driver.  I
> have no idea if we can somehow get this info out of the PS/2 layer.
> Dmitry, do you have any insight into this?

I had another version of the patch that looked at the 7th byte before
deciding if it was standard or interleaved packet instead of using
ALPS_PS2_INTERLEAVD flag but I decided it was too complex. If the device
in E6x00 indeed has 3 buttons then I can ressurect it.

> 
> I still vote strongly for applying the patch, since this is a mostly
> cosmetic problem that never occurs in practical work whereas in the
> current state my touchpad is unusable.
>

Hmm, it is too late for .32 but maybe we can respin it for stable oncde
we hammer out the functionality.

-- 
Dmitry
