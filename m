From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: ALPS touchpad ot correctly recognized: GlidePoint vs DualPoint
Date: Mon, 12 Feb 2018 00:01:45 +0100
Message-ID: <20180211230145.y7mnn4oap5q434nt@pali>
References: <201709091036.06899@pali>
 <20170909181218.GA29107@dtor-ws>
 <b3b06164-183b-d3f8-8de2-804eb1d343dd@posteo.net>
 <KAWPR01MB1092DDBF54FC34842384D3BBC7680@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <7d5d4e88-b6d2-ce7b-a529-18f2b131fa7f@posteo.net>
 <20180204181605.eknruesqvvnncrqd@pali>
 <f291e382-b90e-baba-fb3c-bdebc991a21d@posteo.net>
 <20180204202118.fmyhcqmteyu6jnit@pali>
 <131d0bb6-4861-95a0-3963-790c91cb3912@posteo.net>
 <712c2657-5cf6-5fa0-1358-82bece1c02f8@posteo.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vjj6fwpeswzrfnru"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:38734 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932160AbeBKXBs (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 11 Feb 2018 18:01:48 -0500
Received: by mail-wr0-f174.google.com with SMTP id t94so13428423wrc.5
        for <linux-input@vger.kernel.org>; Sun, 11 Feb 2018 15:01:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <712c2657-5cf6-5fa0-1358-82bece1c02f8@posteo.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Juanito <juam+kernel@posteo.net>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Paul Donohue <linux-kernel@paulsd.com>


--vjj6fwpeswzrfnru
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 05 February 2018 12:19:48 Juanito wrote:
>=20
>=20
> On 02/05/2018 08:48 AM, Juanito wrote:
> > On 02/04/2018 09:21 PM, Pali Roh=C3=A1r wrote:
> >> On Sunday 04 February 2018 20:39:06 Juanito wrote:
> >>> On 02/04/2018 07:16 PM, Pali Roh=C3=A1r wrote:
> >>>> On Monday 11 September 2017 13:26:30 Juanito wrote:
> >>>>> Hi Masaki Ota,
> >>>>>
> >>>>> Thanks!
> >>>>>
> >>>>> On 11.09.2017 04:38, Masaki Ota wrote:
> >>>>>> Hi, Juanito,
> >>>>>>
> >>>>>> In my information, ALPS Touchpad is used on Thinkpad E series and =
L series.
> >>>>>> I don't know the device that is ALPS Touchpad + other vendor Track=
Stick.
> >>>>>> But Lenovo might use ALPS Touchpad on such a combination.
> >>>>>>
> >>>>>
> >>>>> Well, that is probably my fault, as it is not the original touchpad=
 that
> >>>>> was delievered with the laptop. I bought the touchpad (that included
> >>>>> the three buttons) separately because I didn't like the clickpad th=
at
> >>>>> came with my laptop.
> >>>>
> >>>> Hi Juanito,
> >>>>
> >>>
> >>> Hi Pali,
> >>>
> >>>> if you are still want to play with your touchpad hardware, I have a =
good
> >>>> news for your.
> >>>>
> >>>
> >>> Yeah! I'd love to get it to work! It's just I've been "working" on so=
me
> >>> other projects and my last kernel builds didn't work at all so I gave=
 up
> >>> and never got back to it.
> >>>
> >>> Thank you very much for that!
> >>>
> >>>> It looks like that at least ALPS rushmore touchpads allow to receive=
 RAW
> >>>> PS/2 packets from trackstick to host kernel, without modifying them =
by
> >>>> touchpad. Plus I was able to tell ALPS touchpad to start "mixing" th=
ose
> >>>> RAW trackstick PS/2 packets with native touchpad packets.
> >>>>
> >>>> On my configuration trackstick in RAW PS/2 mode by default talks with
> >>>> standard bare 3 byte PS/2 protocol and touchpad in 6 byte ALPS proto=
col.
> >>>> alps.c/psmouse.ko is already able to process and parse such mixed
> >>>> packets. And trackstick can be switched to some extended 4 byte
> >>>> protocol...
> >>>>
> >>>> All this happen when passthrough mode is enabled.
> >>>>
> >>>> From my understanding it seems that in normal mode, touchpad and
> >>>> trackstick communicate with that 4 byte protocol and touchpad conver=
ts
> >>>> it into 6 byte ALPS protocol and then send to kernel.
> >>>>
> >>>> On thinkpads trackstick communicate with TPPS/2 protcol and above 4
> >>>> byte. So in my opinion ALPS touchpad by default cannot understand it.
> >>>> But you should be able to enter passthrough mode and then you would
> >>>> receive that TPPS/2 in alps kernel code.
> >>>>
> >>>
> >>> I don't really understand what you mean. Do I "just" have to set it to
> >>> passthrough mode? How exactly can I do that?
> >>
> >> Look at function alps_passthrough_mode_v3(). And try to call it after
> >> touchpad is initialized.
> >>
> >=20
> > Cool, I'll give this a try!
> >=20
> >> You can also look which alps_command_mode_write_reg() functions are
> >> called for your touchpad and maybe try to figure out what those the
> >> registers can enabled/disable.
> >>
> >> On http://www.cirque.com/gen4-dev-resources you can find document named
> >> GP-AN- 130823 INTERFACING TO GEN4 OVER I2C (PDF) which contains
> >> some description of those registers (in section 7).
> >>
> >> Register C2C8, bit 0 has description "PS2AuxControl.CommandPassThruEna=
bled"
> >>
> >> If trackstick is not detected, it seems you can "force" enable it by
> >> setting bit 7 "PS2AuxControl.AuxDevicePresent" in same register.
> >>
> >>> Again, thank you very much!
> >>
> >> Have you tried to read from that register which Masaki Ota talked in
> >> previous emails?
> >>
> >=20
> > I tried but I just didn't manage to get it to work, at all and gave up
> > (I really am a newbie in this whole kernel world). Maybe a fresh start
> > helps here.
> >
>=20
> Oh, oh! Currently, my touchpad is just being recognized as a PS/2
> Generic Mouse.
>=20
> On both debian stretch kernel (4.9.0-5-amd64) and on a 4.15.0+ compiled
> by me.

Maybe bug in kernel driver? Can you install older kernel version and
find which worked?

> I'll try to see if I can find out why this is happening.

The best way is to enable debug output and look into dmesg log why
alps.c refused to register your touchpad.

> Do have any idea why this might be the case (it used to be recognized as
> ALPS)?

There were some bugs with ALPS touchpads and IIRC all of them (expect
one) should be fixed in git. So maybe you hit it.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--vjj6fwpeswzrfnru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWoDLVwAKCRCL8Mk9A+RD
UlX+AJ9pAFvyHaUhXoYDbr1LXzhEpYBS5QCgqpS7PJKRaYPG5R+FRxBn/9uWD9U=
=ed4W
-----END PGP SIGNATURE-----

--vjj6fwpeswzrfnru--
