From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Thu, 11 Nov 2010 00:26:54 -0800
Message-ID: <20101111082653.GC24415@core.coreip.homeip.net>
References: <20101109033149.GC19313@barra.redhat.com>
 <20101109065933.GA13921@core.coreip.homeip.net>
 <AANLkTi=rxkJcmp8WLKCRnxqNd_1QBT4W_2YJNJBcsHzF@mail.gmail.com>
 <AANLkTimPUYXe=Pno8O2k_U7u9N+ob6EQMD_DCDtLDTS5@mail.gmail.com>
 <20101110050219.GB29110@barra.bne.redhat.com>
 <4CDA6D25.4070501@euromail.se>
 <20101110235355.GB4473@barra.bne.redhat.com>
 <4CDB3D6C.2000507@euromail.se>
 <20101111012251.GC2121@core.coreip.homeip.net>
 <AANLkTinYE40qN7n98Vb-Pyh5npst6JN+1LzxZaU50X_H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36449 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757803Ab0KKI1C (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Nov 2010 03:27:02 -0500
Received: by yxk30 with SMTP id 30so227532yxk.19
        for <linux-input@vger.kernel.org>; Thu, 11 Nov 2010 00:27:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinYE40qN7n98Vb-Pyh5npst6JN+1LzxZaU50X_H@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michal Suchanek <hramrach@centrum.cz>
Cc: Henrik Rydberg <rydberg@euromail.se>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Chris Bagwell <chris@cnpbagwell.com>, linux-input <linux-input@vger.kernel.org>

On Thu, Nov 11, 2010 at 09:06:14AM +0100, Michal Suchanek wrote:
> On 11 November 2010 02:22, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On Thu, Nov 11, 2010 at 01:48:44AM +0100, Henrik Rydberg wrote:
> >> On 11/11/2010 12:53 AM, Peter Hutterer wrote:
> >>
> >> > On Wed, Nov 10, 2010 at 11:00:05AM +0100, Henrik Rydberg wrote:
> >> >> A comment on pixels and resolution:
> >> >>
> >> >> A pen and a thumb may have different resolution (signal-to-noise ratio), but
> >> >> there is no reason they cannot be reported on the same scale. In fact, it could
> >> >> be argued that it is natural for objects on the same surface to be reported in
> >> >> the coordinate system of the surface.
> >> >
> >> > it may be natural from a human perspective, but the computer doesn't care
> >> > about it.
> >>
> >>
> >> The fact that we discuss a computer protocol suggests the computer does care.
> >> ;-) The question is whether we need to be able to support different scales for
> >> different tools types. I argue that among the three things value range, physical
> >> range and SN ratio, the one most naturally seen as an attribute of a tool is the
> >> SN ratio.
> >>
> >> > And given that most input device interpretation is done in
> >> > software, the scale used doesn't matter as long as it's correct.
> >>
> >> > in the UI, even with different ranges for different tools, top-left should
> >> > refer to whatever coordinate that is.
> >> >
> >> > in other words, if the pure numbers matter in the UI, we've done something
> >> > wrong.
> >>
> >> >
> >> > what benefit do we get from reporting tools on the same scale if the HW
> >> > doesn't do so?
> >>
> >>
> >> The question is, given a set of tool types reported via MT events, what
> >> additional information is needed. Having tools share the same ABS axes, I would
> >> like to see that as a good thing. So what is missing from that picture?
> >
> > I think that with devices that share the same working surface with
> > different tools (touch/pen) it would make sense to normalize the data in
> > the kernel. If for no other reason but to simplify the protocol.
> >
> > In cases when tools are way to different driver writer might opt to
> > export the device as 2 separate logical input devices (and then take
> > care of coordinating them in userspace), in other cases treat them as
> > one input device and scale to the same range.
> >
> > I tend to think [at the moment] that the latter would be most sensible
> > option for Bamboo...
> >
> 
> What is the purpose of scaling the inouts to the same range?
> 
> Is that a workaround for na issue with current protocol design or does
> anybody think that it makes some sort of sense?
> 

I do not believe that current protocol design has an issue. MT protocol
is really for representing devices reporting multiple touches on the same
working surface which means that size stays the same for all touches.

> I am asking because to me it does not make any sense to scale the values.
> 
> Devices that have a touch layer superimposed over LCD screen have to
> be calibrated for the system to know which ABS_X/Y corresponds to
> which pixel. I suspect that Bamboo P&T may have similar issue with its
> two superimposed input devices. Alos somebody suggested that the input
> area usable for pen might be smaller than area usable for touch.
> 
> This means we are most likely talking apples and oranges, even if we
> scale them to be the same size.
> 

No, I do not believe this is true. Consider touchscreen that you can
touch with either stylus or finger, with stylus having better
resolution suited for drawing/writing and finger just used for selecting
UI objects. Obviously they work with the same number of pixels even
though ranges reported by the hardware might differ.

> So I think it is most sensible to leave the scales are reported by the
> hardware because that gives a hint to the application which receives
> the event that the inputs are in fact different. They will still be
> when the events are scaled, it will be just harder to see from the
> client point of view.

It really depends on the device in question and we have several options:

1. Single multitouch device - unified working surface with the same
   characteristics, kernel scales properly.

2. 2+ logical devices - may have different size/resolutions, userspace
   will have to do arbitration if they are in the same physical package.

With Bamboo I think option 1 makes more sense and is easier on everyone.

-- 
Dmitry
