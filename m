From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: lockdep report at resume
Date: Fri, 20 Mar 2009 15:39:57 +0100
Message-ID: <1237559997.5100.159.camel@johannes.local>
References: <1234022517.4175.107.camel@johannes.local>
	 <1237536764.5100.124.camel@johannes.local>
	 <alpine.LNX.2.00.0903201535470.14346@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-sDQBNVdRw0l98v+bo5Cm"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:43265 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbZCTOkD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Mar 2009 10:40:03 -0400
In-Reply-To: <alpine.LNX.2.00.0903201535470.14346@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>


--=-sDQBNVdRw0l98v+bo5Cm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-03-20 at 15:37 +0100, Jiri Kosina wrote:
> On Fri, 20 Mar 2009, Johannes Berg wrote:
>=20
> > > [20920.458587] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [20920.458944] [ INFO: possible circular locking dependency detected =
]
> > > [20920.459231] 2.6.29-rc3-wl-12787-g17d9115-dirty #38
> > > [20920.459449] ------------------------------------------------------=
-
> > > [20920.459736] events/0/9 is trying to acquire lock:
> > > [20920.459951]  (&dev->mutex){--..}, at: [<ffffffff804be0ac>] input_d=
isconnect_device+0x2c/0xf0
> > > [20920.460369]=20
> > > [20920.460370] but task is already holding lock:
> > > [20920.460637]  (&usbhid->reset_work){--..}, at: [<ffffffff8025a933>]=
 run_workqueue+0xb3/0x250
> > > [20920.461049]=20
> > > [20920.461050] which lock already depends on the new lock.
> > Ping? I just ran into it again on 2.6.29-rc8-wl-18593-gef1cb6f-dirty.
>=20
> I haven't still fully gone through the whole dependency chain, was quite=20
> overloaded lately, sorry.
>=20
> There is a patch from Oliver Neukum, that fixes workqueue usage semantics=
=20
> around hid_reset() on [1], could you please check whether it also fixes=20
> the report you are seeing? Thanks.

I can't seem to reproduce this completely reliably for some reason (or
it's because my own development sometimes runs into lock problems
elsewhere and lockdep disables itself), but I'll try to find a way to
reproduce it and test the patch, thanks.

johannes

--=-sDQBNVdRw0l98v+bo5Cm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJw6q6AAoJEKVg1VMiehFYblEQALTSPLXg/ZgSJn31dIrn5yRi
F8i9YuF858wb5XFqyDn66jT2BIPIrgG+KbGF9SwZVGDGf29r7lRuQILZtYItI1u+
z7zS9VQjro6KmVTAOeu315gxLyrGtJEr8lfsZizSDPtfnLMy6DriKbHuvOjFUKkG
6tfsROR63fzsnUe1rJcuO3FMlLK+8/wQdyJkm+JBryFM9cXU4KIlZ/2LZLPwq6Xq
lFaQOFEsRHuUokcdzNRTDE08yHghS5PUeNn95Nz1TMV5NzQZAD2eaRZ7yk+S3Nq0
Cvs/N645eT9QPoVhvy6Nuc6kjiPIeySawjPh39ZQm0anedF7zgUGn6FV75Suob0/
oLd8wiJadvW8QBFJS22U3jOR0A7GyBwSeh8TLzP38uyPYcncLNCadQts6uzAcAQ4
uOhr47EqKgP+lf36VE58cbBLlt6GXolS3AbzoGYKg2MrUsv4FEcdEvrWhsRfBhKC
XZWam6JuFcY4Gu7YyLm1tmjKUz6lKfKS3O644vOKbuHFS1DS/zRS25Gk3G2ethAg
pHVnr7aicRWl2L9RK428mWBnYQaeHBdGBsG4EkWIZznA/Ly07VEuEg3rUpfVx61u
/QXHbLg0tQApLVPClpUNAhSwasQlJ5po4Sd17zivwS8kqvhZL31ItsGlWQjbekbQ
vFgnkWtAike1/YuvBX3R
=jlvk
-----END PGP SIGNATURE-----

--=-sDQBNVdRw0l98v+bo5Cm--

