From: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: [PATCH 3/3] input: STMPE811 touch controller support
Date: Fri, 11 Jun 2010 13:45:28 +0200
Message-ID: <20100611114527.GC4078@pengutronix.de>
References: <1276251195-22981-1-git-send-email-l.fu@pengutronix.de>
 <1276251195-22981-4-git-send-email-l.fu@pengutronix.de>
 <20100611112102.GE12436@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51483 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab0FKLpa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jun 2010 07:45:30 -0400
Content-Disposition: inline
In-Reply-To: <20100611112102.GE12436@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Luotao Fu <l.fu@pengutronix.de>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 11, 2010 at 12:21:02PM +0100, Mark Brown wrote:
> On Fri, Jun 11, 2010 at 12:13:15PM +0200, Luotao Fu wrote:
>=20
> > +/*
> > + * reference source:
> > + *
> > + * Set ref_sel =3D 0 for internal reference
> > + *     ref_sel =3D 1 for external reference
> > + */
> > +static int ref_sel;
> > +module_param(ref_sel, int, 0444);
> > +MODULE_PARM_DESC(ref_sel,
> > +	"Set ADC reference source. Default is 0 (internal reference)");
>=20
> This looks like something that ought to be configured via platform data
> since the value that should be used is going to be determined by the
> board schematic.  Similar comments apply to most of the other module
> parameters, though in some cases sysfs files might be more appropriate
> as well, or in addition.

OK. These stuffs are indeed platform dependent. I'll create a platform
data for it than.

Thanks
Luotao Fu
--=20
Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwSIdcACgkQkLuxfMCkDTZHzwCeIHO03VV1vYIEHQPbP89A89kK
vFUAn3q2Jdw+rW1sUP76h8q7L6u3s6c4
=M0O+
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
