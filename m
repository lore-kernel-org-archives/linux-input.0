From: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: [PATCH 1/3 V2] mfd: add STMPE811 core support
Date: Mon, 14 Jun 2010 14:04:10 +0200
Message-ID: <20100614120410.GA12027@pengutronix.de>
References: <1276251195-22981-1-git-send-email-l.fu@pengutronix.de> <1276511558-27121-2-git-send-email-l.fu@pengutronix.de> <20100614115032.GA14604@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59028 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab0FNMEQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jun 2010 08:04:16 -0400
Content-Disposition: inline
In-Reply-To: <20100614115032.GA14604@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Luotao Fu <l.fu@pengutronix.de>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

thanks for the review.

On Mon, Jun 14, 2010 at 12:50:32PM +0100, Mark Brown wrote:
> On Mon, Jun 14, 2010 at 12:32:36PM +0200, Luotao Fu wrote:
>=20
> > +static void stmpe811_mask_work(struct work_struct *work)
> > +{
> > +	struct stmpe811 *stm =3D container_of(work, struct stmpe811, mask_wor=
k);
> > +
> > +	stmpe811_reg_write(stm, STMPE811_REG_INT_EN, stm->int_en_mask);
> > +
> > +	mutex_unlock(&stm->irq_mask_lock);
> > +}
>=20
> Why are you doing this in a workqueue?  You shouldn't need to do this -
> you should implement the bus_lock() and bus_unlock() callbacks instead.

Right, will replace the stuff with bus_lock/unlock

>=20
> > +	ret =3D request_threaded_irq(client->irq, NULL, stmpe811_irq,
> > +				   pdata->irq_flags, "stmpe811", stm);
> > +	if (ret) {
> > +		dev_err(&client->dev, "failed to request IRQ: %d\n", ret);
> > +		goto err_free;
> > +	}
>=20
> I suspect you should be unconditionally putting IRQF_ONESHOT here since
> the threaded IRQ requires it.

oh, oversaw this one, will fix.

Thanks

regards
Luotao Fu

--=20
Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwWGroACgkQkLuxfMCkDTbz3QCdGZktlVcmOj7OYeYCzZo+xULK
rC4An0OhFk3t2VryWu01+8H0beSlsSRO
=+u+O
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
