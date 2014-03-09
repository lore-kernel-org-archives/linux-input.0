From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/7] mfd: AXP20x: Add mfd driver for AXP20x PMIC
Date: Sun, 9 Mar 2014 10:11:44 +0100
Message-ID: <20140309091144.GB3335@lukather>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-2-git-send-email-carlo@caione.org>
 <20140307180936.GY607@lukather>
 <20140308113141.GA14009@localhost.fastwebnet.it>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBF7C6CMAKGQERYFUSDQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140308113141.GA14009-bi+AKbBUZKZeIdyRz4JgOMwOAu8XWILU@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Sat, Mar 08, 2014 at 12:31:41PM +0100, Carlo Caione wrote:
> > > +	axp20x->pm_off =3D of_property_read_bool(node, "axp,system-power-co=
ntroller");
> > > +
> > > +	if (axp20x->pm_off && !pm_power_off) {
> > > +		axp20x_pm_power_off =3D axp20x;
> > > +		pm_power_off =3D axp20x_power_off;
> > > +	}
> >=20
> > I don't think we have any other way to actually power down the board.
> >=20
> > Is there any reason why we would not need this property?
>=20
> In case you have multiple PMIC on the board in this way you con define
> which is the one apt to power off.

Do we even have such a board?

Let's leave this out, we can always add it later if needs be.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTHDBQAAoJEBx+YmzsjxAg9B0P/1j3QcvmqrQgRsjC85S9kKgO
a9tO1XGghla6nIvvpcQVqhNMSjvwyEs/qG8dw3NMipcHJfQvbU3s3phvLscvC6eF
6OSJKKJV7EI3KgWmKHvkjO4/OY/MICPjZvsRYxkIIW3p5eWpnPFJEYfXwXF3cCE9
RUiYjwsz0hxePt/M2WXOVrhR1COR/awE6EssBsCrwwcS/xwS1qggjoisqMJ0gCJR
Pg7Vzq8pstEoIFlwjD3FVZICKBya17+6f5KUOk8eiKirQwTD3uc/16DQ8zS6AkG9
m37XseUmJgXZ8xQ2ucC4Nr9vC1HBgcyEehVobq+ogAIUOfG3flA0HyFLiQOZ6D8x
w0cDHK17j6vh2DKy1fimoMpDkZWkMePUMmzxNrrn+qqnoup/WGkXKae/QQEWN1tQ
NRRVBalgQYphOgNN0ysAu8pjVZEi6Sg9ZR+/5uQkWjcx5sU6t3rWTWD94e7MIorO
GBUIfWM34uTsezHG53jMWc3aePLivo7jgw7CeidmT4L2pkDmXJHLs3elC0i6dBoU
uIDJNHDOlCb8B2qIvu08C6d902V71l/8zAL/oH+9Mcc/CxLVqpDTeG0F8R7ljuqT
HykaDEFwZg2yjHw3SZ1W3e6J609aq3lCdVzl4XeQwHpiEr+vi8ej0KlEu+bicK8/
qghfREbrDY91wOWpmzHa
=Dqzz
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
