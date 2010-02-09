From: Mark Somerville <mark@scottishclimbs.com>
Subject: Re: [PATCH] input/misc: rotary-encoder: Set gpio direction
Date: Tue, 9 Feb 2010 00:39:05 +0000
Message-ID: <20100209003903.GA1009@pentlands.xeriom.net>
References: <20100208210350.36f51cbf@digital-domain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mark.vm.xeriom.net ([193.219.108.216]:60193 "EHLO
	mail.scottishclimbs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857Ab0BIAsa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 19:48:30 -0500
Content-Disposition: inline
In-Reply-To: <20100208210350.36f51cbf@digital-domain.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Clayton <andrew@digital-domain.net>
Cc: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 08, 2010 at 09:03:50PM +0000, Andrew Clayton wrote:
> While trying to get a rotary encoder working under a beagle board using=
=20
> the drivers/input/misc/rotary-encoder.c driver, we found that even with=
=20
> the right pin mux settings configured through /sys/kernel/debug/omap_mux/=
*,=20
> i.e INPUT_PULLUP and MODE4, the gpio_get_value() functions only ever=20
> returned 1.
>=20
> By explicitly calling gpio_direction_input() after each requested gpio,=
=20
> the driver started working and started returning correct input events.
>
> The following is the patch that works for us. What do you think?

Adding my Signed-off-by tag:

Signed-off-by: Mark Somerville <mark@scottishclimbs.com>

> Cheers,
> Andrew
>=20
>=20
> Set the gpio direction to input for each requested gpio.
>=20
> Even with the correct pin mux settings, you still need to explicitly=20
> set the gpio direction. Call gpio_direction_input() after each=20
> requested gpio.
>=20
> Signed-off-by: Andrew Clayton <andrew@digital-domain.net>
> ---
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rot=
ary_encoder.c
> index 3b9f588..4ae0793 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -152,6 +152,13 @@ static int __devinit rotary_encoder_probe(struct pla=
tform_device *pdev)
>  		goto exit_unregister_input;
>  	}
> =20
> +	err =3D gpio_direction_input(pdata->gpio_a);
> +	if (err) {
> +		dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
> +			pdata->gpio_a);
> +		goto exit_unregister_input;
> +	}
> +
>  	err =3D gpio_request(pdata->gpio_b, DRV_NAME);
>  	if (err) {
>  		dev_err(&pdev->dev, "unable to request GPIO %d\n",
> @@ -159,6 +166,13 @@ static int __devinit rotary_encoder_probe(struct pla=
tform_device *pdev)
>  		goto exit_free_gpio_a;
>  	}
> =20
> +	err =3D gpio_direction_input(pdata->gpio_b);
> +	if (err) {
> +		dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
> +			pdata->gpio_b);
> +		goto exit_free_gpio_a;
> +	}
> +
>  	/* request the IRQs */
>  	err =3D request_irq(encoder->irq_a, &rotary_encoder_irq,
>  			  IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAktwrqYACgkQFC+QcFj+6g15swCaAjugle/TIANBEz9TigsfBur1
l20AnjyRWHuzaADKJqw8bsb56iBGzYpA
=M0rX
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
