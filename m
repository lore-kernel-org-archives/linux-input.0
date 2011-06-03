From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: HID joystick - Axis 11 non operational.
Date: Fri, 3 Jun 2011 16:15:11 +0200
Message-ID: <20110603161511.af4dd9e0.ospite@studenti.unina.it>
References: <9c3f08ce41f278fc835bf09e489eef0f.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__3_Jun_2011_16_15_11_+0200_B+BF6DYis+PWKgzA"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:45106 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419Ab1FCOPT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Jun 2011 10:15:19 -0400
In-Reply-To: <9c3f08ce41f278fc835bf09e489eef0f.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

--Signature=_Fri__3_Jun_2011_16_15_11_+0200_B+BF6DYis+PWKgzA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Jun 2011 15:25:02 -0400
simon@mungewell.org wrote:

> I have a strange bug, axis 11 does not appear to be working at all,
> remains at -32768 all the time.
>=20
> On the Sixaxis controller almost all the buttons are pressure sensitive,
> and thus reported as axis as well as buttons. The 'faulty' axis is in the
> middle of a descriptor group so I don't think the problem is with the
> descriptor.
>=20
> Hidraw0 logging shows that the gamepad is sending the correct data. Logs
> from hidraw and jstest attached.
>=20
> Axis 10 - Dpad-down
> Axis 11 - Dpad-left
> Axis 12 - L2 trigger
>

I confirm that the axis for Dpad-left (usage->code =3D=3D 0x2f IINM) of the
Sixaxis looks like it is not working. I too can see the data on hidraw
device but not on the joystick or even the event device, so it may be
below the joystick layer.

> This fault is seen with Sixaxis and 3rd party wired controller. Tested
> with 3.0rc1 kernel.
>

Simon when you say "3rd party wired controller" do you mean still
Sixaxis compatible?

> Is there any chance/place where userland could be misconfigured? Or where
> should I look in the kernel?
>=20

I took a quick look at hid-input.c thinking that something about
event bits could be wrong but haven't found anything so far.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__3_Jun_2011_16_15_11_+0200_B+BF6DYis+PWKgzA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3o7G8ACgkQ5xr2akVTsAHu4wCbBsOfRoFRnpdmagS4YBk89lfA
xKAAnRjbk5e9ngE8x1QGJ6KAcjAU3V4I
=QGj+
-----END PGP SIGNATURE-----

--Signature=_Fri__3_Jun_2011_16_15_11_+0200_B+BF6DYis+PWKgzA--
