From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: Support for Logitech MX Anywhere 2
Date: Fri, 24 Mar 2017 15:22:20 +1000
Message-ID: <20170324052220.GB7307@jelly>
References: <20170322083222.6632f066@vento.lan>
 <20170323105956.GD26316@mail.corp.redhat.com>
 <20170323142900.185da144@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:62119 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754389AbdCXFWa (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Mar 2017 01:22:30 -0400
Content-Disposition: inline
In-Reply-To: <20170323142900.185da144@vento.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu, Mar 23, 2017 at 02:29:00PM -0300, Mauro Carvalho Chehab wrote:
> Em Thu, 23 Mar 2017 11:59:56 +0100
> Benjamin Tissoires <benjamin.tissoires@redhat.com> escreveu:
> > > With regards to ratchet, it probably makes sense to query its state
> > > when the driver starts, as IMHO, it should work on a way similar to
> > > <CAPS LOCK>. Btw, are there any event already defined for ratchet mode?  
> > 
> > There is not. And that's where the problem goes a little bit beyond just
> > enabling the feature, we need to forward this info to userspace.
> > 
> > There should be some EV_SWITCH SW_RATCHET created IMO. The ratchet has
> > a state, and we should be able to forward this state with such a new
> > event.
> > 
> > The thing I am more worried is how can we report the high-res wheel
> > events. I know Peter has a DB of wheel resolution, but in that case, we
> > can switch to high-res or not, so a static hwdb entry won't help.
> 
> Yes. In the case of high-res, there are actually two ways for those
> events to arrive:
> 
> In HID mode, it produces standard EV_REL / REL_WHEEL events, but there
> isn't any events reporting if the mode changed, nor the event with
> gets wheel axes movement tell if the mouse is in low or high res.
> 
> So, in HID mode, identifying if the wheel is in low or high res
> is not direct.
> 
> When the device is in HID+ mode, the resolution mode comes together with
> axes changes. So, it should be possible to define a different event
> for high-res wheel.
> 
> E. g. if the event reports high-res, it would be generating:
> EV_REL / REL_HI_RES_WHEEL. If the packet arrives with low-res,
> it will keep generating EV_REL / REL_WHEEL.
> 
> This way, Peter's code (libinput, I guess?) could handle it without
> requiring any DB for the devices that allow switching the mode.

sort-of. The main problem with relative axes is that we don't have a
resolution info. The reason we have a hwdb for wheels is that libinput
converts kernel data to physical dimensions so that callers can use the data
in a reliable manner. Switching to a hi-res-wheel just moves the problem
around a bit.

Using ABS events simply gives us the resolution in the inital description.
That's (I suspect) the only reason Benjamin suggested it. This isn't the
first time it has come up, it would be interesting to add something like
EVIOCGREL as equivalent to EVIOCGABS and start augmenting rel data with
resolution. But I also suspect that all but this use-case would have the
kernel return a digital shrug anyway, so I'm not sure it's worth the effort.

Cheers,
   Peter

> Another alternative would be to have a EV_SWITCH SW_HIRES event that
> would signal if the driver detects that the resolution switched.
> IMHO, this would be more generic, but would work on HID mode only
> if the driver would have some sort of check if the user commanded a
> resolution change, or do periodic polls.
> 
> > > 
> > > As I never touched on those HID drivers, could someone either add support
> > > for it or shed some light about what would be the proper way to add support
> > > for it?  
> > 
> > If we can agree on a proper evdev API for this (either using ABS event
> > or something else),
> 
> Using ABS event could work, but seems odd ;)
> 
> > then I should be able to implement this given that
> > the MX Master also exports the same feature.
> 
> Ah! good to know!
> 
> > But really, the code should
> > not be that much of an issue given that everything is already in place
> > in hid-logitech-hidpp.c.
> 
> Yeah, it seems that the changes aren't hard.
> 
> Thanks,
> Mauro
> 
