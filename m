From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: How to indicate hover touch when exact distance unknown?
Date: Wed, 1 Oct 2014 09:22:52 -0700
Message-ID: <20141001162252.GA23115@dtor-glaptop>
References: <CAG_cf+dJfiqW_V1k4MfGMBNUK9Kgc4=9BPAuum7dbs6rkmAgrQ@mail.gmail.com>
 <20140923145916.GA3110@mail.corp.redhat.com>
 <20140923162811.GB40700@core.coreip.homeip.net>
 <20140924045213.GA4194@jelly.redhat.com>
 <54225667.30801@euromail.se>
 <CAN+gG=G4Kik_Gicdo6zqZbJMqp8-hYxw8yy0rEqN7-Dj5HfKeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:52205 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbaJAQWz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Oct 2014 12:22:55 -0400
Received: by mail-pd0-f178.google.com with SMTP id y10so472931pdj.37
        for <linux-input@vger.kernel.org>; Wed, 01 Oct 2014 09:22:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAN+gG=G4Kik_Gicdo6zqZbJMqp8-hYxw8yy0rEqN7-Dj5HfKeQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Peter Hutterer <peter.hutterer@who-t.net>, Andrew de los Reyes <andrew-vger@gizmolabs.org>, Hans de Goede <hdegoede@redhat.com>, jikos@jikos.cz, David Herrmann <dh.herrmann@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On Fri, Sep 26, 2014 at 09:50:32AM -0400, Benjamin Tissoires wrote:
> On Wed, Sep 24, 2014 at 1:28 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
> >>>> FWIW, hid-multitouch already support those devices.
> >>>> ABS_MT_DISTANCE is set with a min/max of 0/1 when we detect win8
> >>>> certified panels with hovering capability. By default the spec does not
> >>>> provide the distance IIRC, and you only have one byte: InRange.
> >>>
> >>> Hmm, I missed that and this is unfortunate. The ABS capabilities
> >>> advertised by the devices should match their real capabilities. If
> >>> device can't properly report distance it should not be using
> >>> ABS_MT_DISTANCE/ABS_DISTANCE...
> >>
> >> I think the hid-mt behaviour makes sense. Without explicit resolution (and
> >> no device sets that anyway, IIRC) any distance value > min tells us only that a
> >> tool is within detectable range, but not yet touching. Anything between
> >> min/max is only useful as a relative scale, but effectively that [min,max]
> >> range could be a metre or a millimeter, we can't know. So a device with a
> >> 0/1 range simply has low granularity and is only able to detect whether
> >> something is within range or touching the surface.
> >
> > I agree with this, but I also share Dmitry's concern.
> >
> > A device that can detect hovering, if only binary, does in fact coarsely
> > estimate the distance from the touching surface. A device allowing for a smooth
> > approach of objects would simply support a better resolution. From that
> > perspective, using the ABS_MT_DISTANCE capability makes sense. Pragmatically.
> 
> I agree.
> 
> >
> > However, at no point are we really changing the coordinate system, which remains
> > euclidian space. We are simply changing resolution and thresholds for what
> > constitues a touch. Forcing userland to step away from the simple interpretation
> > is what eventually makes the capability impossible to use as intended.
> 
> I think you are missing a point here. My maths are a little bit rusty,
> but if euclidian space there is, the space is *not* normalized. Peter
> remembered me the other day that the touchpad found on the Lenovo x220
> has a x resolution of 75 and a y resolution of 129. So every sane
> library/driver/tool has to take the individual resolution into account
> if they want to provide accurate results.
> Given that libinput, xorg-evdev and xorg-synaptics all take this into
> account, then it is safe to say that they can simply consider that a
> resolution of 0 is simply absolute and a binary explanation fits well
> (was it 1 mm, 1 cm, 1 inch or 1 meter).
> 
> >
> > So, if we cannot express, using the abs_info data, something like "contains a
> > detector which can coarsely estimate the distance and then uses a detector
> > threshold to set that distance to zero or one", we had better express it in some
> > other way, which is less ambiguous.
> 
> IMO, your sentence is already ambiguous enough :-)
> Seriously, I think that we should not worry too much about the binary
> ABS_MT_DISTANCE:
> Think about the wacom pens: they report hovering and distance, but I
> don't think any application uses the absolute distance to change the
> behavior. The user can not maintain a constant distance with the tip
> of the finger or the stylus from the surface, so most of the time the
> value is ignored while the hovering matters.
> A binary ABS_MT_DISTANCE is enough to send this info to the driver,
> and then, the driver can decide to transfer it or not to its clients.
> 
> >
> > How about ABS_MT_PRESENT and/or ABS_PRESENT? It would complement TOUCH in the
> > case of hovering, allow the state where the tool is there but not touching, and
> > would unambiguously advertise the capability of detecting presence. It would
> > also be forward compatible with additional capabilities, such as reporting the
> > actual distance to the surface.
> 
> I don't think adding such a new axis is a good idea. We do *not* have
> a per slot MT_TOUCH. We only have the tracking id which says that the
> slot is *valid*. Then, the spec already explains how can the device
> convey the hovering information:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/input/multi-touch-protocol.txt#n259
> 
> "ABS_MT_DISTANCE: The distance, in surface units, between the contact
> and the surface. Zero distance means the contact is touching the
> surface. A positive number means the contact is hovering above the
> surface."
> 
> The problem here is the "surface units", but given that the units on
> each axes depends on the per axis resolution, a resolution of 0 says
> that the units are undefined, and that the client should use only the
> last part of the definition: zero = touch, >0 = hovering.

OK, so should we then say that we will continue reporting binary hovering
with ABS_MT_DISTANCE 0/1 and such devices must report resolution of 0;
devices reporting wider ABS_MT_DISTANCE ranges should also report
appropriate resolution, same as X/Y coordinates?

Thanks.

-- 
Dmitry
