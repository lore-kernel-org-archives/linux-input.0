From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH BlueZ 2/4] Add sixaxis plugin: USB pairing and LEDs
 settings
Date: Mon, 22 Aug 2011 22:08:51 +0200
Message-ID: <20110822220851.38d346165c3afaa592888eed@studenti.unina.it>
References: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
	<1312553358-26280-3-git-send-email-ospite@studenti.unina.it>
	<4E41EBE5.7040908@signal11.us>
	<20110818161357.8084ab94bff57391e7ec3284@studenti.unina.it>
	<20110819215716.71f6b39d3b5e783c4276f422@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__22_Aug_2011_22_08_51_+0200_Yubf.9jMSO/izqmG"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:54411 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246Ab1HVUJF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Aug 2011 16:09:05 -0400
In-Reply-To: <20110819215716.71f6b39d3b5e783c4276f422@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Mikko Virkkila <virkkila@kapsi.fi>, Simon Wood <simon@mungewell.org>, Arc Riley <arcriley@gmail.com>, Sergey Kondakov <virtuousfox@gmail.com>

--Signature=_Mon__22_Aug_2011_22_08_51_+0200_Yubf.9jMSO/izqmG
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Aug 2011 21:57:16 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:

> On Thu, 18 Aug 2011 16:13:57 +0200
> Antonio Ospite <ospite@studenti.unina.it> wrote:
>=20
> [...]
> > If the idea looks OK I'll fold those patches in v5, along with the
> > plugin renaming to "sony-controller", and maybe I'll split the plugin in
> > several modules too:
> >   sony-controller.c 	/* udev and bluez stuff */
> >   sony-controller-hid.c	/* hidraw and device specific stuff */
> >   sony-controlled-hid.h
> >=20
>=20
> Do you think "controller" fits the PS3 headset as well?
>=20

OK, given that:
  - all the possibly supported devices at this time are PS3 peripherals;
  - some of them are not input controllers;
  - the cable pairing/association  mechanism generally does not apply to
    other sony BT hardware;
  - someone imagined a future PS4 controller using the same pairing=20
    mechanism;

with Alan we came up with the name:

	playstation-peripheral

for the plugin; do you people like that, or does the variant

	playstation-device

sound better to you?

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Mon__22_Aug_2011_22_08_51_+0200_Yubf.9jMSO/izqmG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5St1MACgkQ5xr2akVTsAH/6QCffufxVZurGCwaGQOOeqqZ72wh
O1oAniXNutCJBGDRpaNES6GYwXvufrM1
=qyDR
-----END PGP SIGNATURE-----

--Signature=_Mon__22_Aug_2011_22_08_51_+0200_Yubf.9jMSO/izqmG--
