From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Tue, 9 Nov 2010 13:31:49 +1000
Message-ID: <20101109033149.GC19313@barra.redhat.com>
References: <AANLkTin1svszp87Pysi5OCt5=JTSB-yVaAWF-42gfn9T@mail.gmail.com>
 <20101108035121.GA4630@barra.bne.redhat.com>
 <4CD7B012.1030809@cena.fr>
 <AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:65034 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982Ab0KIDcH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 22:32:07 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTike6Ny26fV3691-3vgM7kTi5RRRWjDB4_BukPqd@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Benjamin Tissoires <tissoire@cena.fr>, Ping Cheng <pinglinux@gmail.com>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Stone <daniel@fooishbar.org>, linux-input <linux-input@vger.kernel.org>

On Mon, Nov 08, 2010 at 03:54:51PM -0600, Chris Bagwell wrote:
> On Mon, Nov 8, 2010 at 2:08 AM, Benjamin Tissoires <tissoire@cena.fr>=
 wrote:
> > Le 08/11/2010 04:51, Peter Hutterer a =E9crit :
> >>
> >> fwiw, I'm not sure "arbitrate" is the right word here, filtering s=
eems
> >> easier to understand in this context. I guess "arbitrate" would ap=
ply more
> >> if we emit the events across multiple devices like in the bamboo c=
ase.
> >> that's mostly bikeshedding though, my points below apply regardles=
s of
> >> what
> >> word we choose :)
> >>
> >> note that we also have two different approaches - single kernel de=
vice or
> >> multiple kernel devices and depending on the approach the device u=
ses the
> >> options below have different advantages and disadvantages.
> >>
> >> the tablets I've dealt with so far exposed a single event device, =
so
> >> that's
> >> what I'm focusing on in this email.
> >>
> >> On Fri, Nov 05, 2010 at 11:47:28AM -0700, Ping Cheng wrote:
> >>>
> >>> Recent changes and discussion about MT support at LKML, UDS, and
> >>> xorg-devel encouraged me to migrate Wacom MT devices to the slot-=
based
> >>> MT protocol (introduced in kernel 2.6.36). Since Wacom supports b=
oth
> >>> digitizer and touch devices, I need to decide how to report touch=
 data
> >>> when the pen is in proximity.
> >>>
> >>> My goal is to understand how X server would like the MT data to b=
e
> >>> reported from the kernel. I hope to keep kernel and X server driv=
er MT
> >>> support in sync so we can avoid unnecessary confusion or extra wo=
rk in
> >>> the userland.
> >>>
> >>> The existing solution for single touch events is to arbitrate tou=
ch
> >>> when pen is in prox. This is based on the assumption that we do n=
ot
> >>> want to have two cursors competing on the screen.
> >>>
> >>> With the introduction of MT, the touch data are most likely trans=
lated
> >>> into something other than pointer events. So, reporting both pen =
and
> >>> touch data makes sense now. However, I want to assure a smooth
> >>> tansition from single touch to MT for end users so they still get=
 the
> >>> single touch behavior as they used to be. I gathered the followin=
g
> >>> approaches:
> >>>
> >>> 1. =A0 =A0 Arbitrate all touch data in the kernel.
> >>>
> >>> This is the simplest solution for device driver developers. But I=
 do
> >>> not feel it is end user and userland client friendly.
> >>
> >> I'm strongly opposed to this. kernel filtering of these devices is=
 hard to
> >> circumvent and there _will_ be use-cases where we need more than o=
ne tool
> >> to
> >> work simultaneously. right now we're worrying about pen + touch, b=
ut what
> >> stops tablets from becoming large enough to be used by 2+ users wi=
th 2+
> >> pens simultaneously?
> >>
> >> from a purely event-stream focused viewpoint: why do we even care =
whether
> >> something is a pen or a touch? both are just tools and how these s=
hould be
> >> used is mostly up to the clients anyway. =A0IMO, the whole point o=
f
> >> MT_TOOL_TYPE is that we don't have to assume use-cases for the too=
ls but
> >> just forward the information to someone who knows how to deal with=
 this.
> >>
> >>> 2. =A0 =A0 Report first finger touch as ABS_X/Y events when pen i=
s not in
> >>> prox. =A0Arbitrating single touch data when pen is in prox. Pen d=
ata is
> >>> reported as ABS_X/Y events. Both ABS_X/Y for pen or the first fin=
ger
> >>> and ABS_MT_* for MT data are reported.
> >>>
> >>> This approach reduces the overhead in dealing with two cursors in
> >>> userland.
> >>>
> >>> 3. =A0 =A0Report first finger touch as ABS_X/Y events when pen is=
 not in
> >>> prox;
> >>> =A0 =A0 =A0 =A0Report pen data as ABS_X/Y events when there is no=
 finger touch;
> >>> =A0 =A0 =A0 =A0Report touch data as MT_TOOL_TOUCH and pen data as=
 MT_TOOL_PEN
> >>> events when both pen and touch data are received. No ABS_X/Y are
> >>> reported when pen and tocuh or multi-touch data are received.
> >>>
> >>> I feel this one makes sense to userland since pen can be consider=
ed as
> >>> another touch.
> >>>
> >>> 4. =A0 =A0Report first finger touch as ABS_X/Y events when pen is=
 not in
> >>> prox;
> >>> =A0 =A0 =A0 =A0Report pen data as ABS_X/Y events when there is no=
 finger touch;
> >>> =A0 =A0 =A0 =A0Report touch data as MT_TOOL_TOUCH and pen data as=
 MT_TOOL_PEN
> >>> events when both pen and touch data are received. ABS_X/Y are als=
o
> >>> reported for pen when both pen and tocuh data are received.
> >>
> >> I'd vote for this one. It provides all the data necessary for MT c=
lients
> >> (and all the data the device can support) but has a reasonable
> >> single-touch
> >> strategy. Given that wacom tablets are still primarily pen-centric
> >> tablets,
> >> the emphasis on pen overriding touch makes sense to me.
> >
> > Hi,
> >
> > I'd also vote for this.
> >
> > I don't think that the kernel should make any assumption on the fin=
al
> > application. The data are available, so we have to pass them.
> >
> > 1. I read that people worry about sending "false" events (touch) wh=
ile using
> > the pen. But in my mind, this is a _design_ problem of the final
> > application. I think the final application will have to filter thes=
e events:
> > for instance, what happens if the user is too lazy to remove his pe=
n (or
> > just want to keep the hover on the application) out of the proximit=
y range
> > and want to move its digital sheet of paper in his (her) design app=
lication?
> > The final application will have to choose whether using or not the =
touch
> > features (depending on the pressure for instance...).
> >
> > The solution 4. (*technical solution*) addresses the problem of the=
 "false"
> > events for the applications (*design problem*) that are not designe=
d to used
> > multitouch. They will just ignore the touch data.
> > So I think, it's a good start
> >
> >
> > 2. I would also add that multitouch is not only available for track=
pads:
> > there are also direct devices in absolute coordinate mode. With tho=
se
> > device, the touch data can be directed to an other Xclient that is =
used by
> > an other user if the surface is large enough. Currently we only see
> > relatively small surfaces (bamboo, ntrig devices), but in the futur=
e, we can
> > easily imagine a whole table with both pen and touch.
> >
> > And this solve Michal's problem as he will be able to use buttons i=
n the
> > application with the finger.
> >
> > Cheers,
> > Benjamin
> >
> >>
> >>> This one makes sense to userland too. It eases the backward
> >>> compatibility support for those clients that don't support MT at =
all.
> >>>
> >>> Which approach do you like? Or do you have other suggestions shar=
e?
> >>
>=20
> I think we may be mixing some topics and so I'd like to try to
> re-frame the discussion.
>=20
> There are two different cases and they may have different answers
> because of it.
>=20
> Case 1) 1 input device can support multiple tools that are in
> proximity at same time.
>=20
> I believe this is currently a theoretical example (no driver exists l=
ike this).

if you consider touch to be just another tool, we already have devices =
that
support proximity of multiple tools. This isn't theoretical anymore.

> In RFC example, this input devices has a pen and 2 finger touches.
> They all share ABS_X/Y/PRESSURE values.  The single touch (ST) input
> filtering breaks being able to support this case and what multitouch
> events (MT) were added for.
>=20
> To date, when converting drivers over to MT events the guideline is
> *always* send MT events (because what app wants to randomly switch
> between MT event processing and ST event processing for same
> X/Y/PRESSURE?) and send something sane for ST events to be backwards
> compatible with older apps.
>=20
> I think everyone is happy in this thread to always send pen+touch MT
> events and let X drivers or similar filter/arbitrate out unwanted
> touch events as needed.
>=20
> The ideal "sane" behavior for touch ST events has been leaning toward=
s
> tracking 1st touch and continue sending 1st touch during multi-touch
> but there is some debate because tracking can be expensive in kernel.
> In case of pen+touch, the sane may change to prefer pen over touch an=
d
> prefer first touch when 2 touches exist.
>=20
> Or "sane" can mean let the ST values go crazy during multi-touch and
> hope user can use GUI enough after new kernel install to get a
> MT-aware X driver.
>=20
> Its easy to implement preferring pen then preferring 1st touch so I
> suggest doing that.  This is for backwards compatibility only
> (un-modified xf86-input-wacom/synaptics/evdev/etc).  The future is MT
> events, in which case the ST events are meaningless and we are hiding
> nothing to applications that look at MT events.
>=20
> Case 2) 2 input devices can support multiple tools in proximity at sa=
me time.
>=20
> I believe it was Rafi that brought up point that dual pen+touch
> interfaces will have different properties.  Touch will be lower
> resolution then Pen and maybe different fuzz factor.  Also, on tablet=
s
> I would think pretty easy to have different dimensions (one tool work=
s
> over larger area of tablet).  This is easy to expose to user when 2
> input devices.

Yes and no. We're talking about kernel level here and I don't think thi=
s
should be done at this level. The current behaviour of the X driver is =
to
split multiple tools up into multiple X devices, so the points above ca=
n
easily be achieved in userspace.


> Combining into single input to user would be nice but at least when
> dimensions are different, we probably do not want to remove that
> visibility to user and so must keep 2 input devices.
=20
If we run into issues with different axis ranges/resolutions for multip=
le
MT_SLOT devices, this should be addressed in the kernel as well.
I feel uncomfortable about splitting up a physical device into multiple
devices, it takes information away that cannot easily be re-created in =
the
userspace. Even with a method of associating multiple event devices to =
the
same physical device, the parsing of simultaneous events is harder beca=
use
you're essentially deserialising event streams. In userspace, you have =
to
re-serialize based on parallel inputs.

That said, it also goes counter the whole multi-touch approach - allowi=
ng
more than one device on a single physical device.

Cheers,
  Peter

> In this case, the RFC example becomes 2 touches on 1 input device and
> 1 pen on another input device.
>=20
> So using same MT guidelines, the touch input device would always send
> MT events and always send ST events tracking the first touch.
>=20
> For pen input, ST-only events are OK because its not competing with
> anything being in proximity at same time.  But we may wish to also
> send MT events for this 1 tool/slot as a hint to X drivers that
> somehow this input corresponds with another input device and so it
> needs to do filtering/arbitration.  We also need to somehow give info
> to applications so they can bind these 2 inputs.
>=20
> Also, non-MT ware drivers are also same apps that will not know how t=
o
> bind 2 input devices and so can't filter/arbitrate the unwanted
> touches.  So problem, we do want to filter ST events on touch input
> when pen is in proximity.
>=20
> There are lots of things needing to be addressed for this 2nd case so
> I'll not really give a personal opinion.  My opinion is likely to
> change as we make individual decisions.
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
