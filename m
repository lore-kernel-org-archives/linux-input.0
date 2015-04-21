From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: Unusual Focaltech driver behavior
Date: Tue, 21 Apr 2015 15:35:20 +1000
Message-ID: <20150421053520.GA19079@jelly.redhat.com>
References: <5530C7D2.8090106@gmail.com>
 <5530D8DE.7070604@gmail.com>
 <CAN+gG=G-uTfBNOjcQuFrRKcywwsb1HLtXg=TFnv0gPXaTuPc2A@mail.gmail.com>
 <55310D09.8010001@gmail.com>
 <CAN+gG=HGgdoBy1ugoawU2t6rkW1jq=HsBsWiq9T34d=fYvwaEg@mail.gmail.com>
 <55311D85.2030706@gmail.com>
 <55311F32.90300@gmail.com>
 <CAN+gG=FMxvSBXXm8KUXp9G2kqhUSAvkAe_Va+7AFy_H=xw1Log@mail.gmail.com>
 <55312CA5.6090509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:25109 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbbDUFf2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Apr 2015 01:35:28 -0400
Content-Disposition: inline
In-Reply-To: <55312CA5.6090509@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Mathias Gottschlag <mgottschlag@gmail.com>

On Fri, Apr 17, 2015 at 06:54:13PM +0300, Dmitry Tunin wrote:
>=20
>=20
> 17.04.2015 18:43, Benjamin Tissoires =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, Apr 17, 2015 at 10:56 AM, Dmitry Tunin <hanipouspilot@gmail=
=2Ecom> wrote:
> >>
> >>
> >> 17.04.2015 17:49, Dmitry Tunin =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> 17.04.2015 16:57, Benjamin Tissoires =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:
> >>>> On Fri, Apr 17, 2015 at 9:39 AM, Dmitry Tunin <hanipouspilot@gma=
il.com> wrote:
> >>>>>> Hi Dmitry,
> >>>>>>
> >>>>>> On Fri, Apr 17, 2015 at 5:56 AM, Dmitry Tunin <hanipouspilot@g=
mail.com> wrote:
> >>>>>>>> I noticed that myself and got some complaints like this.
> >>>>>>>> https://github.com/hanipouspilot/ubuntu-fixes/issues/2
> >>>>>>>>
> >>>>>>>> General issue is that when one finger is on the touchpad, mo=
vement of a second finger is ignored, if the first finger does not move=
=2E
> >>>>>>>> Usually with other touchpads, when you have one finger on th=
e touchpad and move the other, it is recognized as two-finger scrolling=
=2E
> >>>>>>>> The device itself sends relative packages as normal in that =
case, but linux driver ignores them, until first finger is moved.
> >>>>>>>>
> >>>>>>>> I guess, Windows driver behaves same way. I can't test it, s=
ince I do not have Windows installed on that laptop.
> >>>>>>>>
> >>>>>>>> As I understood, Windows driver ignores that one finger is o=
n button area and recognizes movement of the other as one-finger moveme=
nt.
> >>>>>>>>
> >>>>>>>> It is clear that we do not know the full protocol or paramet=
ers of all touchpad models to have that button area always correct.
> >>>>>>>> But it looks like button area is set when 3rd byte in abs pa=
ckage is 00. There is a good chance that it is common for all touchpad =
models.
> >>>>>>>>
> >>>>>>>> Do you have ideas how to fix it the easiest way?
> >>>>>>>>
> >>>>>>>> Regards,
> >>>>>>>>
> >>>>>>>> Dmitry
> >>>>>>>>
> >>>>>>>
> >>>>>>> I looked at it some more and noticed that if I put one finger=
 on touchpad, then another, then move the second one, rel packets are i=
gnored.
> >>>>>>> But if keeping both fingers on touchpad, I move the first one=
, rel packets work OK.
> >>>>>>> This is wrong. I can't get what's wrong with the code at the =
moment.
> >>>>>>
> >>>>>>
> >>>>>> It looks like your touchpad is in the mouse emulation mode, no=
t the
> >>>>>> raw touch mode. What you get is fed by the touchpad FW ans the=
re is
> >>>>>> nothing we can do in userspace to fix that.
> >>>>>> That being said, there has been a lot of work with the focalte=
ch
> >>>>>> drivers in the previous kernel releases, and maybe trying a v4=
=2E0 will
> >>>>>> switch your touchpad in the raw mode.
> >>>>>> Once it is in raw mode, the software buttons, scrolling and ge=
stures
> >>>>>> are all treated in userspace and you will get the expected beh=
avior.
> >>>>>>
> >>>>>> Cheers,
> >>>>>> Benjamin
> >>>>>>
> >>>>>
> >>>>> No, the mouse is in proprietary mode. Multitouch is supported. =
In emulation mode it is not supported at all.
> >>>>> I am testing actually the driver from kernel 4.0. Everything wo=
rks great except this strange problem, when some relative packets are i=
gnored.
> >>>>> I mentioned above the test case. Now I added some debug and try=
ing to figure it out. But no success so far.
> >>>>>
> >>>>>
> >>>>
> >>>> If you are in absolute (raw) mode, then can you share the evemu-=
record
> >>>> of the gesture you are trying to support?
> >>>> We should be able to see what is going on and be able to pinpoin=
t if
> >>>> this is a kernel problem or a user space problem.
> >>>>
> >>>> Cheers,
> >>>> Benjamin
> >>>>
> >>>
> >>> Here is the record. I put one finger on the touchpad and moved th=
e other from top to bottom. This gesture is ignored.
> >>> But if I move first finger or both, it is recognized as scrolling
> >=20
> > OK, this evemu-record is clean in term of protocol handling.
> > It looks like the first finger is in the middle of the touchpad.
> > Besides that I do not see any problems (and this works fine on Fedo=
ra
> > with libinput).
> >=20
> > It must be a user-space problem. Can you tell us which distribution
> > you are using and which driver is handling the touchpad (xorg-evdev=
,
> > xorg-synaptics, xorg-libinput, wayland, mir)?
> >=20
> > Benjamin
>=20
> I am usung Ubuntu. I guess xorg-synaptics is handling the touchpad.

ok, in that case you'll need to file a bug, ideally in launchpad so we =
can
first rule out any ubuntu-specific patches. as Benjamin said, the recor=
ding
itself looks ok so this should work. You could try to give the
xf86-input-synaptics driver from git a try and see if it works.

either way, it doesn't look like a kernel problem at this point.

Cheers,
   Peter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
