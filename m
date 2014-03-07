From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 6/7] regulator: AXP20x: Add support for
 regulators subsystem
Date: Fri, 7 Mar 2014 19:22:13 +0100
Message-ID: <20140307182213.GC607@lukather>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-7-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fgeUT96Xdo+SN8mm"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB7U55CMAKGQEFHRI5FQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393692352-10839-7-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org


--fgeUT96Xdo+SN8mm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 01, 2014 at 05:45:51PM +0100, Carlo Caione wrote:
> +static struct platform_driver axp20x_regulator_driver =3D {
> +	.probe	=3D axp20x_regulator_probe,
> +	.remove	=3D axp20x_regulator_remove,
> +	.driver	=3D {
> +		.name		=3D "axp20x-regulator",
> +		.owner		=3D THIS_MODULE,
> +	},
> +};
> +
> +static int __init axp20x_regulator_init(void)
> +{
> +	return platform_driver_register(&axp20x_regulator_driver);
> +}
> +
> +subsys_initcall(axp20x_regulator_init);

Hmmm, really?

I thought the AXP was only connected through I2C? How is that a
platform device then?

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--fgeUT96Xdo+SN8mm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTGg5UAAoJEBx+YmzsjxAg4Q0QAK03UjUsT5aGKp3zLpgh2a5C
rCc9hZiaSRe/PIQjmMlMNTWXOb8A2zGYjLhdOr16TO9skfJAWjkZFAQhqMy68UAB
k82FY0rfAsu8qp2CnzrfTnyrt3kCDnyGYEtUUn+KeytEY52ODZyNM9rVmca1iD0a
mtvpizRY9KryZtRONMBXRqjznFZg/XeeGz2P/qFubETBK0yOuuiWiipDcxLg6DCH
WrmzohPoqEiXPh0Z3LMXnHIIMYqsBoEyYuiyM4iWHCdzXTNaqdgvpf4GllCPGoyg
2ysY4wv54kNC2LNMR6IkqgKUOOgrwlhBKBJoMa+5ddHOylqoZoHZLv5lTSXXr7/6
riqXlfKaa/QvTKJ2T8iWifQ7UBjXxDonN50yAbR+h4kkkCpLNAs2sR0fHU23d/DF
B5Ue51E8sgsOeUgLQXbkg5dVKn4xzt3L90kasewDw4JMDYsHyh67LuBHE7dplxQQ
sWduCl0UdvkKxrkphmpjD05QJVZdSQYbatEk8dS0knJPxp7eOnZ12rR/HHyChn/Q
ysKD4JzMqLI0K/DxUQPt7ErnHXs9ZOZG3AB9Zg27GrPMYjlI1qs/TJpfdZT1jYIO
uSAb8Zt6x21d59y2YddVKwT9aQyutHORFbNnpYYOqFR205w3Vq/bxq1zRk0T3t2d
G0eMpoyuobezTzgpGLD5
=3/gW
-----END PGP SIGNATURE-----

--fgeUT96Xdo+SN8mm--
