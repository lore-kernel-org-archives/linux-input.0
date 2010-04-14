From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: joystick with large number of buttons
Date: Wed, 14 Apr 2010 09:29:14 -0700
Message-ID: <20100414162912.GE2450@core.coreip.homeip.net>
References: <6121ee741003271645i2f091b9bq566edaa12b4b3561@mail.gmail.com>
 <alpine.LNX.2.00.1003301411070.24576@pobox.suse.cz>
 <6121ee741003300520r25a1d46dm189ee034272fa514@mail.gmail.com>
 <x2y6121ee741003310400sf3f36c09g2fad909fd11166a3@mail.gmail.com>
 <s2t6121ee741004010116nf1c9ba7et4aff02c48ccf9f63@mail.gmail.com>
 <alpine.LNX.2.00.1004011121240.8345@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:48514 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756357Ab0DNQ33 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 12:29:29 -0400
Received: by bwz25 with SMTP id 25so389062bwz.28
        for <linux-input@vger.kernel.org>; Wed, 14 Apr 2010 09:29:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1004011121240.8345@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Attila Nagy <nagy.attila.gabor@gmail.com>, stefan.bader@canonical.com, linux-input@vger.kernel.org

On Thu, Apr 01, 2010 at 11:23:16AM +0200, Jiri Kosina wrote:
> On Thu, 1 Apr 2010, Attila Nagy wrote:
> 
> > >>>> I've just found this thread:
> > >>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/492056 and the
> > >>>> following patch:
> > >>>> http://launchpadlibrarian.net/38497329/0001-HID-handle-joysticks-with-large-number-of-buttons.patch
> > >>>>
> > >>>> If I understand, this pushes the limit on the number of the buttons
> > >>>> per joystick to 56?
> > >>>>
> > >>>> Shouldn't this limit be raised to some more? In fact if I understand
> > >>>> the HID specification one could define 65K buttons per device. Well
> > >>>> that's a bit silly, but I found this bug when I was about to build a
> > >>>> hid device that has 64 buttons (or maybe more).
> > >>>>
> > >>>> I wonder if there's a possibility to push this limit a bit further? I
> > >>>> guess 256 could be a reasonable limit for a while.
> > >>>
> > >>> Is this still a joystick though? Wouldn't it better to have those be KEY_*
> > >>> events?
> > >>
> > >> Thanks for your reply.
> > >>
> > >> This is a bit philosophical question. In the practical side people
> > >> like me choose to implement joystick hardware, because games have a
> > >> decent support for joys with many buttons. If I have an interface,
> > >> that has 64 buttons, I can map them in a game to functions as I want,
> > >> without interferencing with the keyboard events.
> > >>
> > >> In the terms of the HID usage tables, one might should define these
> > >> things as a game pad, or a "simulation control device", but support
> > >> for such devices in current operating systems isn't that self
> > >> understanding like support for a joystick.
> > > I'll test it with 128 buttons today.
> > 
> > I've tried 128 buttons. Currently the mapping space goes until 0x2ff,
> > thus leaving room for 64 effective buttons per device. Over that only
> > the lower 64 is reported and working, buttons over that are silently
> > ignored.
> > 
> > The attached patch raises this limit to 128 per device. Only two
> > constants need to be modified, and after that everything did work fine
> > for me.
> > 
> > Could this hurt something, I didn't notice?
> > 
> > 
> > [if I'm knocking on the wrong door, then please redirect me to the
> > appropriate people]
> 
> This should definitely go through Dmitry. Adding him, and linux-input@, to 
> CC.
> 

I do not think it makes much sense - userspace has no way of knowing
what actions these 'events' are supposed to signal (as opposed to
BTN_THUMB, etc). These are purely programmable. So instead of inflating
keymap tables, maybe such devices should just use ABS_MISC to transmit
state and we may even think about teaching joydev to recognize it.

-- 
Dmitry
