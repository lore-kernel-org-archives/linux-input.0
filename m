From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: Simple approach to write PS3/PS4 usermode driver?
Date: Sat, 27 Feb 2016 22:59:09 +0100
Message-ID: <20160227225909.073f78a9@neptune.home>
References: <56C2270E.9080603@m-reimer.de>
	<20160215223436.fc5a3f66f82ee49b161099ea@ao2.it>
	<56C37C5A.6030303@m-reimer.de>
	<CAM4jgCrRCUQYZBnhKGhc27UTkyzQS=rJOP4jrdT1UGtLDGqNzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:40715 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826AbcB0WG5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Feb 2016 17:06:57 -0500
In-Reply-To: <CAM4jgCrRCUQYZBnhKGhc27UTkyzQS=rJOP4jrdT1UGtLDGqNzQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <mail+linux-input@m-reimer.de>
Cc: =?UTF-8?B?Q2zDqW1lbnQ=?= VUCHENER <clement.vuchener@gmail.com>, linux-input@vger.kernel.org

On Tue, 16 February 2016 Cl=C3=A9ment VUCHENER wrote:
> 2016-02-16 20:45 GMT+01:00 Manuel Reimer:
> > On 02/15/2016 10:34 PM, Antonio Ospite wrote: =20
> >>
> >> Have you tried loading hid.ko with the ignore_special_drivers=3D1
> >> parameter? I guess that will ignore _all_ special drivers tho, eve=
n
> >> mouse and keyboard ones. =20
> >
> >
> > Exactly. And so it is not what I planned to do.
> > =20
> >> Alan Ott's hidapi[1] is a better alternative to libusb for hid
> >> devices. =20
> >
> >
> > Of course, but just for fun, I'll at least try to use libusb direct=
ly. There
> > are many examples on the net. I've already collected some code snip=
pets to
> > use.
> > =20
> >> I reckon a patched kernel is not an option, is it? =20
> >
> >
> > The kernel side driver does a great job. It has minor bugs (kernel =
panic
> > when disconnecting controller while in game), but nothing too bad.
> >
> > My plan is to remap to Xbox gamepad button mapping so games actuall=
y work
> > with the controller. In fact, I bought a brand new PS4 controller j=
ust for
> > my driver project. At least so far, I only own the PS3 console.

Have you tried event remapping as supported by evdev?

Have a look at EVIOCGKEYCODE and EVIOCSKEYCODE ioctls for event devices=
=2E

Those might be sufficient to perform your remapping (as long as games d=
on't
do magic based on event device identification).

Best regards,
Bruno

> > What I've done so far is to write a daemon which connects to the ex=
isting
> > event device to get events from there, but this didn't really work =
as games
> > still see the original controller. =20
>=20
> Do you mean that games still see the events from the device? In that
> case you can grab the event device so you are the only one that can
> see the events.
>=20
> If your problem is that the game only look at the first joystick
> device, for SDL games, you can try the SDL_JOYSTICK_DEVICE env var
> (set to the event node, not the js node IIRC) to force the use of a
> specific joystick.
>=20
> If the game only open /dev/input/js0, you could try to reserve it
> before your gamepad is connected then replace with a new instance of
> you daemon. I never had to go that far yet.
>=20
> I have the same problems with my WiiU gamepad but so far I managed to
> make every games work with either xboxdrv+SDL_JOYSTICK_DEVICE or with
> SDL_GAMECONTROLLERCONFIG (for modern SDL games).
>=20
> >
> > That's why my current plan is to connect one layer deeper so the or=
iginal
> > event devices aren't created at all.
> >
> > My reason for userspace is, that it's easier to debug and for the p=
otential
> > end user it is easier to install. I just had too much trouble with =
dkms in
> > the past.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
