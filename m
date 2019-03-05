From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] Input: raspberrypi-ts: select CONFIG_INPUT_POLLDEV
Date: Tue, 05 Mar 2019 11:39:42 +0100
Message-ID: <87a8108f573e04d5c2eaaaa23be0f3a58bd45eb1.camel@suse.de>
References: <20190304195845.1096214-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-WemAnIj4qWz8ckr1MW2z"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190304195845.1096214-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Zhu Yi <yi.zhu5@cn.bosch.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--=-WemAnIj4qWz8ckr1MW2z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-03-04 at 20:57 +0100, Arnd Bergmann wrote:
> When CONFIG_INPUT_POLLDEV is disabled, we get a link error:
>=20
> drivers/input/touchscreen/raspberrypi-ts.o: In function `rpi_ts_probe':
> raspberrypi-ts.c:(.text+0xec): undefined reference to
> `devm_input_allocate_polled_device'
> raspberrypi-ts.c:(.text+0xec): relocation truncated to fit: R_AARCH64_CAL=
L26
> against undefined symbol `devm_input_allocate_polled_device'
> raspberrypi-ts.c:(.text+0x19c): undefined reference to
> `input_register_polled_device'
> raspberrypi-ts.c:(.text+0x19c): relocation truncated to fit: R_AARCH64_CA=
LL26
> against undefined symbol `input_register_polled_device'
>=20
> Select that symbol like we do from the other similar drivers.
>=20
> Fixes: 0b9f28fed3f7 ("Input: add official Raspberry Pi's touchscreen driv=
er")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/input/touchscreen/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/input/touchscreen/Kconfig
> b/drivers/input/touchscreen/Kconfig
> index 7c597a49c265..7a4884ad198b 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -699,6 +699,7 @@ config TOUCHSCREEN_EDT_FT5X06
>  config TOUCHSCREEN_RASPBERRYPI_FW
>  	tristate "Raspberry Pi's firmware base touch screen support"
>  	depends on RASPBERRYPI_FIRMWARE || (RASPBERRYPI_FIRMWARE=3Dn &&
> COMPILE_TEST)
> +	select INPUT_POLLDEV
>  	help
>  	  Say Y here if you have the official Raspberry Pi 7 inch screen on
>  	  your system.

Thanks!
Looks good to me.

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>


--=-WemAnIj4qWz8ckr1MW2z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlx+Ue8ACgkQlfZmHno8
x/59Twf/TLxpOWUqV46ZAxxiS1B7mQB+GB+MVuiQFreCAeHEmm8/nq6emJcSb6TB
INpToHGrCFKAE/PClzcXomD7X+ziKzYPr5hsFiylAuPlMgr/ybeJQ9p2grAJfwx4
rppOupjRECwh6ADtItswvfj934ewVtX18vjcdXZqt2RBUxajmpl4P/9Dw2EdZ18M
LDn+ldiXINJcryqLR4+Gx3eLJ+wJMzR1g+ZBbFnbOnvFeZ2+SLbluJTqcK5WjXPh
EYWqU15bn0DYepISJigF75lsODRdmKIRDYmyrzkERBs1rb+0tuAZLmoR6znzx8vV
uLi7AYhFttJVvaMrs6p0q/exyw7SOg==
=7s70
-----END PGP SIGNATURE-----

--=-WemAnIj4qWz8ckr1MW2z--
