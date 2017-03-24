From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: Support for Logitech MX Anywhere 2
Date: Fri, 24 Mar 2017 06:57:00 -0300
Message-ID: <20170324065700.313d8019@vento.lan>
References: <20170322083222.6632f066@vento.lan>
        <20170323105956.GD26316@mail.corp.redhat.com>
        <20170323142900.185da144@vento.lan>
        <20170324052220.GB7307@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:55837
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752109AbdCXJ5J (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Mar 2017 05:57:09 -0400
In-Reply-To: <20170324052220.GB7307@jelly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Em Fri, 24 Mar 2017 15:22:20 +1000
Peter Hutterer <peter.hutterer@who-t.net> escreveu:

> On Thu, Mar 23, 2017 at 02:29:00PM -0300, Mauro Carvalho Chehab wrote:
> > Em Thu, 23 Mar 2017 11:59:56 +0100
> > Benjamin Tissoires <benjamin.tissoires@redhat.com> escreveu:  
> > > > With regards to ratchet, it probably makes sense to query its state
> > > > when the driver starts, as IMHO, it should work on a way similar to
> > > > <CAPS LOCK>. Btw, are there any event already defined for ratchet mode?    
> > > 
> > > There is not. And that's where the problem goes a little bit beyond just
> > > enabling the feature, we need to forward this info to userspace.
> > > 
> > > There should be some EV_SWITCH SW_RATCHET created IMO. The ratchet has
> > > a state, and we should be able to forward this state with such a new
> > > event.
> > > 
> > > The thing I am more worried is how can we report the high-res wheel
> > > events. I know Peter has a DB of wheel resolution, but in that case, we
> > > can switch to high-res or not, so a static hwdb entry won't help.  
> > 
> > Yes. In the case of high-res, there are actually two ways for those
> > events to arrive:
> > 
> > In HID mode, it produces standard EV_REL / REL_WHEEL events, but there
> > isn't any events reporting if the mode changed, nor the event with
> > gets wheel axes movement tell if the mouse is in low or high res.
> > 
> > So, in HID mode, identifying if the wheel is in low or high res
> > is not direct.
> > 
> > When the device is in HID+ mode, the resolution mode comes together with
> > axes changes. So, it should be possible to define a different event
> > for high-res wheel.
> > 
> > E. g. if the event reports high-res, it would be generating:
> > EV_REL / REL_HI_RES_WHEEL. If the packet arrives with low-res,
> > it will keep generating EV_REL / REL_WHEEL.
> > 
> > This way, Peter's code (libinput, I guess?) could handle it without
> > requiring any DB for the devices that allow switching the mode.  
> 
> sort-of. The main problem with relative axes is that we don't have a
> resolution info. The reason we have a hwdb for wheels is that libinput
> converts kernel data to physical dimensions so that callers can use the data
> in a reliable manner. Switching to a hi-res-wheel just moves the problem
> around a bit.
> 
> Using ABS events simply gives us the resolution in the inital description.
> That's (I suspect) the only reason Benjamin suggested it. This isn't the
> first time it has come up, it would be interesting to add something like
> EVIOCGREL as equivalent to EVIOCGABS and start augmenting rel data with
> resolution. But I also suspect that all but this use-case would have the
> kernel return a digital shrug anyway, so I'm not sure it's worth the effort.

I see. Well, at least in the case of the feature supported by this
mouse, there are just two possible resolutions: low-res and high-res.
The high-res resolution is fixed[1].

As the multiplier has a fixed value per device, a hwdb could still
work, provided that high-res wheel events would produce a different
event code than low-res.

[1] there's a USB message that can be used to query the multiplier,
with is always equal to 8 for MX Anywhere 2. No idea if other
devices with this feature use the same multiplier.

Regards,
Mauro
