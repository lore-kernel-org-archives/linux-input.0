From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC] Wiimote userspace interface
Date: Wed, 10 Aug 2011 13:57:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1108101355360.32288@pobox.suse.cz>
References: <CANq1E4S3VY_xxzcjuJDHJc57VPb_uiFrx1B3wR9Xnw5ddx6HJg@mail.gmail.com> <20110803061744.GB23399@core.coreip.homeip.net> <CANq1E4QgF6i2UJQpaRDkOf-vwGH9vMfU9HfL8O8Rt38uup3qew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34524 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752826Ab1HJL5t (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Aug 2011 07:57:49 -0400
In-Reply-To: <CANq1E4QgF6i2UJQpaRDkOf-vwGH9vMfU9HfL8O8Rt38uup3qew@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, "Gustavo F. Padovan" <padovan@profusion.mobi>, Oliver Neukum <oneukum@suse.de>

On Wed, 3 Aug 2011, David Herrmann wrote:

> >> There is also the other side. Sending data to the wiimote. 4 LEDs can
> >> be set, the rumble motor can be enabled/disabled and audio data can be
> >> streamed. I think my current approach to use sysfs attributes for the
> >> LEDs
> >
> > Depending on what exactly it is you may try registering LEDs as LED
> > class devices. Having a sysfs attribute to light one of 4 leds is an
> > option too.
> 
> I already looked at the API. Although the 4 LEDs of the wiimote can
> only be switched on/off (no brightness modulation) I think I could
> register 4 led_classdev structures. This would also allow software
> blinking.

Yes, I'd prefer that as well.

> >> and RUMBLE motor is ok? I can't figure out any better way here.
> >
> > One of the input devices should be registered as ForceFeedback device
> > (or you create a separate FF input device).
> 
> Ok, I will add that.

Perfect, thanks. You can find quite some examples of force feedback 
implementations even in drivers/hid as well, to gain some inspiration.

> >> Reference-counting doesn't make sense. If multiple devices use them,
> >> then they will always have conflicts, however, it still works.
> >> Audio streaming is not yet implemented, but I think I could register
> >> an alsa device so this needs not to be discussed here.
> >>
> >>
> >> Currently I think Interface #2 would be the best way but I don't want
> >> to spend time implementing that if you tell me it isn't acceptable.
> >> Any comments on this are appreciated.
> >
> > I believe you should try presenting physical objects as input devices so
> > I'd try presenting wiimote (with optional motion+ events) as one device
> > and accessory (nunchuck, classic extension) as another device.
> 
> Yes, but the problem is, that this would enable all peripherals of the
> wiimote, even though userspace may not need them. But if that is the
> recommended way, I will implement it.

Is there any problem with that? I could potentialy imagine unnecessary 
power consumption (assuming that the peripherals that are not enabled are 
in some lower state, right?). Anything else?

Thanks a lot for your work on the driver, David.

-- 
Jiri Kosina
SUSE Labs
