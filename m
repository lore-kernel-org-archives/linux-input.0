From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Sat, 27 Nov 2010 00:06:28 -0800
Message-ID: <20101127080628.GC28667@core.coreip.homeip.net>
References: <AANLkTinw2pyZOPuVsG6ovBTFKstozamfWX=6EcjyYTfX@mail.gmail.com>
 <20101123223018.GC20283@core.coreip.homeip.net>
 <AANLkTi=sEJC9r=ZL7rJH9ojOjadmriNFbN97t+=HpTwy@mail.gmail.com>
 <20101124025248.GD27368@core.coreip.homeip.net>
 <AANLkTi=FLyZ5eWb0M4fNg76YuzU_Cpasb3b0xjeNhLE5@mail.gmail.com>
 <20101124202603.GH27368@core.coreip.homeip.net>
 <AANLkTimZ7hDEEO7xbRT3Xt7fRHwBHgx=NT70q=C60tDS@mail.gmail.com>
 <20101125013102.GA3081@core.coreip.homeip.net>
 <AANLkTimS96HiQaO9WApVRc2ANumY+9io2gacsbSk07Gb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:33537 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab0K0IGf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Nov 2010 03:06:35 -0500
Received: by pxi15 with SMTP id 15so439449pxi.19
        for <linux-input@vger.kernel.org>; Sat, 27 Nov 2010 00:06:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimS96HiQaO9WApVRc2ANumY+9io2gacsbSk07Gb@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Fri, Nov 26, 2010 at 04:48:32PM -0600, Chris Bagwell wrote:
> On Wed, Nov 24, 2010 at 7:31 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Nov 24, 2010 at 04:55:32PM -0600, Chris Bagwell wrote:
> >> >
> >> >>
> >> >> Touchscreens today can only send BTN_TOUCH event... which is a =
little
> >> >> odd but works.
> >> >>
> >> >> >
> >> >> > It looks like that we getting into fuzzy area where it is har=
d to
> >> >> > classify the device solely by its capabilities. Maybe it is t=
ime we
> >> >> > revisited the topic of adding "flags" or "hint" to the device=
 to
> >> >> > describe it's main purpose(s).
> >> >> >
> >> >>
> >> >> I think the proposed BTN_TOOL_TOUCH is in the same spirit of mo=
st
> >> >> other BTN_TOOL_*'s.
> >> >>
> >> >> We seem comfortable that userland wants to know difference betw=
een pen
> >> >> and eraser tools. =A0The only thing unique they bring to table =
is a type
> >> >> of resolution (fine tip vs. blunt tip) as well as an indication=
 of
> >> >> tool switching.
> >> >
> >> > And the expected action when you actually using the tool.
> >>
> >> Agree. =A0Its important point that happens to be in line with why =
I like
> >> BTN_TOOL_TOUCH concept. =A0More below.
> >>
> >> >
> >> >>
> >> >> I'm not sure we needed 8 tools to express resolution concepts o=
r tool
> >> >> switching concepts but we do have them.
> >> >>
> >> >> To me, the BTN_TOOL_TOUCH fits in just fine with this. =A0It sa=
ys its
> >> >> low resolution like both BTN_TOOL_ERASER and BTN_TOOL_FINGER sa=
y to
> >> >> different degrees. =A0But it also says that, unlike BTN_TOOL_FI=
NGER, it
> >> >> has touchscreen visibility going for it to replace missing
> >> >> in-proximity concept and effectively increase its resolution...=
 and so
> >> >> you do not need to revert to relative emulation.
> >> >
> >> > Huh? I want to reiterate that I do not see any difference betwee=
n
> >> > proposed BTN_TOOL_TOUCH and existing BTN_TOOL_FINGER - both indi=
cate
> >> > that a finger either touches or is in proximity of the working s=
urface.
> >> >
> >> > The only difference between tablet, touchcsreen and touchpad is =
how we
> >> > react to the same data (i.e. relative/absolute movement; pointer
> >> > tracking or not, etc).
> >> >
> >>
> >> Let me give an example of drawing program and worst case where all
> >> major device classes are merged in single input device. =A0The inp=
ut has
> >> pen/eraser/touchscreen/touchpad/mouse and user expected behavior.
> >
> > This is a faulty assumption as I do not see how you could come acro=
ss
> > such a beast. Touchscreens, tablets and touchpads are different dev=
ices
> > and require different handling:
> >
> > - touchpads require conversion from absolute to relative movement, =
and
> > =A0movement causes on-screen pointer movement;
> >
> > - tablets (unless we are talking about wacom mouse tool which is
> > =A0special) operate in absolute coordinates but still require on-sc=
reen
> > =A0pointer movement;
> >
> > - touchscreens work in absolute coordinates and do not require poin=
ter
> > =A0tracking as your tool (finger, stylus) serves as a pointer.
> >
> > While I can see manufacturers packaging let's say touchscreen and a
> > touchpad into a single chip solution we should not try to jam them =
all
> > together into single logical input device but rather split them
> > accordingly (based on work surface for example).
> >
> > Given that you won't ever have to deal with something that is
> > touchscreen, tabled and touchpad at once the rest of your example i=
s not
> > interesting.
>=20
> Hmmm.  Let me start of easy part.  Having touchpad+touchscreen on
> single input doesn't make sense even though it was in my example.  I
> agree with that.  The rest are valid examples that exist today.
>=20
> touchscreen/wacom_w8001.c is example of serial device (1 input device
> to user) that has tablet features (BTN_TOOL_PEN and BTN_TOOL_FINGER)
> and touchscreen touch.  Today its playing some games and not sending
> BTN_TOOL_FINGER events to prevent device from being directed to
> xf86-input-synaptics.  This can be fixed after thread is finalized.

*nod*

>=20
> We have Wacom Bamboo's (tablet/wacom_wac.c) that have tablet features
> (BTN_TOOL_PEN and BTN_TOOL_ERASER) on 1 input device and touchpad
> feature (BTN_TOOL_FINGER) on another input device.  On another thread=
,
> we talked about merging these into 1 logical input device because it
> eases filtering those BTN_TOOL_FINGER events while user is using
> stylus and resting hand on tablet.

Is the Bamboo intended to be used as a big touchpad? Or is it still the
tablet that is touch-sensitive? I'd say the 2nd so we should not say
that it has "touchpad feature on the 2nd device". While userspace (and
parts of kernel space) use BTN_TOOL_FINGER to decide that the device
should be treated as touchpad is is simply heuristic.

> Also, Wacom Tablet PC's (tablet/wacom_wac.c) and hid-ntrig.c have
> tablet (BTN_TOOL_PEN and BTN_TOOL_ERASER) and touchscreen (BTN_TOUCH)=
=2E
>   These could be combined and the Wacom Tablet PC's events should be
> modified to look closer to hid-ntrig.c... although hid-ntrig.c also
> isn't sending BTN_TOOL_FINGER for xf86-input-synaptics reasons.

I see...

> .
> >
> >> All tools except mouse share ABS_X/Y/PRESSURE and BTN_TOUCH. =A0 M=
ouse
> >> uses REL_* events.
> >>
> >> * BTN_TOOL_PEN - Small point pen with black ink. =A0Draws upon BTN=
_TOUCH
> >> or ABS_PRESSURE.
> >> * BTN_TOOL_ERASER - Large point pen with white ink (simple erase
> >> concept). =A0Draws upon BTN_TOUCH or ABS_PRESSURE.
> >> * BTN_TOOL_TOUCH - Large point pen with black ink. =A0Draws upon
> >> BTN_TOUCH or ABS_PRESSURE.
> >> * BTN_TOOL_FINGER - Small (maybe) point pen with black ink. =A0Onl=
y
> >> moves cursor with BTN_TOUCH or ABS_PRESSURE. =A0No drawing unless
> >> BTN_RIGHT clicked.
> >> * BTN_TOOL_MOUSE - Small (maybe) point pen with black ink. =A0Only=
 moves
> >> cursor on REL_ events. =A0No drawing unless BTN_RIGHT clicked. =A0=
<-- this
> >> is existing wacom example. =A0If reports ABS_* then it would proba=
bly
> >> use BTN_TOOL_FINGER tool even though a mouse puck.
> >>
> >> Notice how expected behavior of touchscreen is so close to tablet
> >> tools. =A0TOUCH is just a complement tablet tool in same way ERASE=
R is
> >> complement to PEN. =A0Touchpads are so unique in how they behave t=
hat I
> >> think they deserve their own tool type.
> >
> > No, they deserve to be handled differently (as I outlined above) bu=
t the
> > tool is still the same. It is your finger. If it was a different to=
ol
> > that would mean that there could be a device that supports both
> > BTN_TOOL_FINGER and BTN_TOOL_TOUCH. Now how would you differentiate
> > between them? When use one and when the other (given that it is
> > physically the same object touching the device)?
> >
>=20
> I now see I had flawed outlook because I was stuck on udev and
> xf86-input-evdev logic to much.  I wanted to send something along wit=
h
> each tool that said how to treat in terms of historical device
> classes.  As example, I wanted to say "Use BTN_TOOL_PEN with logic yo=
u
> used to use for Tablets." and "Use BTN_TOOL_FINGER with logic you use=
d
> to use for touchscreens".  BTN_TOOL_TOUCH was just way of encoding
> that extra info without new interface.
>=20
> Thats why I mentioned per-tool a few times.  Your examples show its
> better to say "use this BTN_TOOL_* in whatever way makes sense with
> Touchscreen (or whatever physical attribute of HW is)."
>=20
> Both viewpoints come to same answer in the end but yours is best.  It=
s
> basically 1 value per input device; as you show below.
>=20
> It doesn't quite work if we have combined touchscreen+touchpad but I
> agree that case is probably best to break into 2 input devices.

I am glad I'm winning you over ;)

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
