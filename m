From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ABS_MAX incrementation?
Date: Tue, 20 Apr 2010 23:29:29 -0700
Message-ID: <20100421062929.GH4364@core.coreip.homeip.net>
References: <20100419171412.GH30801@buzzloop.caiaq.de>
 <20100419174924.GB22295@core.coreip.homeip.net>
 <20100419180606.GI30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40574 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab0DUG3h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 02:29:37 -0400
Received: by gyg13 with SMTP id 13so3649479gyg.19
        for <linux-input@vger.kernel.org>; Tue, 20 Apr 2010 23:29:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100419180606.GI30801@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org

On Mon, Apr 19, 2010 at 08:06:06PM +0200, Daniel Mack wrote:
> Hi Dmitry,
> 
> On Mon, Apr 19, 2010 at 10:49:25AM -0700, Dmitry Torokhov wrote:
> > On Mon, Apr 19, 2010 at 07:14:12PM +0200, Daniel Mack wrote:
> > > Hi,
> > > 
> > > I'm planning to write a driver for a device with a number of absolute
> > > axis and 16 pressure-sensitive trigger pads. Alltogether, it will have
> > > more absoulte axis informations than the API in include/input.h is able
> > > to represent. More than that, the definitions I'm referring to won't
> > > describe the actual information in a sane way. I'm uncertain whether
> > > this list can be extended by something like the patch below. Or is this
> > > a nonono as it breaks existing user space applications? Any other idea
> > > of how to solve this?
> > >
> > 
> > Extending the number of axes should be possible (we have done that for
> > number of keys/buttons not that long ago) and yes, userspace breakages
> > are possible but are most likely userspace fault.
> 
> In worst case, they'll drop the events due to sanity check constraints,
> right?

Synaptics driver did crash (dies to stack smashing) so potential effects
are more sinister. Still, if we need to extend it we shoudl to it and
either update userspace or add workarounds in the kernel.

> 
> > The fact that data is purely device specific is a bit disconcerning, but
> > I understand that not every device uses commonly defined events. It _is_
> > an input device though, right?
> 
> It is a mixed MIDI/input device, yes. As it will most likely be used
> for music production, I could also consider using MIDI for transport.
> However, other devices supported by this driver (sound/usb/caiaq) use
> the input subsystem for passing values up to the userspace.


I see.

> 
> > I wonder if ofr this kinde of "flex" pads we could move into 2-event
> > notification so as not to expand the number of "axes" forever - use
> > ABS_PAD to transmit pad number and ABS_MISC to transmit actual value.
> > Such scheme will not allow comminucate min and max values for dpads
> > though, so not very good...
> 
> Events from these pads will also occur quite frequently as the
> resoultion is 12 bits. There will be quite some noise which should be
> filtered by the user space application. So I believe the 2-event
> approach would add quite some overhead as it doubles the amount of
> messages being passed.

Theoretically you could "defuzz" in driver limiting data rate still.

> 
> As we're on it - I'm quite unhappy with the allocation of the buttons
> in the snd-usb-caiaq driver. I merely abuse valid values from enums
> that are defined in input.h and leave it to the userspace to map things
> back to their original meaning. Is there any change to introduce a more
> dynamic model which describes buttons by given strings rather than
> enums? Such an interface could also well be be used for ABS entities,
> and that would also solve the problem I currently have. Userspace should
> then have a way to query an entity's name for these special cases.

Unfortunately input layer is not well-suited for device-specific data. I
understand that some devices are pretty domain-specific and do not fit
into standard model of event describing intended useage for everyone. I
am open to sugggestions/RFC-style patches.

> 
> > Another issue is that ABS data is pretty large, it would be nice if we
> > moved from this data being always present ininput device structure to
> > having drivers allocate it when needed.
> 
> Ah, the struct has ABS_MAX as length for a fix-sized array, I see. Hmm.
> Then we shouldn't make that bigger for such reasons, I agree.
>

Alocating data dynamically was on my todo list forever. Maybe someone
will beat me to it *wink, wink*

-- 
Dmitry
