From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Wed, 30 Jun 2010 16:16:02 +0200
Message-ID: <20100630161602.7df34547.ospite@studenti.unina.it>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>
	<4C2A1FA0.6020704@signal11.us>
	<alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>
	<AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com>
	<alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz>
	<AANLkTil-hNWeWbLQqE0ezlmZhO1w402NClaT_tayPJra@mail.gmail.com>
	<4C2B3E6B.7060703@signal11.us>
	<AANLkTilzYu3mA3vDzuVyxngTcltgKEoNKYrdenz1Z-VG@mail.gmail.com>
	<20100630151358.d9c9f043.ospite@studenti.unina.it>
	<AANLkTimpiuADYMRmPNWO_qWjQj1LKyjmh3JncuK9Fa4I@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__30_Jun_2010_16_16_02_+0200__y=iZoxtN6IFk2Qj"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:53883 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756113Ab0F3OQQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 10:16:16 -0400
In-Reply-To: <AANLkTimpiuADYMRmPNWO_qWjQj1LKyjmh3JncuK9Fa4I@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiaofan Chen <xiaofanc@gmail.com>
Cc: Alan Ott <alan@signal11.us>, Amit Nagal <helloin.amit@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

--Signature=_Wed__30_Jun_2010_16_16_02_+0200__y=iZoxtN6IFk2Qj
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Jun 2010 22:02:00 +0800
Xiaofan Chen <xiaofanc@gmail.com> wrote:

> On Wed, Jun 30, 2010 at 9:13 PM, Antonio Ospite
> <ospite@studenti.unina.it> wrote:
> >
> > One of the advantages in the usb case is that you do not have to
> > _detach_ the kernel driver bound to the device in order to set/get
> > raw hid reports. With libusb this is needed.
> >
>=20
> To me this is not that much an advantage. Actually libusb-1.0
> has the API to re-attach the kernel driver under Linux. And we make
> use of this in the new libusb-1.0 example program xusb.
> http://libusb.sourceforge.net/api-1.0/group__dev.html#ga9de769d3aeb45a07f=
5559c8a0597cbcc
> http://git.libusb.org/?p=3Dlibusb-pbatard.git;a=3Dblob;f=3Dexamples/xusb.=
c;h=3De260153aa50234f1c994db521969b7f0e84aebb6;hb=3DHEAD
>

AFAICS you are actually _detaching_ and _reattaching_ the driver later
in this case, with hidraw you can interleave raw reports with normal
operation from the current driver.

Think to an input device to which you'd like to set/get a certain
feature report for some reason, but that is already registered by
evdev; if you use this libusb mechanism the evdev system will see
the device disconnected and reconnected, with hidraw you just send the
report "transparently" wrt. other subsystems.

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

--Signature=_Wed__30_Jun_2010_16_16_02_+0200__y=iZoxtN6IFk2Qj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwrUaIACgkQ5xr2akVTsAEsywCeJhs5MC4kn7LzmgMIsKZ+CC0x
MQ4An0WkLMW0cUvTIJaHN2BHiaIqQ3iu
=hhm+
-----END PGP SIGNATURE-----

--Signature=_Wed__30_Jun_2010_16_16_02_+0200__y=iZoxtN6IFk2Qj--
