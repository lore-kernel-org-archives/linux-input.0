From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: Sony DualShock3 - Detected but no events
Date: Tue, 1 Nov 2011 20:11:42 +0100
Message-ID: <20111101201142.af88469abf03d8a9779c4e46@studenti.unina.it>
References: <CAOazyz0GNJKFWNsaFiwheMjhBVJrcP-p8QBcsSvS3V97iuZFtQ@mail.gmail.com>
	<20111101011854.5e0e87b561f6b18dcc09a988@studenti.unina.it>
	<CAOazyz1EfHdg4gExfeVaQ_8mMV=1Tu-aYBTEo_j4MjLnNC4kHA@mail.gmail.com>
	<20111101090645.0d3abeac5909f87dae8bec58@studenti.unina.it>
	<CAOazyz0pBZE_qE3NYbz6n54kCA30dU2Z3PaT3_ufZv2egpj=cg@mail.gmail.com>
	<20111101124258.744fdba3f854ce81b4e0c8be@studenti.unina.it>
	<CAOazyz1N4QmrC4MN6M532_3m_gVC+7PBBOUU+Mu8Qq7_eX5iZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__1_Nov_2011_20_11_42_+0100_XM.IAGZ6nge8_FCj"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:48047 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753773Ab1KATL4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Nov 2011 15:11:56 -0400
In-Reply-To: <CAOazyz1N4QmrC4MN6M532_3m_gVC+7PBBOUU+Mu8Qq7_eX5iZA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-input@vger.kernel.org

--Signature=_Tue__1_Nov_2011_20_11_42_+0100_XM.IAGZ6nge8_FCj
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Nov 2011 20:16:51 +0200
Alon Bar-Lev <alon.barlev@gmail.com> wrote:

> On Tue, Nov 1, 2011 at 1:42 PM, Antonio Ospite <ospite@studenti.unina.it>=
 wrote:
> > It does work for me, vanilla linux-3.1, no userspace support needed for
> > basic USB HID operation.
>=20
> This is great to hear!
>=20
> Unfortunatally, not working for me.
> And as the hid-sony is the same for usb and bluetooth I guess I need
> to solve the bluetooth issue first...
>

USB and bluetooth operation are independent, if I had to guess I'd say
the problem is bluetooth related.

> As I wrote at the beginning of this thread, the js0 and event15
> devices are there, but no events.
>=20

Even after pressing the *PS* button _after_ plugging the device in?
Try resetting the joypad using the hole-button on the bottom.

[...]
> Any idea what is the difference? Is there firmware revision or
> something similar?
>=20

Try attaching the output of

	lsusb -d 054c:0268 -vvv

and is it an _original_ controller?

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Tue__1_Nov_2011_20_11_42_+0100_XM.IAGZ6nge8_FCj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk6wRG4ACgkQ5xr2akVTsAGBCwCgpXP5oYZ2nQq/gtsQnwJmAC1a
/ikAoIPcs3zUjJBtw9p2A3fuiRo2JfYA
=V2P7
-----END PGP SIGNATURE-----

--Signature=_Tue__1_Nov_2011_20_11_42_+0100_XM.IAGZ6nge8_FCj--
