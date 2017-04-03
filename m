From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: Support for Logitech MX Anywhere 2
Date: Mon, 3 Apr 2017 09:49:03 -0300
Message-ID: <20170403094903.3b574351@vento.lan>
References: <20170323142900.185da144@vento.lan>
        <20170324052220.GB7307@jelly>
        <20170324065700.313d8019@vento.lan>
        <20170325093618.05324fa8@vento.lan>
        <20170325130210.3f798346@vento.lan>
        <20170327013845.GC21915@jelly>
        <20170327091701.68092cba@vento.lan>
        <20170331100308.GN22683@mail.corp.redhat.com>
        <20170331075317.396020fa@vento.lan>
        <20170331122827.GP22683@mail.corp.redhat.com>
        <20170403044307.GA2249@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:58352
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752489AbdDCMtK (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 3 Apr 2017 08:49:10 -0400
In-Reply-To: <20170403044307.GA2249@jelly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Em Mon, 3 Apr 2017 14:43:07 +1000
Peter Hutterer <peter.hutterer@who-t.net> escreveu:

> On Fri, Mar 31, 2017 at 02:28:27PM +0200, Benjamin Tissoires wrote:
> > On Mar 31 2017 or thereabouts, Mauro Carvalho Chehab wrote:  
> > > Em Fri, 31 Mar 2017 12:03:08 +0200
> > > Benjamin Tissoires <benjamin.tissoires@redhat.com> escreveu:
> > >   
> > > > On Mar 27 2017 or thereabouts, Mauro Carvalho Chehab wrote:  
> > > > > Em Mon, 27 Mar 2017 11:38:45 +1000
> > > > > Peter Hutterer <peter.hutterer@who-t.net> escreveu:
> > > > >     
> > > > > > On Sat, Mar 25, 2017 at 01:02:10PM -0300, Mauro Carvalho Chehab wrote:    
> > > > > > > Em Sat, 25 Mar 2017 09:36:18 -0300
> > > > > > > Mauro Carvalho Chehab <mchehab@s-opensource.com> escreveu:
> > > > > > >       
> > > > > > > > Em Fri, 24 Mar 2017 06:57:00 -0300
> > > > > > > > Mauro Carvalho Chehab <mchehab@s-opensource.com> escreveu:
> > > > > > > >       
> > > > > > > > > Em Fri, 24 Mar 2017 15:22:20 +1000
> > > > > > > > > Peter Hutterer <peter.hutterer@who-t.net> escreveu:
> > > > > > > > >         
> > > > > > > > > > On Thu, Mar 23, 2017 at 02:29:00PM -0300, Mauro Carvalho Chehab wrote:          
> > > > > > > > > > > Em Thu, 23 Mar 2017 11:59:56 +0100
> > > > > > > > > > > Benjamin Tissoires <benjamin.tissoires@redhat.com> escreveu:            
> > > > > > > > > > > > > With regards to ratchet, it probably makes sense to query its state
> > > > > > > > > > > > > when the driver starts, as IMHO, it should work on a way similar to
> > > > > > > > > > > > > <CAPS LOCK>. Btw, are there any event already defined for ratchet mode?              
> > > > > > > > > > > > 
> > > > > > > > > > > > There is not. And that's where the problem goes a little bit beyond just
> > > > > > > > > > > > enabling the feature, we need to forward this info to userspace.
> > > > > > > > > > > > 
> > > > > > > > > > > > There should be some EV_SWITCH SW_RATCHET created IMO. The ratchet has
> > > > > > > > > > > > a state, and we should be able to forward this state with such a new
> > > > > > > > > > > > event.
> > > > > > > > > > > > 
> > > > > > > > > > > > The thing I am more worried is how can we report the high-res wheel
> > > > > > > > > > > > events. I know Peter has a DB of wheel resolution, but in that case, we
> > > > > > > > > > > > can switch to high-res or not, so a static hwdb entry won't help.            
> > > > > > > > > > > 
> > > > > > > > > > > Yes. In the case of high-res, there are actually two ways for those
> > > > > > > > > > > events to arrive:
> > > > > > > > > > > 
> > > > > > > > > > > In HID mode, it produces standard EV_REL / REL_WHEEL events, but there
> > > > > > > > > > > isn't any events reporting if the mode changed, nor the event with
> > > > > > > > > > > gets wheel axes movement tell if the mouse is in low or high res.
> > > > > > > > > > > 
> > > > > > > > > > > So, in HID mode, identifying if the wheel is in low or high res
> > > > > > > > > > > is not direct.
> > > > > > > > > > > 
> > > > > > > > > > > When the device is in HID+ mode, the resolution mode comes together with
> > > > > > > > > > > axes changes. So, it should be possible to define a different event
> > > > > > > > > > > for high-res wheel.
> > > > > > > > > > > 
> > > > > > > > > > > E. g. if the event reports high-res, it would be generating:
> > > > > > > > > > > EV_REL / REL_HI_RES_WHEEL. If the packet arrives with low-res,
> > > > > > > > > > > it will keep generating EV_REL / REL_WHEEL.
> > > > > > > > > > > 
> > > > > > > > > > > This way, Peter's code (libinput, I guess?) could handle it without
> > > > > > > > > > > requiring any DB for the devices that allow switching the mode.            
> > > > > > > > > > 
> > > > > > > > > > sort-of. The main problem with relative axes is that we don't have a
> > > > > > > > > > resolution info. The reason we have a hwdb for wheels is that libinput
> > > > > > > > > > converts kernel data to physical dimensions so that callers can use the data
> > > > > > > > > > in a reliable manner. Switching to a hi-res-wheel just moves the problem
> > > > > > > > > > around a bit.
> > > > > > > > > > 
> > > > > > > > > > Using ABS events simply gives us the resolution in the inital description.
> > > > > > > > > > That's (I suspect) the only reason Benjamin suggested it. This isn't the
> > > > > > > > > > first time it has come up, it would be interesting to add something like
> > > > > > > > > > EVIOCGREL as equivalent to EVIOCGABS and start augmenting rel data with
> > > > > > > > > > resolution. But I also suspect that all but this use-case would have the
> > > > > > > > > > kernel return a digital shrug anyway, so I'm not sure it's worth the effort.          
> > > > > > > > > 
> > > > > > > > > I see. Well, at least in the case of the feature supported by this
> > > > > > > > > mouse, there are just two possible resolutions: low-res and high-res.
> > > > > > > > > The high-res resolution is fixed[1].
> > > > > > > > > 
> > > > > > > > > As the multiplier has a fixed value per device, a hwdb could still
> > > > > > > > > work, provided that high-res wheel events would produce a different
> > > > > > > > > event code than low-res.
> > > > > > > > > 
> > > > > > > > > [1] there's a USB message that can be used to query the multiplier,
> > > > > > > > > with is always equal to 8 for MX Anywhere 2. No idea if other
> > > > > > > > > devices with this feature use the same multiplier.        
> > > > > > 
> > > > > > let's not assume that and plan ahead, because sooner or later this will be
> > > > > > configurable in some device. Probably before we get the first kernel out
> > > > > > with this patchset in. :)    
> > > > > 
> > > > > Yeah, it sounds likely that newer devices may allow to set it.
> > > > > 
> > > > > But the actual question here is: how userspace would handle it?
> > > > > 
> > > > > When the device is in ratchet mode (e. g. in "discrete" mode), the number
> > > > > of events received for a single ratchet position movement should be multiple
> > > > > of the high-res multiplier.
> > > > > 
> > > > > For example, MX Anywhere 2 has a fixed resolution (HID++ feature
> > > > > reports multiplier == 8).
> > > > > 
> > > > > On this device, moving the wheel down just one ratchet position,
> > > > > in low-res mode it produces just one event:
> > > > > 
> > > > > URBs:    
> > > > > >>> 11 03 0b 00 01 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00    
> > > > > 
> > > > > events:
> > > > > 1490616222.091664: event type EV_REL(0x02): REL_WHEEL (0x0008) value=-1
> > > > > 1490616222.091664: event type EV_SYN(0x00).
> > > > > 
> > > > > in high-resolution mode, the same movement produces 8 events:
> > > > > 
> > > > > URBs:    
> > > > > >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00    
> > > > 
> > > > I wonder if in that case, the driver shouldn't convert those into a
> > > > single REL_WHEEL. The driver knows the state of the ratchet and can
> > > > detect such situation (and also match if the multiplier is user
> > > > configurable).  
> > > 
> > > IMHO, it shouldn't. While you have the finger at the wheel, you
> > > can control the speed of the movement. You can also decide you
> > > don't want to scroll and return to the previous position, like
> > > on this movement (here, I moved the wheel down, slowly, then
> > > I returned it back to the original position, on a fast move):
> > > 
> > > 000033934 ms 000734 ms (783955 us EP=83, Dev=08) >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 000034718 ms 000784 ms (119937 us EP=83, Dev=08) >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 000034838 ms 000120 ms (075936 us EP=83, Dev=08) >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 000034914 ms 000076 ms (097951 us EP=83, Dev=08) >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 000035012 ms 000098 ms (071950 us EP=83, Dev=08) >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 000035084 ms 000072 ms (143879 us EP=83, Dev=08) >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 000035228 ms 000144 ms (312011 us EP=83, Dev=08) >>> 11 03 0b 00 11 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 000035540 ms 000312 ms (2213961 us EP=83, Dev=08) >>> 11 03 0b 00 11 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 000037754 ms 002214 ms (075957 us EP=83, Dev=08) >>> 11 03 0b 00 11 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 000037830 ms 000076 ms (031940 us EP=83, Dev=08) >>> 11 03 0b 00 11 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 000037862 ms 000032 ms (015955 us EP=83, Dev=08) >>> 11 03 0b 00 11 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 000037878 ms 000016 ms (023917 us EP=83, Dev=08) >>> 11 03 0b 00 11 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 000037902 ms 000024 ms (023955 us EP=83, Dev=08) >>> 11 03 0b 00 11 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 000037926 ms 000024 ms (029959 us EP=83, Dev=08) >>> 11 03 0b 00 11 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 
> > > If I was scrolling a screen that would allow scrolling on less than a
> > > line, I would expect the screen to follow the speed of my finger.  
> > 
> > Alright.
> >  
> > > > OTOH, if the highres wheel has the correct settings in the hwdb, there
> > > > is no reasons for libinput to not handle the 8 highres events equal one
> > > > line given that it already converts the incoming events into physical
> > > > dimensions.   
> > > 
> > > Yes.  
> 
> I *think* this should be possible with the current libinput, without even
> exposing more API. libinput provides a scroll delta for wheels in degrees
> and a 'discrete' value, it would be fairly trivial to hook up the highres to
> the degrees only and use the discrete as cumulative. So you'd get a sequence
> like this:
>    scroll event (deg 2, discrete 0)
>    scroll event (deg 2, discrete 0)
>    scroll event (deg 2, discrete 0)
>    scroll event (deg 2, discrete 1)
> 
> a client that supports this, and I think current clients should basically
> already support this can pick between normal and hires, without extra code.
> what the impact of this is, I don't quite know yet.

Hmm... if I understood well, the idea would be to use something
similar to udev's MOUSE_WHEEL_CLICK_ANGLE, like[1]:

	mouse:usb:v046dp404a:name:Logitech Anywhere Mouse MX 2:
	mouse:usb:v046dpc52b:name:Logitech Unifying Device. Wireless PID:404a:
	MOUSE_WHEEL_CLICK_ANGLE=16

[1] I measured the real wheel angle here. In low-resolution, there are 18
steps at the wheel (in ratchet mode), meaning 20 degrees. It means that, 
in high-resolution, where multiplier = 8, the minimum angle to produce an
event would be 2.5 degrees.

And add a code at libinput similar to this [2]:

diff --git a/src/evdev.c b/src/evdev.c
index 2a57b25835fe..b5198ca6154d 100644
--- a/src/evdev.c
+++ b/src/evdev.c
@@ -1023,6 +1023,24 @@ fallback_process_relative(struct fallback_dispatch *dispatch,
 			&wheel_degrees,
 			&discrete);
 		break;
+	case REL_HIRES_WHEEL:
+		fallback_flush_pending_event(dispatch, device, time);
+		wheel_degrees.y = -1 * e->value *
+					device->scroll.wheel_click_angle.x / 8;
+		discrete.y = -1 * e->value;
+
+		source = device->scroll.is_tilt.vertical ?
+				LIBINPUT_POINTER_AXIS_SOURCE_WHEEL_TILT:
+				LIBINPUT_POINTER_AXIS_SOURCE_WHEEL;
+
+		evdev_notify_axis(
+			device,
+			time,
+			AS_MASK(LIBINPUT_POINTER_AXIS_SCROLL_VERTICAL),
+			source,
+			&wheel_degrees,
+			&discrete);
+		break;
 	case REL_HWHEEL:
 		fallback_flush_pending_event(dispatch, device, time);
 		wheel_degrees.x = e->value *

[2] I hardcoded there a multiply of 8, e. g. I'm doing:

		wheel_degrees.y = -1 * e->value *
					device->scroll.wheel_click_angle.x / 8;

Just to as a quick test code, but, ideally, the multiplier should either
be obtained via some ioctl or come from some udev property, e. g. either
a MOUSE_WHEEL_MULTIPLIER or a MOUSE_WHEEL_HIRES_CLICK_ANGLE property.

I'll do some tests here with the above code, and see if it does what's
expected.


Thanks,
Mauro
