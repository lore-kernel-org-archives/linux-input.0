From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/7] i2c: i2c-cros-ec-tunnel: Set retries to 3
Date: Fri, 1 Aug 2014 19:59:12 +0200
Message-ID: <20140801175912.GF3277@katana>
References: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk>
 <1406549967-21291-3-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406549967-21291-3-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2014 at 02:19:22PM +0200, Javier Martinez Canillas wrote:
> From: Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>=20
> Since the i2c bus can get wedged on the EC sometimes, set the number of r=
etries
> to 3. Since we un-wedge the bus immediately after the wedge happens, this=
 is the
> correct fix since only one transfer will fail.
>=20
> Signed-off-by: Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses=
/i2c-cros-ec-tunnel.c
> index 05e033c..a4411da 100644
> --- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> +++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> @@ -16,6 +16,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> =20
> +#define I2C_MAX_RETRIES 3

I think a define for this is overkill, yet I don't really mind.

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

I assume this goes via MFD, let me know if I should take it.

> +
>  /**
>   * struct ec_i2c_device - Driver data for I2C tunnel
>   *
> @@ -290,6 +292,7 @@ static int ec_i2c_probe(struct platform_device *pdev)
>  	bus->adap.algo_data =3D bus;
>  	bus->adap.dev.parent =3D &pdev->dev;
>  	bus->adap.dev.of_node =3D np;
> +	bus->adap.retries =3D I2C_MAX_RETRIES;
> =20
>  	err =3D i2c_add_adapter(&bus->adap);
>  	if (err) {
> --=20
> 2.0.0.rc2
>=20

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT29VvAAoJEBQN5MwUoCm2vBIQAJllHNEd9tmJcxKv5yOZGsaj
UQANTLa+q/BKlKxEw/YbCuNFXleCIG7LLrwoFE8IA/Ag1bP+WdRG9TaYKaRA6Pcy
HqbtgssnUrjXLRKObfx7iR4nzHCekRXgcduCaLh/x8UV8ol3wAKEszAE4tGLB5m6
2CCMKfOqP8TgMs8gkrkyTw1i6fUO65z3YOk7bnwEfunQkxvhRBcVC6dpOupf8oBJ
DtoQy8Q2r7YCFZho7HZjOlIjmL6FuVbkrXA5UQRYOqLf+CLZ6ed2Kv/bvaCpJ3dM
Chkhyo6NO8hK0sQI8tN851t2XM7WCNYWXZBsE5gp7HtycOUsEEHvkGpbbfl426u2
EEa/0iZzDxayJo/HGl1A5RNs8q8GQo1h+dSZIUV3PtJvgGAjjm+sQk1o/Z0myt+w
e8712MLP1eVH//v5Eplb2HpNiwvwdBh7AF58mLc1OpNPuJOBHE97pi232ceC47dx
JJctZ79BuNXEwW8P75sX2LXNdvM0YD5AXfbAwlVtzhLij5GkOJOMQPM1gD2JTRsY
4O/Ha91HPq9OSrW0VOyvhm0HWurJGycdId5acYGM0suzJR6Dq4N30wQbJjs80Oeg
ilzeSPaGPcvzCM7eW8yv+eH4TvFIDOb13qX+/DvKeifslyfrjaDwj6e4lHPNGteD
fu0MCXlWzSrL6asjnp0z
=7BBX
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--
