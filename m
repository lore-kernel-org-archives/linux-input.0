From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [stable] [PATCH 0/2] HID: hidraw, fix two NULL pointer
 dereferences
Date: Fri, 15 Oct 2010 09:44:36 +0200
Message-ID: <20101015094436.50ab68f3.ospite@studenti.unina.it>
References: <alpine.LNX.2.00.1010041548580.29535@pobox.suse.cz>
	<1286292017-6746-1-git-send-email-ospite@studenti.unina.it>
	<20101005174200.GB29937@kroah.com>
	<20101005221619.88904313.ospite@studenti.unina.it>
	<alpine.LNX.2.00.1010061130430.29535@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__15_Oct_2010_09_44_36_+0200_dCY07T44pNUJwZwc"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:56435 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058Ab0JOHpS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Oct 2010 03:45:18 -0400
In-Reply-To: <alpine.LNX.2.00.1010061130430.29535@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Greg KH <greg@kroah.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Neukum <oliver@neukum.name>, stable@kernel.org, Alan Ott <alan@signal11.us>

--Signature=_Fri__15_Oct_2010_09_44_36_+0200_dCY07T44pNUJwZwc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Oct 2010 11:31:55 +0200 (CEST)
Jiri Kosina <jkosina@suse.cz> wrote:

> On Tue, 5 Oct 2010, Antonio Ospite wrote:
>=20
> > > > here are some fixes to hidraw.
> > > >=20
> > > > Patches are against 2.6.36-rc6, but they should be ported to other
> > > > maintained stable kernels as well.
[...]
>=20
> I have added the 'Cc:' markings now and applied both patches, thanks.
>=20

Jiri, these are not in 2.6.36-rc8, any chance we can make it for 2.6.36?

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__15_Oct_2010_09_44_36_+0200_dCY07T44pNUJwZwc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky4BmUACgkQ5xr2akVTsAHICgCeJM3vqM31uN/fB04hufuRFq0l
SjMAnA7stpeoUMKAkU6a0/DFIAwj/O9U
=01cY
-----END PGP SIGNATURE-----

--Signature=_Fri__15_Oct_2010_09_44_36_+0200_dCY07T44pNUJwZwc--
