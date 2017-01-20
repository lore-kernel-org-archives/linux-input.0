From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 5/7] Input: pwm-beeper - suppress error message on
 probe defer
Date: Fri, 20 Jan 2017 11:16:21 +0100
Message-ID: <20170120101621.GE3824@ulmo.ba.sec>
References: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
 <20170119224057.9995-5-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35260 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbdATKQZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Jan 2017 05:16:25 -0500
Content-Disposition: inline
In-Reply-To: <20170119224057.9995-5-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, David Lechner <david@lechnology.com>, linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@exceet.de>


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 02:40:55PM -0800, Dmitry Torokhov wrote:
> From: David Lechner <david@lechnology.com>
>=20
> This suppress printing an error message when pwm_get returns -EPROBE_DEFE=
R.
> Otherwise you get a bunch of noise in the kernel log.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>
> Patchwork-Id: 9499915
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/misc/pwm-beeper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-bee=
per.c
> index 04c8ad3827d9..9964c46468d3 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
> @@ -108,7 +108,8 @@ static int pwm_beeper_probe(struct platform_device *p=
dev)
>  	beeper->pwm =3D devm_pwm_get(dev, NULL);
>  	if (IS_ERR(beeper->pwm)) {
>  		error =3D PTR_ERR(beeper->pwm);
> -		dev_err(dev, "Failed to request pwm device: %d\n", error);
> +		if (error !=3D -EPROBE_DEFER)
> +			dev_err(dev, "Failed to request pwm device\n");

This also drops the error code from the message. I suspect that this was
intentional because failure to probe will print out the error code
anyway. Might be worth mentioning that in the commit message?

Either way:

Reviewed-by: Thierry Reding <thierry.reding@gmail.com>

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliB43UACgkQ3SOs138+
s6FdPA//a6Kql4h2zKNOsJB08C8T9crafCSR8xm3RKQgmt9Zj1bthSmVWgW+Sia4
OxrobsGtsV1pCda3PSO6o+3UxnVMQz1ZUU9euhx/VwXgTwQSR54A3jxELQfF5PU0
kacPvS5onGPg9PBL89dClT+88jEXrSNC4rPZ42tCWx8ly7l9jCMbonLnbnCISG2k
wqT7eJz5YN4d/h3qFyzdeVWuxan7JG5Vaw3GsfSHmYmupL1YzlU6IaUbr14kF7uh
9IGXxosUxP0qb2sG/PfwQf3vJa3nAhL9ZDgu/nl45JHJAWL1M/LC+GV8EBs3uaxm
IpuiCeL8vZOK2l2pVzfBt/MA169Sem9w2rp/62kp4fKbGVZyWZfrl6UThHf/4TLc
wWwp4eTa16fw8OGEg9EH2m8IWd3+4q/lo3CcsPFMcl5dirxWdKckZD7LBG+5OxxN
stHbxVGyS6yMvBVOooDX/E43cRIzIqEqunLPOXkPwW5X3dkVj9sElA+vVhXGAzkX
uy82K9V9hZz9k0BG/UBHmoHZLnL0Qk0ujOcjlbzd5EmTX9t6Qnpk4bv5as+aWjcF
Ek9LcYc+E3ECu/yjBZw0fAAy8XK8+IdrC22II/7UxWI+mVE9Y7PsW8PqU+lIIB34
rDR5PwqZEh6CW7XTsxdp9kDRrZknJZfYe3mNvzfLtwEsgnUMCDs=
=9T44
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
