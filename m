From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v3] Input: appletouch - driver refactoring
Date: Mon, 13 Oct 2008 11:45:35 +0200
Message-ID: <1223891135.24954.1.camel@johannes.berg>
References: <1223542147.6130.14.camel@galileo>
	 <20081011032120.GB22499@anvil.corenet.prv>
	 <1223822468.9733.1.camel@galileo>  <1223822674.9733.5.camel@galileo>
	 <1223823289.10176.9.camel@johannes.berg> <1223827257.11389.1.camel@galileo>
	 <1223827421.11389.5.camel@galileo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-U1UDGPkkVnlYepZyJ/Iw"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:35767 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762093AbYJMJpr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Oct 2008 05:45:47 -0400
In-Reply-To: <1223827421.11389.5.camel@galileo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stelian Pop <stelian@popies.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org


--=-U1UDGPkkVnlYepZyJ/Iw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2008-10-12 at 18:03 +0200, Stelian Pop wrote:
> The appletouch driver has grown up from supporting only a couple of
> touchpads into supporting many touchpads, which can have different
> number of sensors, different aspect ratios etc.
>=20
> This patch cleans up the current driver code and makes it easy to
> support the features of each different touchpad.
>=20
> As a side effect, this patch also modifies the 'Y' multiplication factor
> of the 'geyser3' and 'geyser4' touchpads (found on Core Duo and Core2
> Duo MacBook and MacBook Pro laptops) in order to make the touchpad
> output match the aspect ratio of the touchpad (Y factor changed from 43
> to 64).

Looks good, the only thing I can find to complain about is that you
modify


> +static struct atp_info geyser1_info =3D {
> +	.xsensors	=3D 16,		/* will be set to 26 on 17" */

those static variables ;)

Considering these devices aren't available outside of apple laptops and
those always come with exactly one, I don't think it's much of a
problem.

johannes

--=-U1UDGPkkVnlYepZyJ/Iw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJI8xi7AAoJEKVg1VMiehFY/oUP/ROCPZaKkqz9FilBJxYxIrGF
SrbwsfdMWD4YdppErlisA+Sv/smNW4FvsUWJjRNC/IxJBomcI4Bf49qWFjZeKZub
ZLfah2M0Cib14WqpE29ezCev31eiGKNr9SLsxctVWi1k3iIQYz4tjSx+8csGCM9S
psVDSLQJuSURgZwbSDMFIufsOHPOsqT12OPjVFnjG3lwqjx+LAg5FxHbmybldZzY
TEeKkVtMmrsVgNjCxsLH/R5B5r5f4y54wRVv7dP9L6KBgj1JCHcS0z/xjUYjWmLj
6SaVcMLS2wd8Ghkmlk8fpf4aE7cRyyNEPQm3HLFeo2yCZcIGd6K1SB61Dog81ahJ
HCgBiL7s5zrzOyYnn7HtDz75h0cy3Fb2jmP1AD9kPlKc1S7EZegMRZv21GVUiPRM
01iteqHsEpAiKArnL+tFZKr9BPSOH6GA8TkFix9OyBH52zBwdPKV6U4Mj35bFBSn
j0qBIjB3cdh/kCIK1/U/a6L56LvbPMiY7jklX2IoeBXBBHRGRgKUpW3du+Y2Joq1
e8i3qfBy2UawgChoJiIX0Dc8SmmoU5dSh6f1l/te7mUWZhmXgVrjNtGaxOV6xDN7
7HrKtkJWEkTqqURlvpGjEi/LUCtWmPjCUZgwDqrlGcbMsYCRVknts70bH12bf60n
+8RVPfgKSODRsnfKKwTp
=gGwT
-----END PGP SIGNATURE-----

--=-U1UDGPkkVnlYepZyJ/Iw--

