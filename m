From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv2 0/2] Input: atmel_mxt_ts: Add reset support
Date: Mon, 4 Sep 2017 11:02:33 +0200
Message-ID: <20170904090232.hrzdohc723zdyhih@earth>
References: <20170703123843.19340-1-sebastian.reichel@collabora.co.uk>
 <20170725135656.2ua5j76fctkkdmlr@earth>
 <20170821100351.iou3b26hypuc7f4h@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cjmzp27fqus354zt"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40613 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753318AbdIDJCg (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 4 Sep 2017 05:02:36 -0400
Content-Disposition: inline
In-Reply-To: <20170821100351.iou3b26hypuc7f4h@earth>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Nick Dyer <nick@shmanahar.org>


--cjmzp27fqus354zt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Another two weeks, another ping. Is everything allright with Dmitry?

-- Sebastian

On Mon, Aug 21, 2017 at 12:03:51PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> ping?
>=20
> -- Sebastian
>=20
> On Tue, Jul 25, 2017 at 03:56:56PM +0200, Sebastian Reichel wrote:
> > Hi Dmitry,
> >=20
> > Gentle ping on this one. This helps to remove a hack from the
> > Droid 4 DT and will also be used by PPD, which is currently
> > being upstreamed:
> >=20
> > https://lkml.org/lkml/2017/7/19/898
> >=20
> > -- Sebastian
> >=20
> > On Mon, Jul 03, 2017 at 02:38:41PM +0200, Sebastian Reichel wrote:
> > > Hi,
> > >=20
> > > This adds support for the reset pin of Atmel MXT.
> > >=20
> > > Changes since PATCHv1:
> > >  - Add new patch preparing for resource managed gpio
> > >  - Use resource managed gpio
> > >  - Wait for interrupt after reset
> > >=20
> > > -- Sebastian
> > >=20
> > > Sebastian Reichel (2):
> > >   Input: atmel_mxt_ts: Use more managed resources
> > >   Input: atmel_mxt_ts: Add support for reset line
> > >=20
> > >  .../devicetree/bindings/input/atmel,maxtouch.txt   |  2 ++
> > >  drivers/input/touchscreen/atmel_mxt_ts.c           | 42 ++++++++++++=
+++-------
> > >  2 files changed, 31 insertions(+), 13 deletions(-)
> > >=20
> > > --=20
> > > 2.13.2
> > >=20
>=20
>=20



--cjmzp27fqus354zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmtFqUACgkQ2O7X88g7
+ppcqw//X6f8NVn9HpykLncVHkVTdC6OvaMCuxO5BYbl1cqaUlUia/RPV0oN9uGD
GyA5WzQKhD/kFiIAjZnCz05J4cE3ygkY3dSaXE6UtyFDlWmn1+PIRo0+N3KL6f2a
AM9rArP4OA88+HrxYjj+bBmIvGFYz598Rrdr25q2pFJNzdNwXwAI0TzCYvCj6zzJ
lscz4ls9S7/cCe4sTvQGEJCSja2W3+uHtP8t2MasKStkmbZT0dK39/ynea6X3Q6A
sVn+36pcWAFzWwSXq2PLyaQJZXFLgDwa8Wahfri+RdebvLwsHJSa5CvCayvzbmbs
uBJRWw2Md3Cr/g9w79osoMj8JhpEwhHvnyJV3pHvQM6LLmJCDtpbXOdj5y1M0rK4
E2oQLVeeH8GhrBvV3Z7gDu05zejw+EADFf3NSnRnahhfI3/rbHie2V4eFgtptSpY
Sk8C3eBhVzBrHiZ8P3EMGI8QlqzbZnBabmX7VmLaYuqHb83l4U1fonbaKPmZlQYP
3+bSO3WqeWX7qMgWvF4kYTuOWkJAOoAomEhNGEvwlW2QzuL6cp1/6buwWyzCdYJQ
5xY1l/Xjwb0p6Z/uIThhGfFcP8YooppbA5fML0XW+1NGlNzmeKJ98d059gMfJ/LG
aJGkpeyJqWzhb09K4Fal+ZYtFJ2SBYjZkc5kFf3bsix0mHBNgn8=
=i1JH
-----END PGP SIGNATURE-----

--cjmzp27fqus354zt--
