From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/3] Input: tsc2004/5 - fix regulator handling
Date: Sat, 11 Feb 2017 18:02:48 +0100
Message-ID: <20170211170248.yhgp7b46nxkkh7ch@earth>
References: <20170211000623.33663-1-dmitry.torokhov@gmail.com>
 <20170211000623.33663-2-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="43ynek7z6el674ol"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750867AbdBKRC4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 11 Feb 2017 12:02:56 -0500
Content-Disposition: inline
In-Reply-To: <20170211000623.33663-2-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Michael Welling <mwelling@ieee.org>, linux-kernel@vger.kernel.org


--43ynek7z6el674ol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Fri, Feb 10, 2017 at 04:06:22PM -0800, Dmitry Torokhov wrote:
> In case of an optional regulator missing regulator core will return
> ERR_PTR(-ENOENT) and not NULL, so the check for missing regulator is
> incorrect. Also, the regulator is not optional, it may simply be missing
> from platform decsription, so let's use devm_regulator_get() and rely on
> regulator core to give us dummy supply when real one is not available.
>
> Fixes: d257f2980feb ("Input: tsc2005 - convert to gpiod")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-By: Sebastian Reichel <sre@kernel.org>

> ---
>=20
> Sebastian, I am wondering, what regulator this is.

On N900 the same regultor is connected to I/OVDD & SNSVDD.

> If it is IO VDD, then I think we activate it too late (i.e. we are
> truing to shut off the controller before we turn the regulator on.

Yes, it should be moved.

> If it is sensor VDD, then we probably need to mention it, and also
> add IO VVD supply as well.

-- Sebastian

>=20
>  drivers/input/touchscreen/tsc200x-core.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/tou=
chscreen/tsc200x-core.c
> index b7059ed8872e..1c14a38e3748 100644
> --- a/drivers/input/touchscreen/tsc200x-core.c
> +++ b/drivers/input/touchscreen/tsc200x-core.c
> @@ -527,10 +527,10 @@ int tsc200x_probe(struct device *dev, int irq, cons=
t struct input_id *tsc_id,
>  		return error;
>  	}
> =20
> -	ts->vio =3D devm_regulator_get_optional(dev, "vio");
> +	ts->vio =3D devm_regulator_get(dev, "vio");
>  	if (IS_ERR(ts->vio)) {
>  		error =3D PTR_ERR(ts->vio);
> -		dev_err(dev, "vio regulator missing (%d)", error);
> +		dev_err(dev, "error acquiring vio regulator: %d", error);
>  		return error;
>  	}
> =20
> @@ -587,12 +587,9 @@ int tsc200x_probe(struct device *dev, int irq, const=
 struct input_id *tsc_id,
>  		return error;
>  	}
> =20
> -	/* enable regulator for DT */
> -	if (ts->vio) {
> -		error =3D regulator_enable(ts->vio);
> -		if (error)
> -			return error;
> -	}
> +	error =3D regulator_enable(ts->vio);
> +	if (error)
> +		return error;
> =20
>  	dev_set_drvdata(dev, ts);
>  	error =3D sysfs_create_group(&dev->kobj, &tsc200x_attr_group);
> @@ -615,8 +612,7 @@ int tsc200x_probe(struct device *dev, int irq, const =
struct input_id *tsc_id,
>  err_remove_sysfs:
>  	sysfs_remove_group(&dev->kobj, &tsc200x_attr_group);
>  disable_regulator:
> -	if (ts->vio)
> -		regulator_disable(ts->vio);
> +	regulator_disable(ts->vio);
>  	return error;
>  }
>  EXPORT_SYMBOL_GPL(tsc200x_probe);
> @@ -627,8 +623,7 @@ int tsc200x_remove(struct device *dev)
> =20
>  	sysfs_remove_group(&dev->kobj, &tsc200x_attr_group);
> =20
> -	if (ts->vio)
> -		regulator_disable(ts->vio);
> +	regulator_disable(ts->vio);
> =20
>  	return 0;
>  }
> --=20
> 2.11.0.483.g087da7b7c-goog
>=20

--43ynek7z6el674ol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlifQ7UACgkQ2O7X88g7
+pqC6hAAjmrdS/rRFsyDzW9qEmpFLmuKNCZEypKze2EWllF93YBjffVcRfgE9t5e
GX+EFLhcNFR7sySLbD8x/Yavmq+Xs2VEhAPpR2O9T+Q5Tx/oNklMwOPz79hiuNfN
sLsCQfeoIVb1OAOtZjhxgDWJGMctrt8+0FCHhARZ4kC9CU/6IKBZoMcGqVTGMUMf
kH1x0XRMlD9XPSNdE3H0QML6SMcG5ZomZc4uPgjtVVqsdKyVMJftyHv/7AB4Sz5c
5fIoQx7XkmfTvBMkL8anP3WBW93Fh7HtfHxhz4MDI3ILv3iNSjjqyGOOfk8NWvS0
OVk0/VKL/sJIrMnxHVGtVndAzd/f6sWOCztTKeJ53b2HMLVAiYEzQ5WjyM3DoGQs
YObSeLZsrhfESWjZwXqfgbl1IrhNcTjBpkjbHfJgETjxecKmQuuQkvN/R4BwLJny
WXK9RZWwteBHvbmAJ8GfgGJfh239SPp6hDa9svuRB53laWz0JTcKKlKoRZxQaS8x
VScaieMCtFkNMCAx6u9leo02oF5n7PsKRAuvHKCHl7RVvzKHPuJrajmXvTvtDko4
psnwRBjOuY6YehWp1Aiw1hcMm733+fq7cK2JZ+0HJin38BSTMNaLzr4oYmJf3iXM
UuiCiex9yzFP0mi2G4U3Cxb+Yk2IXlmr4ZNaTouCvWiU+r6F7v4=
=biqY
-----END PGP SIGNATURE-----

--43ynek7z6el674ol--
