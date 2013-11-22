From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: Re: [PATCH] Input: Add new driver for GPIO beeper
Date: Fri, 22 Nov 2013 21:28:22 +0400
Message-ID: <20131122212822.7c6983c307ab6755183e54f1@mail.ru>
References: <1384250833-4600-1-git-send-email-shc_work@mail.ru>
	<20131112101544.GD2976@e106331-lin.cambridge.arm.com>
	<1384253277.731839001@f27.i.mail.ru>
	<20131112105930.GE2976@e106331-lin.cambridge.arm.com>
	<52828042.4050501@wwwdotorg.org>
	<20131119213239.GC25784@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131119213239.GC25784-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 19 Nov 2013 13:32:39 -0800
Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> > >>>> This patch adds a new driver for the beeper controlled via GPIO pin.
> > >>>> The driver does not depend on the architecture and is positioned as
> > >>>> a replacement for the specific drivers that are used for this function.
> > >>>>
> > >>>> Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
> > >> ...
> > >>>> diff --git a/Documentation/devicetree/bindings/input/gpio-beeper.txt b/Documentation/devicetree/bindings/input/gpio-beeper.txt
> > >> ...
> > >>>> +Example:
> > >>>> +
> > >>>> +beeper: input@0 {
> > >>>> +	compatible = "gpio-beeper";
> > >>>> +	reg = <0>;
> > >>>> +	gpios = <&gpio3 23 0>;
> > >>>> +};
> > >>>
> > >>> What are the reg / unit-address for?
> > >>
> > >> Just an example from "simple-bus" container.
> > > 
> > > If they have no meaning, they should go. They're unnecessary and make
> > > things more confusing.
> > > 
> > > I'd expect the example to be:
> > > 
> > > beeper: beeper {
> > > 	compatible = "gpio-beeper";
> > > 	gpios - <&gpio3 23 0>;
> > > };
> > > 
> > > And if we have multiple beepers, something like:
> > > 
> > > beeper0: beeper0 { ... };
> > > beeper1: beeper1 { ... };
> > 
> > DT node names aren't meant to encode identity though. What we've done in
> > the past for nodes without a reg where multiple instances were desired
> > is to put them into simple-bus and add a reg, so:
> > 
> > beeper0: beeper@0 { reg = <0>; ... };
> > beeper1: beeper@1 { reg = <1>; ... };
> > 
> > Of course, if there's only one of them, then it could just be "beeper"
> > with no reg. The binding and example should probably reflect that simple
> > case.
> 
> So do we have an agreement on bindings? Otherwise the driver looks good
> to me.

I'll send v2 of this patch.
Thanks.

-- 
Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
