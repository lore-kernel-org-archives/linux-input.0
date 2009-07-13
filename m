From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: [PATCH] input: fix EVIOCGNAME regression
Date: Mon, 13 Jul 2009 17:45:31 -0300
Message-ID: <20090713204531.GA4305@vespa.holoscopio.com>
References: <1247503151-15615-1-git-send-email-daniel@caiaq.de> <20090713165205.GA28063@dtor-d630.eng.vmware.com> <20090713171130.GH19257@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from liberdade.minaslivre.org ([72.232.18.203]:59871 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbZGMUpf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2009 16:45:35 -0400
Content-Disposition: inline
In-Reply-To: <20090713171130.GH19257@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, s.neumann@raumfeld.com


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2009 at 07:11:30PM +0200, Daniel Mack wrote:
> On Mon, Jul 13, 2009 at 09:52:05AM -0700, Dmitry Torokhov wrote:
> > On Mon, Jul 13, 2009 at 06:39:11PM +0200, Daniel Mack wrote:
> > > Commit 3d5cb60e ("Input: simplify name handling for certain input
> > > handles") introduced a regression for the EVIOCGNAME ioctl.
> > >=20
> > > Before this, patch, the platform device's name was given back to
> > > userspace which was good to identify devices. After this patch, the
> > > device was ("event%d", minor) which is not descriptive at all.
> > >=20
> > > This fixes the behaviour by taking input_dev->name.
> > >=20
> > > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > > Reported-by: Sven Neumann <s.neumann@raumfeld.com>
> > > Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> > > Cc: Dmitry Torokhov <dtor@mail.ru>
> > > ---
> > >  drivers/input/evdev.c |    6 +++---
> > >  1 files changed, 3 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> > > index 114efd8..c81e042 100644
> > > --- a/drivers/input/evdev.c
> > > +++ b/drivers/input/evdev.c
> > > @@ -608,8 +608,8 @@ static long evdev_do_ioctl(struct file *file, uns=
igned int cmd,
> > >  						    p, compat_mode);
> > > =20
> > >  			if (_IOC_NR(cmd) =3D=3D _IOC_NR(EVIOCGNAME(0)))
> > > -				return str_to_user(dev_name(&evdev->dev),
> > > -						   _IOC_SIZE(cmd), p);
> > > +				return str_to_user(evdev->handle.name,
> > > +						    _IOC_SIZE(cmd), p);
> >=20
> > No, this actually should be just dev->name, handle names were always in
> > the form of eventX or jsX. The change below is not needed either.
> > Btw, there is the similar issue in joydev.c as well.
>=20
> Ok, how about the one below?
>=20
> Daniel

My bad. Those two reverts work for me.

Tested-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

I have also reviewed my own patch and understand what I did wrong and
that I did mess with the input device name instead of keeping only to
the event device naming. Regarding what I did intend to "fix" with the
patch, it is all OK. So, if you want to, you may also consider my
review. Although after this shame, you may not consider it worth enough.
:-D

Reviewed-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

>=20
>=20
> From 0c754925117421778bd9adf1bd8f4e818fc65c74 Mon Sep 17 00:00:00 2001
> From: Daniel Mack <daniel@caiaq.de>
> Date: Mon, 13 Jul 2009 18:33:53 +0200
> Subject: [PATCH] input: fix EVIOCGNAME/JSIOCGNAME regression
>=20
> Commit 3d5cb60e ("Input: simplify name handling for certain input
> handles") introduced a regression for the EVIOCGNAME/JSIOCGNAME
> ioctl.
>=20
> Before this, patch, the platform device's name was given back to
> userspace which was good to identify devices. After this patch, the
> device is ("event%d", minor) which is not descriptive at all.
>=20
> This fixes the behaviour by taking dev->name.
>=20
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Reported-by: Sven Neumann <s.neumann@raumfeld.com>
> Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> Cc: Dmitry Torokhov <dtor@mail.ru>
> ---
>  drivers/input/evdev.c  |    3 +--
>  drivers/input/joydev.c |    7 +++----
>  2 files changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 114efd8..1148140 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -608,8 +608,7 @@ static long evdev_do_ioctl(struct file *file, unsigne=
d int cmd,
>  						    p, compat_mode);
> =20
>  			if (_IOC_NR(cmd) =3D=3D _IOC_NR(EVIOCGNAME(0)))
> -				return str_to_user(dev_name(&evdev->dev),
> -						   _IOC_SIZE(cmd), p);
> +				return str_to_user(dev->name, _IOC_SIZE(cmd), p);
> =20
>  			if (_IOC_NR(cmd) =3D=3D _IOC_NR(EVIOCGPHYS(0)))
>  				return str_to_user(dev->phys, _IOC_SIZE(cmd), p);
> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index 0e12f89..16397aa 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -536,14 +536,13 @@ static int joydev_ioctl_common(struct joydev *joyde=
v,
>  	default:
>  		if ((cmd & ~IOCSIZE_MASK) =3D=3D JSIOCGNAME(0)) {
>  			int len;
> -			const char *name =3D dev_name(&dev->dev);
> =20
> -			if (!name)
> +			if (!dev->name)
>  				return 0;
> -			len =3D strlen(name) + 1;
> +			len =3D strlen(dev->name) + 1;
>  			if (len > _IOC_SIZE(cmd))
>  				len =3D _IOC_SIZE(cmd);
> -			if (copy_to_user(argp, name, len))
> +			if (copy_to_user(argp, dev->name, len))
>  				return -EFAULT;
>  			return len;
>  		}
> --=20
> 1.6.3.1
>=20

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpbnOsACgkQyTpryRcqtS37wgCfdCkOoSGs3JcwPuBMjJUN+zTR
27cAn1x6/sbZ2cIiv40BAre1XZvxK/qU
=DU9x
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
