From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: Sony DualShock3 - Detected but no events
Date: Tue, 1 Nov 2011 12:42:58 +0100
Message-ID: <20111101124258.744fdba3f854ce81b4e0c8be@studenti.unina.it>
References: <CAOazyz0GNJKFWNsaFiwheMjhBVJrcP-p8QBcsSvS3V97iuZFtQ@mail.gmail.com>
	<20111101011854.5e0e87b561f6b18dcc09a988@studenti.unina.it>
	<CAOazyz1EfHdg4gExfeVaQ_8mMV=1Tu-aYBTEo_j4MjLnNC4kHA@mail.gmail.com>
	<20111101090645.0d3abeac5909f87dae8bec58@studenti.unina.it>
	<CAOazyz0pBZE_qE3NYbz6n54kCA30dU2Z3PaT3_ufZv2egpj=cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__1_Nov_2011_12_42_58_+0100_/XkQqZtGEOIbgnko"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:45938 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753869Ab1KALnE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Nov 2011 07:43:04 -0400
In-Reply-To: <CAOazyz0pBZE_qE3NYbz6n54kCA30dU2Z3PaT3_ufZv2egpj=cg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-input@vger.kernel.org

--Signature=_Tue__1_Nov_2011_12_42_58_+0100_/XkQqZtGEOIbgnko
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Nov 2011 12:24:03 +0200
Alon Bar-Lev <alon.barlev@gmail.com> wrote:

[...]
> But can you please reply to the plain USB setup (wired) question?
> It should work without any patch, right? Vanilla kernel with proper
> setup should do the trick,
> no user mode component, just kernel support.
> Does it work for you? or can you confirm that plain USB HID with
> hid-sony is not working?
>=20

Quoting from my previous mail:

> > You need to press the PS button to make the device start sending input
> > events. To see events you can use 'jstest' on the jsX device node or
> > 'evtest' on the eventX device node.
> >=20
> > If this does not work either we can investigate further.

It does work for me, vanilla linux-3.1, no userspace support needed for
basic USB HID operation.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Tue__1_Nov_2011_12_42_58_+0100_/XkQqZtGEOIbgnko
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk6v20IACgkQ5xr2akVTsAEUZgCfSF+HqLca36krOmUwSbXGey6W
g70AmwY+s94+F2zsLG4/skSrVvgkPmCU
=OcHM
-----END PGP SIGNATURE-----

--Signature=_Tue__1_Nov_2011_12_42_58_+0100_/XkQqZtGEOIbgnko--
