From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Wed, 30 Jun 2010 15:13:58 +0200
Message-ID: <20100630151358.d9c9f043.ospite@studenti.unina.it>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>
	<4C2A1FA0.6020704@signal11.us>
	<alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>
	<AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com>
	<alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz>
	<AANLkTil-hNWeWbLQqE0ezlmZhO1w402NClaT_tayPJra@mail.gmail.com>
	<4C2B3E6B.7060703@signal11.us>
	<AANLkTilzYu3mA3vDzuVyxngTcltgKEoNKYrdenz1Z-VG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__30_Jun_2010_15_13_58_+0200_1rmyNKzIkCYV9q0m"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:55225 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753193Ab0F3NOL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 09:14:11 -0400
In-Reply-To: <AANLkTilzYu3mA3vDzuVyxngTcltgKEoNKYrdenz1Z-VG@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiaofan Chen <xiaofanc@gmail.com>
Cc: Alan Ott <alan@signal11.us>, Amit Nagal <helloin.amit@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

--Signature=_Wed__30_Jun_2010_15_13_58_+0200_1rmyNKzIkCYV9q0m
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Jun 2010 21:04:59 +0800
Xiaofan Chen <xiaofanc@gmail.com> wrote:

> On Wed, Jun 30, 2010 at 8:54 PM, Alan Ott <alan@signal11.us> wrote:
> > Is that what you're asking for, or are you asking for something which w=
ill
> > tell you which reports are _available_ on the device, and what their le=
ngths
> > are? There is currently no way to report which reports are _available_.=
 As
> > Jiri said, HIDRAW does not do any parsing of the report descriptor. All=
 data
> > is passed "raw" from the user application to the device.
> >
> > If you know what type of device you are talking to, then you shouldn't
> > really need to parse the descriptor in software, because you'll know wh=
at
> > the device supports, right?
> >
>=20
> Sorry I do not know much about hidraw. However, if HIDraw is so
> "raw", what are the benefits of HIDRAW compared to using libusb?
> Then there is also libhid which is on top of libusb.
>

One of the advantages in the usb case is that you do not have to
_detach_ the kernel driver bound to the device in order to set/get
raw hid reports. With libusb this is needed.

> --=20
> Xiaofan
>=20

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Signature=_Wed__30_Jun_2010_15_13_58_+0200_1rmyNKzIkCYV9q0m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwrQxYACgkQ5xr2akVTsAEIYgCgpH2b04Jd8Occwqfu+yAewdwN
KlgAn2zJ/DN+SzqsV9DaeGLV7rphjJd6
=2Sgt
-----END PGP SIGNATURE-----

--Signature=_Wed__30_Jun_2010_15_13_58_+0200_1rmyNKzIkCYV9q0m--
