From: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Subject: Re: [PATCH] 9-byte Alps, revisited
Date: Fri, 20 Nov 2009 01:55:21 +0100
Message-ID: <1258678521.5044.565.camel@sardelle.necksus.de>
References: <1258314158.9416.16.camel@sardelle.necksus.de>
	 <20091118090009.GA2983@core.coreip.homeip.net>
	 <1258675669.5044.540.camel@sardelle.necksus.de>
	 <20091120003433.GA21522@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:55983 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753962AbZKTAzR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2009 19:55:17 -0500
In-Reply-To: <20091120003433.GA21522@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input ML <linux-input@vger.kernel.org>


Hi Dmitry!

> > thank you for your reply.  It is much cleaner now!  I had to make a few
> > changes though:
> > 
> > 1. As posted, the rearranged patch doesn't work properly.
> 
> Kinda expected that ;) That's why I asked to try it out.

Well, how should you test it :-)

> > 3. The hardware is very broken:  Touchpad and trackpoint share button
> > state.  This means that you can trigger this sequence of events:
> > 
> > 	<user presses button on trackpoint>
> > 	3byte:  left down  --> reported to "dev2"
> > 	<user moves pointer with touchpad>
> > 	6byte:  left down  --> reported to "dev"
> > 	<user releases button on trackpoint>
> > 	3byte:  left up    --> reported to "dev2"
> > 
> > The result is that dev has a stuck mouse button, and in X11 the mouse
> > button stays down.  That's why I explicitly cloned button events to both
> > devices in my first patch. 
> > 
> > However, this created a different problem:  If the user hammered at the
> > mouse button very quickly, the events would be processed out of order,
> > e.g.
> > 
> > 	touch_press touch_release stick_press stick_release
> > 
> > instead of
> > 
> > 	touch_press stick_press touch_release stick_release
> > 
> > As a result of this, a double click was detected in X11.
> > 
> > I have added logic that assigns each button down event to only one of
> > the devices, and also avoids hanging buttons.  This is activated by a
> > new flag.
> > 
> 
> How about we just don't report button presses on the device representing
> the stick? This is how Synaptics touchpads with pass-through ports work
> (all buttons belong to the touchpad) and it seems to be working very well.

We could do that -- however, one of my testers said he liked it that on
his Synaptics, he could assign some different function to the Trackpoint
middle button than to the touchpad middle button (no idea, really).

Obviously, it's not 100% possible to tell the two apart, but for all
practical purposes, it should be OK.  The button is always reported on
the device where the button is first pressed.

> There is another patch that clears BTN_MIDDLE on the ones that have 4
> directional button so input core will deliver either one or the other to
> the clients.

Ah ok.  So these things have a four-direction button instead of the
middle mouse button then.

> > 5. There remains a slight conceptual problem.  The distinction between
> > 6-byte and 9-byte packets is not possible only looking at the first 6
> > bytes.  (This is a protocoll issue.  We have scrutinized every bit now,
> > the protocol just seems to be broken in this regard.)
> > 
> > This means that if the user triggers a 6-byte message while holding all
> > three buttons down (e.g. hold buttons and move pointer via touchpad), we
> > run into de-sync.
> > 
> > We can't solve this without knowing the message size in the driver.  I
> > have no idea if we can somehow get this info out of the PS/2 layer.
> > Dmitry, do you have any insight into this?
> 
> I had another version of the patch that looked at the 7th byte before
> deciding if it was standard or interleaved packet instead of using
> ALPS_PS2_INTERLEAVD flag but I decided it was too complex. If the device
> in E6x00 indeed has 3 buttons then I can ressurect it.

Even with the seventh byte, we can't be totally sure.  The protocol is
just nuts.  And waiting for the seventh byte causes the code in
psmouse-base.c to force desync.  So this is not really an option, too.

I have no clue how PS/2 works internally and if there is some sort of
message separator mechanism.  I would hope that Alps' original Windows
driver does not resort to timing for telling packets apart...

> > 
> > I still vote strongly for applying the patch, since this is a mostly
> > cosmetic problem that never occurs in practical work whereas in the
> > current state my touchpad is unusable.
> >
> 
> Hmm, it is too late for .32 but maybe we can respin it for stable oncde
> we hammer out the functionality.

I'd volunteer for any changes required, although I'm not really sure
what they are.  The patch should almost completely apply to the stable
kernel, too?

-- 
Best Regards,  | Hi! I'm a .signature virus. Copy me into
 Sebastian     | your ~/.signature to help me spread!

