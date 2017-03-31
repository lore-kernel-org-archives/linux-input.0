From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Support for Logitech MX Anywhere 2
Date: Fri, 31 Mar 2017 12:03:08 +0200
Message-ID: <20170331100308.GN22683@mail.corp.redhat.com>
References: <20170322083222.6632f066@vento.lan>
 <20170323105956.GD26316@mail.corp.redhat.com>
 <20170323142900.185da144@vento.lan>
 <20170324052220.GB7307@jelly>
 <20170324065700.313d8019@vento.lan>
 <20170325093618.05324fa8@vento.lan>
 <20170325130210.3f798346@vento.lan>
 <20170327013845.GC21915@jelly>
 <20170327091701.68092cba@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754750AbdCaKDQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 31 Mar 2017 06:03:16 -0400
Content-Disposition: inline
In-Reply-To: <20170327091701.68092cba@vento.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mar 27 2017 or thereabouts, Mauro Carvalho Chehab wrote:
> Em Mon, 27 Mar 2017 11:38:45 +1000
> Peter Hutterer <peter.hutterer@who-t.net> escreveu:
> 
> > On Sat, Mar 25, 2017 at 01:02:10PM -0300, Mauro Carvalho Chehab wrote:
> > > Em Sat, 25 Mar 2017 09:36:18 -0300
> > > Mauro Carvalho Chehab <mchehab@s-opensource.com> escreveu:
> > >   
> > > > Em Fri, 24 Mar 2017 06:57:00 -0300
> > > > Mauro Carvalho Chehab <mchehab@s-opensource.com> escreveu:
> > > >   
> > > > > Em Fri, 24 Mar 2017 15:22:20 +1000
> > > > > Peter Hutterer <peter.hutterer@who-t.net> escreveu:
> > > > >     
> > > > > > On Thu, Mar 23, 2017 at 02:29:00PM -0300, Mauro Carvalho Chehab wrote:      
> > > > > > > Em Thu, 23 Mar 2017 11:59:56 +0100
> > > > > > > Benjamin Tissoires <benjamin.tissoires@redhat.com> escreveu:        
> > > > > > > > > With regards to ratchet, it probably makes sense to query its state
> > > > > > > > > when the driver starts, as IMHO, it should work on a way similar to
> > > > > > > > > <CAPS LOCK>. Btw, are there any event already defined for ratchet mode?          
> > > > > > > > 
> > > > > > > > There is not. And that's where the problem goes a little bit beyond just
> > > > > > > > enabling the feature, we need to forward this info to userspace.
> > > > > > > > 
> > > > > > > > There should be some EV_SWITCH SW_RATCHET created IMO. The ratchet has
> > > > > > > > a state, and we should be able to forward this state with such a new
> > > > > > > > event.
> > > > > > > > 
> > > > > > > > The thing I am more worried is how can we report the high-res wheel
> > > > > > > > events. I know Peter has a DB of wheel resolution, but in that case, we
> > > > > > > > can switch to high-res or not, so a static hwdb entry won't help.        
> > > > > > > 
> > > > > > > Yes. In the case of high-res, there are actually two ways for those
> > > > > > > events to arrive:
> > > > > > > 
> > > > > > > In HID mode, it produces standard EV_REL / REL_WHEEL events, but there
> > > > > > > isn't any events reporting if the mode changed, nor the event with
> > > > > > > gets wheel axes movement tell if the mouse is in low or high res.
> > > > > > > 
> > > > > > > So, in HID mode, identifying if the wheel is in low or high res
> > > > > > > is not direct.
> > > > > > > 
> > > > > > > When the device is in HID+ mode, the resolution mode comes together with
> > > > > > > axes changes. So, it should be possible to define a different event
> > > > > > > for high-res wheel.
> > > > > > > 
> > > > > > > E. g. if the event reports high-res, it would be generating:
> > > > > > > EV_REL / REL_HI_RES_WHEEL. If the packet arrives with low-res,
> > > > > > > it will keep generating EV_REL / REL_WHEEL.
> > > > > > > 
> > > > > > > This way, Peter's code (libinput, I guess?) could handle it without
> > > > > > > requiring any DB for the devices that allow switching the mode.        
> > > > > > 
> > > > > > sort-of. The main problem with relative axes is that we don't have a
> > > > > > resolution info. The reason we have a hwdb for wheels is that libinput
> > > > > > converts kernel data to physical dimensions so that callers can use the data
> > > > > > in a reliable manner. Switching to a hi-res-wheel just moves the problem
> > > > > > around a bit.
> > > > > > 
> > > > > > Using ABS events simply gives us the resolution in the inital description.
> > > > > > That's (I suspect) the only reason Benjamin suggested it. This isn't the
> > > > > > first time it has come up, it would be interesting to add something like
> > > > > > EVIOCGREL as equivalent to EVIOCGABS and start augmenting rel data with
> > > > > > resolution. But I also suspect that all but this use-case would have the
> > > > > > kernel return a digital shrug anyway, so I'm not sure it's worth the effort.      
> > > > > 
> > > > > I see. Well, at least in the case of the feature supported by this
> > > > > mouse, there are just two possible resolutions: low-res and high-res.
> > > > > The high-res resolution is fixed[1].
> > > > > 
> > > > > As the multiplier has a fixed value per device, a hwdb could still
> > > > > work, provided that high-res wheel events would produce a different
> > > > > event code than low-res.
> > > > > 
> > > > > [1] there's a USB message that can be used to query the multiplier,
> > > > > with is always equal to 8 for MX Anywhere 2. No idea if other
> > > > > devices with this feature use the same multiplier.    
> > 
> > let's not assume that and plan ahead, because sooner or later this will be
> > configurable in some device. Probably before we get the first kernel out
> > with this patchset in. :)
> 
> Yeah, it sounds likely that newer devices may allow to set it.
> 
> But the actual question here is: how userspace would handle it?
> 
> When the device is in ratchet mode (e. g. in "discrete" mode), the number
> of events received for a single ratchet position movement should be multiple
> of the high-res multiplier.
> 
> For example, MX Anywhere 2 has a fixed resolution (HID++ feature
> reports multiplier == 8).
> 
> On this device, moving the wheel down just one ratchet position,
> in low-res mode it produces just one event:
> 
> URBs:
> >>> 11 03 0b 00 01 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> events:
> 1490616222.091664: event type EV_REL(0x02): REL_WHEEL (0x0008) value=-1
> 1490616222.091664: event type EV_SYN(0x00).
> 
> in high-resolution mode, the same movement produces 8 events:
> 
> URBs:
> >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00

I wonder if in that case, the driver shouldn't convert those into a
single REL_WHEEL. The driver knows the state of the ratchet and can
detect such situation (and also match if the multiplier is user
configurable).

OTOH, if the highres wheel has the correct settings in the hwdb, there
is no reasons for libinput to not handle the 8 highres events equal one
line given that it already converts the incoming events into physical
dimensions. 

> 
> events:
> 1490616255.382047: event type EV_REL(0x02): REL_HIRES_WHEEL (0x000a) value=-1
> 1490616255.382047: event type EV_SYN(0x00).
> 1490616255.434046: event type EV_REL(0x02): REL_HIRES_WHEEL (0x000a) value=-1
> 1490616255.434046: event type EV_SYN(0x00).
> 1490616255.462060: event type EV_REL(0x02): REL_HIRES_WHEEL (0x000a) value=-1
> 1490616255.462060: event type EV_SYN(0x00).
> 1490616255.477994: event type EV_REL(0x02): REL_HIRES_WHEEL (0x000a) value=-1
> 1490616255.477994: event type EV_SYN(0x00).
> 1490616255.502022: event type EV_REL(0x02): REL_HIRES_WHEEL (0x000a) value=-1
> 1490616255.502022: event type EV_SYN(0x00).
> 1490616255.510016: event type EV_REL(0x02): REL_HIRES_WHEEL (0x000a) value=-1
> 1490616255.510016: event type EV_SYN(0x00).
> 1490616255.542061: event type EV_REL(0x02): REL_HIRES_WHEEL (0x000a) value=-1
> 1490616255.542061: event type EV_SYN(0x00).
> 1490616255.584051: event type EV_REL(0x02): REL_HIRES_WHEEL (0x000a) value=-1
> 1490616255.584051: event type EV_SYN(0x00).
> 
> Assuming that the user is, for example, navigating on a browser,
> he would likely be expecting that one ratchet position will scroll
> just one line of text, no matter in what resolution. E. g. the
> scroll delta should be calculated by:
> 
> 	float delta = evdev.value / (multiplier * 1.0)
> 
> ---
> 
> Assuming that, we'll have, on some future, a mouse with a adjustable
> wheel resolution with a multiplier between 1 and 8, when the wheel
> is in free wheel mode, the delta logic could, instead, assume a value
> in the middle of the multiplier range, e. g.:
> 
> 	float delta = evdev.value / 4.0
> 
> This way, changing the wheel resolution would cause the text
> to scroll faster of slower, with would likely be what the
> user wants when changing the wheel resolution and placing the
> wheel in free wheel mode.
> 
> > a hwdb could still work in that case, but it gets quite tricky when it
> > becomes user-configurable. Now you need the user (or supporting software) to
> > drop hwdb in entries which is less than ideal. If there is a value that can
> > be queried from the device, we should figure out how to use it.
> 
> Querying the value is easy, but we'll need to report it somehow to
> userspace.
> 
> We could report it either via some ioctl that would be enum/query/set
> the wheel resolution (similar to EVIOCGABS/EVIOCSABS) or via some
> event that would be report via read() telling about wheel
> resolution changes.

I know we have user configurable mouse resolutions, but do you really
believe we will have user configurable wheel resolution? That seems a
little bit unlikely to me and if it really happens, it would be a FW
trick to change the scrolling speed (like the user configurable
resolution is a FW trick to change the mouse speed).

So I'd say let's focus on a fixed wheel resolution (one for normal
wheel, one for highres) and really start thinking at user configurable
mouse wheel resolution when the device becomes available and that we
have a proper use case for it.

> 
> On the latter, we could, for example, create an EV_SW for resolution

Note that EV_SW is used for switches, like the physical switches that
have a state (on-off).

> change that would be generated if the resolution of the new event is
> different than the previously reported one. On this device, detecting
> the resolution is trivial, as every events report it, but we have no
> means to know how some other device would implement it.
> 
> > > > What I'm proposing is basically something like what's in the patch
> > > > below (for now, just compile-tested).
> > > > 
> > > > So, for MX Anywhere 2 and MX master, the hid-logitech-hidpp driver should
> > > > switch to the HID++ report mode at device connect and handle the Wheel
> > > > events. If the wheel event is low res, will generate
> > > > REL_WHEEL events. if the wheel is in high resolution, REL_HWHEEL.  
> > > 
> > > Hmm... "H" in HWHEEL is not for "hardware" or "high-res", but,
> > > instead, for "horizontal".  
> > 
> > yep :)
> > 
> > > So, if we'd go for the proposal of using a different event for high-res
> > > vertical wheel, instead of adding a new ioctl (EVIOCGREL as equivalent to
> > > EVIOCGABS), we'll need an extra event.
> > > 
> > > Anyway, the patch below works fine with my mouse. It is against
> > > Kernel 4.10.4.  
> > 
> > quick skim of the patch looks ok, but the big issue with this isn't the
> > technical bit but the policy bit. 
> 
> Yes.
> 
> > So the last hunk adding the event code
> > should accompanied by a Documentation/input/event-codes.txt hunk, explaining
> > the use of the code and how it interacts with the other event codes.
> > You'll probably find that as you write that documentation, more
> > questions will come up.
> 
> Sure I will document it, but we should first define how we'll report it,
> e. g. as a different event (like proposed on this RFC), via new ioctls or
> via a resolution change event.

I would be happy with the new event. Dmitry would need to validate the
change, but it seems the best choice for me. Then, I would suggest
masking the ratchet button and events from the userspace in the driver,
so that the burden of handling the highres wheel doesn't get too
complex. I think libinput handles the wheel as physical dimensions, so
it should be able to handle properly the highres wheel. xorg-input-evdev
would need some update though.

Cheers,
Benjamin

> 
> Thanks,
> Mauro
