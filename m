From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 1/2] DT: i2c: Deprecate adi,adxl34x compatible string
Date: Thu, 15 Jan 2015 18:02:09 +0100
Message-ID: <20150115170209.GA6342@katana>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1421333655-31029-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421333655-31029-2-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2015 at 04:54:14PM +0200, Laurent Pinchart wrote:
> DT nodes should use the more specific adi,adxl345 and adi,adxl346
> compatible values instead. As the ADXL346 is backward-compatible with
> the ADXL345, ADXL346 nodes must list both adi,adxl346 and adi,adxl345,
> in that order.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnhk3lzF8UVTdg@public.gmane.org=
m>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/=
Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index 9f41d05be3be..757e42510517 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -18,8 +18,7 @@ adi,adt7475		+/-1C TDM Extended Temp Range I.C
>  adi,adt7476		+/-1C TDM Extended Temp Range I.C
>  adi,adt7490		+/-1C TDM Extended Temp Range I.C
>  adi,adxl345		Three-Axis Digital Accelerometer
> -adi,adxl346		Three-Axis Digital Accelerometer
> -adi,adxl34x		Three-Axis Digital Accelerometer
> +adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility va=
lue "adi,adxl345" must be listed too)

I'd rather drop 346 because there is no compatible for that one anywhere.
No need to resend, I can fix it here...


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUt/KRAAoJEBQN5MwUoCm2PHQP/2FSpfpiXuw9KxHSyQ5fnD4t
V4JfkDuIznCH9iYGVsc89OeftjKkpujQWDhSt8xvdM+mjSwuzkzVU1nUmDZwCG83
SXzeSEwLJs7n7CCI76/XIMqcqVNemB/xL0CdMwYIz3nPkaM3E5Pgrt7yLu+NVAhv
VkInVBmsN5gR76jis+jS3tOQIvYSSrPGvVcOfB24PQJF2mHJvJG82tMtkvmR23to
pZErnEbf3sbyG2w/WdZvUxZYSFHH7jJdnfMvHaLfYgV2KMC+POeLVgZAofZLy4YT
v6zsERT2UCurSKLIEwwjo4hq2NEgIOcDR+R+gU65osd331IXp6tC1gEbNxEOpQnA
YeeJRJNnKJT6MT5r9Usw+4Tani5a+hCgo7oWAvsCs+X8XunB+MvzoIB/zwoKXRfU
5y0//kBHmSZpp6+bV+/rsxe33VfGuGZ4F7qLmN5qdiD9OxXf8/5IryHO1QtfBQt2
QGqNNFmJqRt7u7AnTCJ1cBSfRPbJxDhKw7UAY1tndu5Q5le7HVh7nPqpJzIyVk5H
k5P5569kK/DIN7PSKqVVFxsza+nHelS4DC7DX7bij8UnrXIuWPmthlO7M2jk4ro9
8HF8XlJaqbFxfADxj6YD4Ee7+gwVlzfMY8btwG3MzHTY6MlGDmhDALQZDR5xsnw7
oaSHVAIKzMqoiRpdyMEa
=3zAL
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
