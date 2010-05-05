From: Florian Ragwitz <rafl@debian.org>
Subject: Re: [PATCH 1/2] elantech: Report tool width when it is known
Date: Wed, 5 May 2010 18:53:24 +0200
Message-ID: <20100505165323.GG6075@perldition.org>
References: <4BE16121.8040000@tudelft.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rV8arf8D5Dod9UkK"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from weedy.perldition.org ([85.10.210.75]:46962 "EHLO
	weedy.perldition.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab0EEQx1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 12:53:27 -0400
Content-Disposition: inline
In-Reply-To: <4BE16121.8040000@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-15?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>


--rV8arf8D5Dod9UkK
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 05, 2010 at 02:14:25PM +0200, =C9ric Piel wrote:
> >From observation of the values sent from the hardware version 2, it
> seems that the first four bits of byte 1 represents the width. So we can
> report it as well. Observed values on my hardware were always between 1
> and 12, so let's use this for min and max.

Excellent. I'm quite happy to see this.

I've actually thought about reporting some kind of width based on the
"thumb" bit in the first byte. The actual width information being
available didn't occur to me for some reason.

The patch itself looks just fine to me, but it might also want to update
the elantech documentation accordingly.

See also https://patchwork.kernel.org/patch/95448/ which isn't part of
the -input tree yet.


--=20
BOFH excuse #362:
Plasma conduit breach

--rV8arf8D5Dod9UkK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFL4aKDdC8qQo5jWl4RAvP7AJ4+MIVnYcNKq7k9PzjCOg6Szs3rwQCfb5DH
RR38RgPnJomcZoOulHWAec8=
=cIP3
-----END PGP SIGNATURE-----

--rV8arf8D5Dod9UkK--
