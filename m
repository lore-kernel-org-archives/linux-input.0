From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] Input: tsc2004/5 - do not use irq_set_irq_wake() directly
Date: Mon, 13 Feb 2017 07:17:54 +0100
Message-ID: <20170213061754.dui6iwto2rqkiejt@earth>
References: <20170212234333.GA25725@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hroqe2puzaoxhd5g"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751463AbdBMGSA (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Feb 2017 01:18:00 -0500
Content-Disposition: inline
In-Reply-To: <20170212234333.GA25725@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Michael Welling <mwelling@ieee.org>, linux-kernel@vger.kernel.org


--hroqe2puzaoxhd5g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 12, 2017 at 03:43:33PM -0800, Dmitry Torokhov wrote:
> Instead of setting irq_set_irq_wake() directly in probe(), mark the device
> as wakeup-capable, and use enable_irq_wake() and disable_irq_wake() in
> suspend/resume path.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-By: Sebastian Reichel <sre@kernel.org>

I suggest to add a paragraph in the patch description, why the
change was done. E.g.:

This adds support for changing the wakeup setting dynamically at
runtime using /sys/devices/.../tsc2005/power/wakeup.

Also I wonder if the default should be 'off' (by using
device_set_wakeup_capable() instead of device_init_wakeup()

-- Sebastian

>  drivers/input/touchscreen/tsc200x-core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/tou=
chscreen/tsc200x-core.c
> index 88ea5e1b72ae..d1c40c803d61 100644
> --- a/drivers/input/touchscreen/tsc200x-core.c
> +++ b/drivers/input/touchscreen/tsc200x-core.c
> @@ -114,7 +114,9 @@ struct tsc200x {
> =20
>  	struct gpio_desc	*reset_gpio;
>  	int			(*tsc200x_cmd)(struct device *dev, u8 cmd);
> +
>  	int			irq;
> +	bool			wake_irq_enabled;
>  };
> =20
>  static void tsc200x_update_pen_state(struct tsc200x *ts,
> @@ -573,7 +575,8 @@ int tsc200x_probe(struct device *dev, int irq, const =
struct input_id *tsc_id,
>  		goto err_remove_sysfs;
>  	}
> =20
> -	irq_set_irq_wake(irq, 1);
> +	device_init_wakeup(dev, true);
> +
>  	return 0;
> =20
>  err_remove_sysfs:
> @@ -607,6 +610,9 @@ static int __maybe_unused tsc200x_suspend(struct devi=
ce *dev)
> =20
>  	ts->suspended =3D true;
> =20
> +	if (device_may_wakeup(dev))
> +		ts->wake_irq_enabled =3D enable_irq_wake(ts->irq) =3D=3D 0;
> +
>  	mutex_unlock(&ts->mutex);
> =20
>  	return 0;
> @@ -618,6 +624,11 @@ static int __maybe_unused tsc200x_resume(struct devi=
ce *dev)
> =20
>  	mutex_lock(&ts->mutex);
> =20
> +	if (ts->wake_irq_enabled) {
> +		disable_irq_wake(ts->irq);
> +		ts->wake_irq_enabled =3D false;
> +	}
> +
>  	if (ts->suspended && ts->opened)
>  		__tsc200x_enable(ts);
> =20
> --=20
> 2.11.0.483.g087da7b7c-goog
>=20
>=20
> --=20
> Dmitry

--hroqe2puzaoxhd5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlihT5AACgkQ2O7X88g7
+poJOg//b2QYYOsNMkYTnW++Tbo/Bb2VTkCSpyNmTMa8CsDyARMealLIjfnZu8YR
Q9cnCSxmZ2nCycyKv0daccoqGwyWYOTXzNsXI4dGuV0sKkMy6rEHh4eKXXtia90E
31FTdb26S4+JglG/dShzuZVbgOUxR4S0b6oFvqiyU07a6sjdv9n7xxCD8vOkk4Fr
NlXoZ2z9cLGl4RWOJmSoLvXWl9P2z9IIkOCdA2xKDhyumoisBTZI2x9C18VCrp4G
LxFd8xMyrw6WirrCFh5h4oxWjuNruo+4eDWoZ+lJg1/XYq1pNQJsHjyxtnm8vU71
xeUKUO7P0fhHPN8eC9v932IsSwGXrGIJIIDbfPU4960DbvjDgFbSk+25hm2MMMIp
WXYh2arbbUm5Ete4x6bA7FVMB1jiQpjAXZSme0bpUVOnqLI/66iBIcFGCesZSk+g
0yi34m35xdITCq+ifTzkdVDOV5Qoj866gp+izjrB65UomfdnvUTemyJM/H82ipnX
B3KQZ+meCZiz0nnBSk72o9v+uXRrsX2NYikamaoF52FDfucGDL0gG+RzqEypb+Cu
+nXAXPax9P+EoMhE82Mwf3o3OhUehqN08a0lXUgxgU+mH9dyR2a2bMFEzNKZXN4f
qjuk/zCZPLwx5ipB76EWrRsd4Pq5aYw0xeQLpuhHunIogA/nNCo=
=ed+n
-----END PGP SIGNATURE-----

--hroqe2puzaoxhd5g--
