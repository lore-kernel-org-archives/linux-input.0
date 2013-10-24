From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Input: add regulator haptic driver
Date: Thu, 24 Oct 2013 14:38:36 +0100
Message-ID: <20131024133836.GG18506@sirena.org.uk>
References: <000101cec628$aaff69a0$00fe3ce0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000101cec628$aaff69a0$00fe3ce0$%kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "hyunhee.kim" <hyunhee.kim@samsung.com>
Cc: dmitry.torokhov@gmail.com, peter.ujfalusi@ti.com, wfp5p@virginia.edu, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2013 at 11:22:00AM +0900, hyunhee.kim wrote:

> +	if (enable && !haptic->enabled) {
> +		haptic->enabled =3D true;
> +		ret =3D regulator_enable(haptic->regulator);
> +		if (ret)
> +			pr_err("haptic: %s failed to enable regulator\n",
> +				__func__);

These should probably set the flag after the regulator API call has
succeeded, otherwise if the call fails the driver will incorrectly
remember that the regulator is enabled and never disable it (or vice
versa on disable).=20

> +static void regulator_haptic_work(struct work_struct *work)
> +{
> +	struct regulator_haptic *haptic =3D container_of(work,
> +						       struct
> regulator_haptic,
> +						       work);
> +	if (haptic->level)
> +		regulator_haptic_enable(haptic, true);
> +	else
> +		regulator_haptic_enable(haptic, false);
> +
> +}

Should the mutex for the level be at this level rather than in the
subfunctions?  Though it'd probably be just as well to inline the true
and false cases since there's basically two equivalent forks in the
enable function anyway.

> +
> +	haptic =3D kzalloc(sizeof(*haptic), GFP_KERNEL);
> +	if (!haptic) {
> +		dev_err(&pdev->dev, "unable to allocate memory for
> haptic\n");
> +		return -ENOMEM;
> +	}

Might be better to use devm_ functions throughout here, saves error
handling and cleanup code...

> +static int regulator_haptic_remove(struct platform_device *pdev)
> +{
> +	struct regulator_haptic *haptic =3D platform_get_drvdata(pdev);
> +
> +	input_unregister_device(haptic->input_dev);
> +
> +	return 0;

=2E..which is currently missing.

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaSLYAAoJELSic+t+oim9KpkP/0S7MuEPo4tPqBgiS9VfWbiO
gc7h6Xjoal1h8Jef2IUJLjfgzyY5YapqWRL+ajybrfJmbuCM9C8zQiQ3+W8Lyhjl
BtHA4C1mcGub2OEuhy/6Oe3166kiPoufOpNQz9lIuGsAURpKzg8+R98YeLfy0yw5
j3bPqL/wuW5bJXzS7kQx0bDY3QWVke3UINxX0GSjPkT3ZQnge3goGxS2M3MajB/c
lQIA2WBoR5B8Y9ilrFSCYxgSo9gwFXmq7V0dCj70jqhe6Lrth2doveY1aVLeGnZD
kbaLq/2cOZb+mdOdo2gQ/Poi/w6gvBLiJFT4JfIQ09Etz0iGzXUyT6OI8NVASRiR
5Nv9xEd8O0k7w/BB8PjV8gV2+yCS6Zh/NijkOucM5BTqpD0U1h9UODu/tECPJ82R
NoO+rNXLtI2miTg0KbB+Ypj3GBqQxofRaE2JBUl8e90GsOzQSRS1iJfs6XmTSV9e
znTWjRw7pec0FXueFEUsM5gosM3uxItKU4PEq7Von2Q4oRFlk/ur/A3JULIQgbuI
KgdwF7cSLzZAkTybxGE1rBxPpEDS0wViZyDMqF1HbJfPAkOqMCsPldap4f3T9PNO
nyirCtfHpCzxsCdCIC3lDOTZFgY05tj+HsnPBiONNW6cmWc1Gwep9E0PVU28I8OW
3JeMAB/jFCp5beKuapar
=u9oq
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--
