From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for July 30
Date: Mon, 4 Aug 2008 15:47:17 +1000
Message-ID: <20080804154717.cfdb6710.sfr@canb.auug.org.au>
References: <20080730170635.f737ffe9.sfr@canb.auug.org.au>
	<20080730231029.9818953c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__4_Aug_2008_15_47_17_+1000_ndiXz4hh.vR59FiU"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:58489 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834AbYHDFrY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Aug 2008 01:47:24 -0400
In-Reply-To: <20080730231029.9818953c.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org

--Signature=_Mon__4_Aug_2008_15_47_17_+1000_ndiXz4hh.vR59FiU
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew, Dmitry,

On Wed, 30 Jul 2008 23:10:29 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Wed, 30 Jul 2008 17:06:35 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>=20
> > I have created today's linux-next tree at
> > git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git
>=20
> The X server broke on my FC8 t61p thinkpad.  Mainline is OK.
>=20
> Various information is at http://userweb.kernel.org/~akpm/mo/
>=20
> I'm suspecting the input layer - my synaptics device seems to have
> disappeared?  See http://userweb.kernel.org/~akpm/mo/Xorg-log-diff.txt

I have reverted commit 03bac96fae0efdb25e2059e5accbe4f3ee6328dd ("Input:
expand keycode space") from linux-next until we have some resolution of
this problem.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__4_Aug_2008_15_47_17_+1000_ndiXz4hh.vR59FiU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiWl+UACgkQjjKRsyhoI8wjmQCeMU1gFz7Ghksk3x2cS467FEUh
ajUAn2a+k/1zjQkzaapO5v0ArarZuo1A
=+Hcp
-----END PGP SIGNATURE-----

--Signature=_Mon__4_Aug_2008_15_47_17_+1000_ndiXz4hh.vR59FiU--
