From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 06/24] input/keyboard: fix dangling pointers
Date: Sun, 21 Mar 2010 02:59:26 +0100
Message-ID: <20100321015925.GA26625@pengutronix.de>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de> <1269094385-16114-7-git-send-email-w.sang@pengutronix.de> <20100320192007.GA28402@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100320192007.GA28402-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dmitry,

On Sat, Mar 20, 2010 at 12:20:07PM -0700, Dmitry Torokhov wrote:
> Hi Wolfram,
>=20
> On Sat, Mar 20, 2010 at 03:12:47PM +0100, Wolfram Sang wrote:
> > Fix I2C-drivers which missed setting clientdata to NULL before freeing =
the
> > structure it points to. Also fix drivers which do this _after_ the stru=
cture
> > was freed already.
> >=20
>=20
> I am not sure if setting clientdata to NULL before freeing the data is
> that important; we really want to be sure that we don't leave clientdata
> dangling when we finish unbinding the driver. If there are another
> thread the change will not really help the problem of accessing
> non-existing client data.

I agree it won't matter in practice. Jean and I concluded it is better
style, though (http://comments.gmane.org/gmane.linux.drivers.i2c/5392).
Still, I will not insist and leave it up the subsystem maintainers, of
course. I also won't check for that case again in the future.

> I will apply lm8323 portion of the patch but leave qt2160 as is.

Thanks!

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkulfX0ACgkQD27XaX1/VRtgIwCeP3ARt+wII1Xeva9Lnytebcsr
IQcAnApsmX1e9BfUoF/0kyJ4U7XWnSgu
=lIAk
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
