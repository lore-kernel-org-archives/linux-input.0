From: Guus Sliepen <guus@sliepen.org>
Subject: Re: [RFC v2] Another approach to IR
Date: Sat, 5 Dec 2009 12:23:53 +0100
Message-ID: <20091205112353.GQ2970@sliepen.org>
References: <20091203194736.GM2970@sliepen.org>
 <4B183372.30104@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vS2hnRoLMmJ4tslQ"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 234-166.surfsnel.dsl.internl.net ([145.99.166.234]:24429 "EHLO
	sliepen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754131AbZLELXw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 5 Dec 2009 06:23:52 -0500
Content-Disposition: inline
In-Reply-To: <4B183372.30104@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@redhat.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, linux-input@vger.kernel.org


--vS2hnRoLMmJ4tslQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2009 at 04:53:54PM -0500, Jarod Wilson wrote:

> >Some years ago I wrote a tool called "inputlirc" that translates evdev e=
vents
> >into LIRC events,
[...]
> No longer necessary, there's a proper devinput lircd userspace
> driver that when paired with an lircd.conf (auto-generated based on
> linux/input.h) Just Works.
>=20
> http://lirc.sourceforge.net/remotes/devinput/lircd.conf.devinput

Ah, great, I can retire inputlirc then.

--=20
Met vriendelijke groet / with kind regards,
      Guus Sliepen <guus@sliepen.org>

--vS2hnRoLMmJ4tslQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAksaQsgACgkQAxLow12M2nuDCwCff+HYrnpHNytDnZJyN74F67Fw
LcEAoI08OIjUS3wZ8txvVndBDMF5KRcQ
=WV5o
-----END PGP SIGNATURE-----

--vS2hnRoLMmJ4tslQ--
