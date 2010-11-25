From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Wed, 24 Nov 2010 17:31:02 -0800
Message-ID: <20101125013102.GA3081@core.coreip.homeip.net>
References: <AANLkTinw2pyZOPuVsG6ovBTFKstozamfWX=6EcjyYTfX@mail.gmail.com>
 <20101123223018.GC20283@core.coreip.homeip.net>
 <AANLkTi=sEJC9r=ZL7rJH9ojOjadmriNFbN97t+=HpTwy@mail.gmail.com>
 <20101124025248.GD27368@core.coreip.homeip.net>
 <AANLkTi=FLyZ5eWb0M4fNg76YuzU_Cpasb3b0xjeNhLE5@mail.gmail.com>
 <20101124202603.GH27368@core.coreip.homeip.net>
 <AANLkTimZ7hDEEO7xbRT3Xt7fRHwBHgx=NT70q=C60tDS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34514 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab0KYBbL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 20:31:11 -0500
Received: by ywl5 with SMTP id 5so214487ywl.19
        for <linux-input@vger.kernel.org>; Wed, 24 Nov 2010 17:31:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimZ7hDEEO7xbRT3Xt7fRHwBHgx=NT70q=C60tDS@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Wed, Nov 24, 2010 at 04:55:32PM -0600, Chris Bagwell wrote:
> On Wed, Nov 24, 2010 at 2:26 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Tue, Nov 23, 2010 at 10:55:56PM -0600, Chris Bagwell wrote:
> >> On Tue, Nov 23, 2010 at 8:52 PM, Dmitry Torokhov
> >> <dmitry.torokhov@gmail.com> wrote:
> >> > On Tue, Nov 23, 2010 at 02:40:00PM -0800, Ping Cheng wrote:
> >> >> On Tue, Nov 23, 2010 at 2:30 PM, Dmitry Torokhov
> >> >> <dmitry.torokhov@gmail.com> wrote:
> >> >> > On Tue, Nov 23, 2010 at 12:48:07PM -0800, Ping Cheng wrote:
> >> >> > How is BTN_TOOL_TOUCH is different from BTN_TOOL_FINGER?
> >> >>
> >> >> Good question.
> >> >>
> >> >> BTN_TOOL_FINGER is used for touchpad or trackpad, or whichever =
term
> >> >> that works for you. It indicates a relative cursor movement. Th=
e touch
> >> >> screen needs to translate the (x,y) events into absolute moveme=
nt.
> >> >> That's why none of those touchscreen drivers use BTN_TOOL_FINGE=
R so
> >> >> far.
> >> >>
> >> >
> >> > BTN_TOOL_FINGER and the new BTN_TOOL_TOUCH convey the same data =
to the
> >> > userspace, namely that there is a finger on the owrking surface,=
 as
> >> > oopsed to pen, mouse, lens or something else. It does not dictat=
e how
> >> > exactly the data should be used, although right now we have heur=
istic to
> >> > decide the class of the device we are dealing with.
> >>
> >> I've a small clarification for readers that might not be aware. =A0=
=46or
> >> BTN_TOOL_FINGER, its still used to mean a kinda of "in proximity o=
f
> >> surface" and BTN_TOUCH is used when actually touching touchpad. =A0=
=46or
> >
> > BTN_TOUCH means something (we do not specify what) touches working
> > surface.
> >
> >> touchpad, those two things probably should follow each other... bu=
t as
> >> an example the synaptics driver only sets BTN_TOOL_FINGER immediat=
ely
> >> but BTN_TOUCH when pressure is over some threshold. =A0So there is=
 a
> >> time period when they do not match.
> >
> > In Synaptics BTN_TOUCH was used for legacy clients not understandin=
g
> > BTN_TOOL_FINGER/ABS_PRESSURE (read: mousedev) and had arbitrary pre=
ssure
> > thresholds.
>=20
> Does this mean BTN_TOUCH is optional for absolute devices (tablets an=
d
> touchpads)?  Its not for touchscreens simply because its defacto even=
t
> used were other devices use BTN_TOOL_*.

BTN_TOUCH is not optional in the sense that legacy (or simplest) client=
s
use it to recoginze the touch. For example mousedev does this, so if yo=
u
were to remove BTN_TOUCH from touchpad drivers mousedev (and thus GPM)
would stop working.

>=20
> Probably we should document this stuff, similar to how MT did, for
> common understanding.  I may be up for that task soon.

That would be great.


>=20
> >
> >>
> >> Touchscreens today can only send BTN_TOUCH event... which is a lit=
tle
> >> odd but works.
> >>
> >> >
> >> > It looks like that we getting into fuzzy area where it is hard t=
o
> >> > classify the device solely by its capabilities. Maybe it is time=
 we
> >> > revisited the topic of adding "flags" or "hint" to the device to
> >> > describe it's main purpose(s).
> >> >
> >>
> >> I think the proposed BTN_TOOL_TOUCH is in the same spirit of most
> >> other BTN_TOOL_*'s.
> >>
> >> We seem comfortable that userland wants to know difference between=
 pen
> >> and eraser tools. =A0The only thing unique they bring to table is =
a type
> >> of resolution (fine tip vs. blunt tip) as well as an indication of
> >> tool switching.
> >
> > And the expected action when you actually using the tool.
>=20
> Agree.  Its important point that happens to be in line with why I lik=
e
> BTN_TOOL_TOUCH concept.  More below.
>=20
> >
> >>
> >> I'm not sure we needed 8 tools to express resolution concepts or t=
ool
> >> switching concepts but we do have them.
> >>
> >> To me, the BTN_TOOL_TOUCH fits in just fine with this. =A0It says =
its
> >> low resolution like both BTN_TOOL_ERASER and BTN_TOOL_FINGER say t=
o
> >> different degrees. =A0But it also says that, unlike BTN_TOOL_FINGE=
R, it
> >> has touchscreen visibility going for it to replace missing
> >> in-proximity concept and effectively increase its resolution... an=
d so
> >> you do not need to revert to relative emulation.
> >
> > Huh? I want to reiterate that I do not see any difference between
> > proposed BTN_TOOL_TOUCH and existing BTN_TOOL_FINGER - both indicat=
e
> > that a finger either touches or is in proximity of the working surf=
ace.
> >
> > The only difference between tablet, touchcsreen and touchpad is how=
 we
> > react to the same data (i.e. relative/absolute movement; pointer
> > tracking or not, etc).
> >
>=20
> Let me give an example of drawing program and worst case where all
> major device classes are merged in single input device.  The input ha=
s
> pen/eraser/touchscreen/touchpad/mouse and user expected behavior.

This is a faulty assumption as I do not see how you could come across
such a beast. Touchscreens, tablets and touchpads are different devices
and require different handling:

- touchpads require conversion from absolute to relative movement, and
  movement causes on-screen pointer movement;

- tablets (unless we are talking about wacom mouse tool which is
  special) operate in absolute coordinates but still require on-screen
  pointer movement;

- touchscreens work in absolute coordinates and do not require pointer
  tracking as your tool (finger, stylus) serves as a pointer.

While I can see manufacturers packaging let's say touchscreen and a
touchpad into a single chip solution we should not try to jam them all
together into single logical input device but rather split them
accordingly (based on work surface for example).

Given that you won't ever have to deal with something that is
touchscreen, tabled and touchpad at once the rest of your example is no=
t
interesting.

> All tools except mouse share ABS_X/Y/PRESSURE and BTN_TOUCH.   Mouse
> uses REL_* events.
>=20
> * BTN_TOOL_PEN - Small point pen with black ink.  Draws upon BTN_TOUC=
H
> or ABS_PRESSURE.
> * BTN_TOOL_ERASER - Large point pen with white ink (simple erase
> concept).  Draws upon BTN_TOUCH or ABS_PRESSURE.
> * BTN_TOOL_TOUCH - Large point pen with black ink.  Draws upon
> BTN_TOUCH or ABS_PRESSURE.
> * BTN_TOOL_FINGER - Small (maybe) point pen with black ink.  Only
> moves cursor with BTN_TOUCH or ABS_PRESSURE.  No drawing unless
> BTN_RIGHT clicked.
> * BTN_TOOL_MOUSE - Small (maybe) point pen with black ink.  Only move=
s
> cursor on REL_ events.  No drawing unless BTN_RIGHT clicked.  <-- thi=
s
> is existing wacom example.  If reports ABS_* then it would probably
> use BTN_TOOL_FINGER tool even though a mouse puck.
>=20
> Notice how expected behavior of touchscreen is so close to tablet
> tools.  TOUCH is just a complement tablet tool in same way ERASER is
> complement to PEN.  Touchpads are so unique in how they behave that I
> think they deserve their own tool type.

No, they deserve to be handled differently (as I outlined above) but th=
e
tool is still the same. It is your finger. If it was a different tool
that would mean that there could be a device that supports both
BTN_TOOL_FINGER and BTN_TOOL_TOUCH. Now how would you differentiate
between them? When use one and when the other (given that it is
physically the same object touching the device)?

>=20
> Your point about only the "how to react" being different between
> touchpad and touchscreen is also true for all tools above.  I'm not
> sure why your limiting comment and not including tablet and mice
> tools.  We could switch to BTN_TOOL_1/2/3/4 and some sort of per tool
> hint (BTN_TOOL_CAPABILITIES sent with tool events perhaps?) but I'm
> not real excited about work involved in userland for that.
>=20
> If your still not convinced on BTN_TOOL_TOUCH (I've not really
> mentioned much new info) then can you give rough ideas of what flags
> interface should look like?
>=20
> For example, should it be sent as BTN_TOOL_CAPABILITIES event for eac=
h
> tool change?  Or should it be an ioctl() per BTN_TOOL_*?  The former
> is good if we think BTN_TOOL_*'s will use tool ID's and two tools may
> have different capabilities.

No, the hint or flags or type is per device. So you'd do:

	ioctl(fd, EVIOCGDEVTYPE, &type);

when you notified about a new device and it would return a bitmap of al=
l
that it could be, like INPUT_TYPE_TOUCHSCREEN or INPUT_TYPE_TABLET. And
then you'd know how to deal with that device.

>=20
> Once solved for ST, it also needs solution for MT.  For slot based MT=
,
> it may need to be sent as events if we allow tools to float between
> slots.
>=20

I do not see how that involves ST vs MT at all.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
