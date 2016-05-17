From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Dell Latitude E7470 touchpad status
Date: Tue, 17 May 2016 15:16:29 +0200
Message-ID: <20160517131629.GE29844@pali>
References: <87eg9j6zf7.fsf@smart-cactus.org>
 <23E0F704395E694FA4710C833FA087E50D40B8BF13@TPEX7ADC101.APAC.DELL.COM>
 <87bn45gr0e.fsf@smart-cactus.org>
 <20160517082309.GZ29844@pali>
 <877fet10a9.fsf@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37601 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbcEQNQe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2016 09:16:34 -0400
Received: by mail-wm0-f47.google.com with SMTP id a17so30529516wme.0
        for <linux-input@vger.kernel.org>; Tue, 17 May 2016 06:16:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <877fet10a9.fsf@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>
Cc: Allen_Hung@Dell.com, Mario_Limonciello@Dell.com, linux-input@vger.kernel.org

On Tuesday 17 May 2016 11:50:06 Ben Gamari wrote:
> Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:
>=20
> > Hi Ben!
> >
> > Maybe it could help you, look at my email sent to linux-input ML ye=
ar
> > ago: http://thread.gmane.org/gmane.linux.kernel.input/41210
>=20
> Hi Pali!
>=20
> Thanks, this looks great (assuming this is in fact the protocol spoke=
n
> by the E7470 hardware; perhaps Allen could confirm this?). I'll have =
a
> go at rebasing this sometime soon, although it looks like this may ta=
ke
> a fair bit of work as the patch is of the usual... questionable quali=
ty
> that you'd expect from a hardware vendor and on top of that the drive=
r
> itself seems to have evolved significantly.

=46irst you need to identify if your touchpad is ALPS or not. If not th=
en
work on rebasing is useless.

To identify your touchpad there are two ways:

1) Disassemble laptop and look what is under palmrest/keyboard. Latitud=
e
laptops used to have good documentation how to do it (on official dell
site) and older Exx40 series is not hard to detect it...

2) Look at ALPS detection code. Basically all (known) ALPS touchpad
response to some PS/2 sequence with specific answer. So you can compile
psmouse.ko/alps.c in debug mode and look if it fit detection or not.

I suggest you to do this first investigation step. If touchpad is ALPS
or not. I read that some Dell laptops uses synaptics touchpads, so ther=
e
is non zero chance that touchpad could not be ALPS.

> > Also try to look at dell drivers page, there could be linux package=
 for
> > your laptop with drivers. Lot of them used to be in dkms format
> > (upstream source code with dell changes).
> >
> I've been unable to find a support package for my machine on the web
> site. However, I'm also in touch with Dell through the usual support
> channel so perhaps they'll be able to provide a more up-to-date code
> drop.

IIRC All (new) Latitude laptops can be configured with Ubuntu and in
this case they come with preinstalled Ubuntu with that support package.

So for sure contact Dell support and ask for it! You can also see Ubunt=
u
as supported system in PDF material about those Latitudes...

> > ALPS code from Dell were open source, it was just hard to find it a=
nd
> > compile it on other then one kernel version. And harder to generate
> > patch (like I did in above email)...
> >
> Right, as I said it looks like rebasing this code drop onto a recent
> kernel might require quite some effort.

Yes, it would not be simple. Plus for including into mainline kernel
needs lot of cleaning (see that email thread).

> I do wish that Dell would apply more pressure on their input device
> vendors to take upstream support (or open protocol documentation)
> seriously. It's very frustrating that we need to go through this same
> process with every hardware iteration.

If you will be 100% sure that touchpad is ALPS, I could contact ALPS
people. They helped me a lot with fixing ALPS touchpad support for my
E6440...

> Thanks again for the reference, Pali!
>=20
> Cheers,
>=20
> - Ben
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
