From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH 0/2] HID: hidraw, fix two NULL pointer dereferences
Date: Wed, 6 Oct 2010 12:01:29 +0200
Message-ID: <20101006120129.52da81d3.ospite@studenti.unina.it>
References: <alpine.LNX.2.00.1010041548580.29535@pobox.suse.cz>
	<1286292017-6746-1-git-send-email-ospite@studenti.unina.it>
	<4CAB94A0.8040402@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__6_Oct_2010_12_01_29_+0200_pvfp_vBqoKLknSIh"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:55934 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216Ab0JFKBl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Oct 2010 06:01:41 -0400
In-Reply-To: <4CAB94A0.8040402@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Alan Ott <alan@signal11.us>, Oliver Neukum <oliver@neukum.name>, linux-kernel@vger.kernel.org, stable@kernel.org

--Signature=_Wed__6_Oct_2010_12_01_29_+0200_pvfp_vBqoKLknSIh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 05 Oct 2010 23:12:00 +0200
Jiri Slaby <jirislaby@gmail.com> wrote:

> On 10/05/2010 05:20 PM, Antonio Ospite wrote:
> > here are some fixes to hidraw.
> >=20
> > Patches are against 2.6.36-rc6, but they should be ported to other
> > maintained stable kernels as well.
> >=20
> > Antonio Ospite (2):
> >   HID: hidraw, fix a NULL pointer dereference in hidraw_ioctl
> >   HID: hidraw, fix a NULL pointer dereference in hidraw_write
>=20
> Hi, please fix also the window in hidraw_release.
>

I am not sure I get what you mean, can you please add more details?

> thanks,
> --=20
> js
>=20

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__6_Oct_2010_12_01_29_+0200_pvfp_vBqoKLknSIh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkysSPkACgkQ5xr2akVTsAHyPQCdE0Jtmhz8Z2xq9vZUoNXZKwFh
x7kAn2GYNoGlkgOZTNj+nYmjHw3pgfpK
=KMIf
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Oct_2010_12_01_29_+0200_pvfp_vBqoKLknSIh--
