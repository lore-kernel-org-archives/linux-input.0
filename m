From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: ALPS touchpad ot correctly recognized: GlidePoint vs DualPoint
Date: Sun, 4 Feb 2018 21:21:18 +0100
Message-ID: <20180204202118.fmyhcqmteyu6jnit@pali>
References: <ada750eb-daeb-c9ae-2452-fcf027a4e704@posteo.net>
 <201709080848.53286@pali>
 <52f87b68-8a6b-1d9c-f341-1e488ff43441@posteo.net>
 <201709091036.06899@pali>
 <20170909181218.GA29107@dtor-ws>
 <b3b06164-183b-d3f8-8de2-804eb1d343dd@posteo.net>
 <KAWPR01MB1092DDBF54FC34842384D3BBC7680@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <7d5d4e88-b6d2-ce7b-a529-18f2b131fa7f@posteo.net>
 <20180204181605.eknruesqvvnncrqd@pali>
 <f291e382-b90e-baba-fb3c-bdebc991a21d@posteo.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vaxkck2ulk7n5oyu"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35050 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752531AbeBDUVV (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 4 Feb 2018 15:21:21 -0500
Received: by mail-wm0-f51.google.com with SMTP id r78so22080595wme.0
        for <linux-input@vger.kernel.org>; Sun, 04 Feb 2018 12:21:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <f291e382-b90e-baba-fb3c-bdebc991a21d@posteo.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Juanito <juam+kernel@posteo.net>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Paul Donohue <linux-kernel@paulsd.com>


--vaxkck2ulk7n5oyu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 04 February 2018 20:39:06 Juanito wrote:
> On 02/04/2018 07:16 PM, Pali Roh=C3=A1r wrote:
> > On Monday 11 September 2017 13:26:30 Juanito wrote:
> >> Hi Masaki Ota,
> >>
> >> Thanks!
> >>
> >> On 11.09.2017 04:38, Masaki Ota wrote:
> >>> Hi, Juanito,
> >>>
> >>> In my information, ALPS Touchpad is used on Thinkpad E series and L s=
eries.
> >>> I don't know the device that is ALPS Touchpad + other vendor TrackSti=
ck.
> >>> But Lenovo might use ALPS Touchpad on such a combination.
> >>>
> >>
> >> Well, that is probably my fault, as it is not the original touchpad th=
at
> >> was delievered with the laptop. I bought the touchpad (that included
> >> the three buttons) separately because I didn't like the clickpad that
> >> came with my laptop.
> >=20
> > Hi Juanito,
> >=20
>=20
> Hi Pali,
>=20
> > if you are still want to play with your touchpad hardware, I have a good
> > news for your.
> >=20
>=20
> Yeah! I'd love to get it to work! It's just I've been "working" on some
> other projects and my last kernel builds didn't work at all so I gave up
> and never got back to it.
>=20
> Thank you very much for that!
>=20
> > It looks like that at least ALPS rushmore touchpads allow to receive RAW
> > PS/2 packets from trackstick to host kernel, without modifying them by
> > touchpad. Plus I was able to tell ALPS touchpad to start "mixing" those
> > RAW trackstick PS/2 packets with native touchpad packets.
> >=20
> > On my configuration trackstick in RAW PS/2 mode by default talks with
> > standard bare 3 byte PS/2 protocol and touchpad in 6 byte ALPS protocol.
> > alps.c/psmouse.ko is already able to process and parse such mixed
> > packets. And trackstick can be switched to some extended 4 byte
> > protocol...
> >=20
> > All this happen when passthrough mode is enabled.
> >=20
> > From my understanding it seems that in normal mode, touchpad and
> > trackstick communicate with that 4 byte protocol and touchpad converts
> > it into 6 byte ALPS protocol and then send to kernel.
> >=20
> > On thinkpads trackstick communicate with TPPS/2 protcol and above 4
> > byte. So in my opinion ALPS touchpad by default cannot understand it.
> > But you should be able to enter passthrough mode and then you would
> > receive that TPPS/2 in alps kernel code.
> >=20
>=20
> I don't really understand what you mean. Do I "just" have to set it to
> passthrough mode? How exactly can I do that?

Look at function alps_passthrough_mode_v3(). And try to call it after
touchpad is initialized.

You can also look which alps_command_mode_write_reg() functions are
called for your touchpad and maybe try to figure out what those
registers can enabled/disable.

On http://www.cirque.com/gen4-dev-resources you can find document named
GP-AN- 130823 INTERFACING TO GEN4 OVER I2C (PDF) which contains
some description of those registers (in section 7).

Register C2C8, bit 0 has description "PS2AuxControl.CommandPassThruEnabled"

If trackstick is not detected, it seems you can "force" enable it by
setting bit 7 "PS2AuxControl.AuxDevicePresent" in same register.

> Again, thank you very much!

Have you tried to read from that register which Masaki Ota talked in
previous emails?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--vaxkck2ulk7n5oyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWndrPAAKCRCL8Mk9A+RD
UmSzAJsEGRc7mgRPeQGIPgyIKJ5+dNSqVwCgoFegtqlGpUcxPKrUFUi40bN6MeU=
=vt7A
-----END PGP SIGNATURE-----

--vaxkck2ulk7n5oyu--
