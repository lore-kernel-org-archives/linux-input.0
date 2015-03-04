From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Bug in i2c-core?
Date: Wed, 4 Mar 2015 07:47:21 +0100
Message-ID: <20150304064721.GA883@katana>
References: <54F0507F.6030804@armadeus.com>
 <20150227165944.GA6679@dtor-ws>
 <3574616.qzNqihiGp7@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:39319 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758399AbbCDGrO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Mar 2015 01:47:14 -0500
Content-Disposition: inline
In-Reply-To: <3574616.qzNqihiGp7@avalon>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, =?utf-8?Q?S=C3=A9bastien?= SZYMANSKI <sebastien.szymanski@armadeus.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Yes, this commit breaks all drivers using devm* for IRQ management on
> > OF-based systemsi because devm* cleanup happens in device code, after
> > bus's remove() method returns. I'd recommend reverting and finding a
> > better way (making cleanup a custom devm action as well?).
>=20
> Ouch, my bad.
>=20
> Wolfram, any opinion ? The original patch fixes a real bug, so we shouldn=
't=20
> just revert it.

I guess the usual rules apply. Let's try to fix it for v4.0, otherwise I
have to revert it.


--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9qp4AAoJEBQN5MwUoCm2l8QQALYNiRYduK6CbAjJdQmHxjlC
cqDvPYnYNItCkU/ZDUy4p8PwLDfYPtmSJhAphmTP4luMwe2GoTC0MUGD1AvxijtF
8XWmqdOfOZlvrH3Wt9J5FHZ2t2lSaxuK91NyqFKfxdZLOK1Ul2E7yibZgRJgdNkL
qvcIaaFr/a4aPALmdlLZjeR3YrvhgVnozX2i+k5HO8cLBKZGngdHPboqt/ONOp81
MFv0zVP1CAoRd3k92giZ2JAQZAKXHtE2KGoU0pequNVNZKo0n05PF/10uL0GJBMj
4VU1xgoTHRUTIB2rn/FgXaRK+sxvMejmX/W5EXYZwAsRSBSv3ySu6c2ui39bChTk
y3a7dyFuJkcZlDEt2xLSh0a34MLYDWja+4SgxNocBgp1pu3NRxClpBicphxs2fkJ
vtzJY9L6dRYByUJFCqaHL8N+RhzH+hyqlYq/3l4MRD3UXyBIrAG1bT/rTD0sHrPU
/VJOWuQmBx5cbfo8e5hbmwCnVbXdd562qD3AZAojxR9Vp2LzG0V09239Rq3s58BX
d41m4TKWW5KWd+wLHQx8OnloKETBM3vs2b+zmlIcXSZMZKrEDbbCOG/e6xwOudXk
Zg8yFxYMOU1FXzgebDNhoHzvZSK6ZVpvGYW3IsE89/qIHYL/oTD5iY4y7fZhlkHr
T1vywtIA2vzYP063HW7w
=Kdn5
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
