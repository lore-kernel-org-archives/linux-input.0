From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Appletouch patch
Date: Thu, 24 Apr 2008 10:47:34 +0200
Message-ID: <1209026854.3357.35.camel@johannes.berg>
References: <48103F4C.4000903@anduras.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-z3h5whUJcr0mty4AX0VG"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:49270 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbYDXJf2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Apr 2008 05:35:28 -0400
In-Reply-To: <48103F4C.4000903@anduras.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sven Anders <anders@anduras.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input <linux-input@vger.kernel.org>


--=-z3h5whUJcr0mty4AX0VG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-04-24 at 10:05 +0200, Sven Anders wrote:
> I hereby request inclusion of the attached patch to the Linux 2.6.26 deve=
lopment branch.
> If this patch is added, I will be able to commit further enhancements in =
the future.

> This mainly adds support for the status bits on Geyser 3/4 touchpads.
> It had been tested for serveral months by the MacTel community.

> -	{ ATP_DEVICE(GEYSER_ANSI_PRODUCT_ID) },
> +	{ ATP_DEVICE(GEYSER2_ANSI_PRODUCT_ID) },

Why this rename? Is that backed by the OSX file? I don't care much, but
it seems useless.

> -	signed char *		data;		/* transferred data */
> +	u8 *			data;		/* transferred data */

That I can understand,

>  	int			xy_acc[ATP_XSENSORS + ATP_YSENSORS];
>  	int			datalen;	/* size of an USB urb transfer */
> -	int			idlecount;      /* number of empty packets */

> +	int			idle_counter;	/* number of empty packets */

But not that. Why?

>  #define dbg_dump(msg, tab) \
> @@ -182,8 +198,12 @@
>  		if (debug) printk(KERN_DEBUG format, ##a);		\
>  	} while (0)
> =20
> -MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold, Michael Hanselm=
ann");
> -MODULE_DESCRIPTION("Apple PowerBooks USB touchpad driver");
> +MODULE_AUTHOR("Johannes Berg");
> +MODULE_AUTHOR("Stelian Pop");
> +MODULE_AUTHOR("Frank Arnold");
> +MODULE_AUTHOR("Michael Hanselmann");
> +MODULE_AUTHOR("Sven Anders");
> +MODULE_DESCRIPTION("Apple PowerBook and MacBook USB touchpad driver");

Ack.

> -static int debug =3D 1;
> +static int debug;
>  module_param(debug, int, 0644);
>  MODULE_PARM_DESC(debug, "Activate debugging output");

Also ack.
=20
> @@ -240,7 +260,7 @@
>  {
>  	char data[8];
>  	int size;
> -
> +=20

No introducing leading whitespace please.

>  	if (size !=3D 8) {
> +		if (debug)
> +		{

CodingStyle.

>  	if (size !=3D 8) {
> +		if (debug)
> +		{

Ditto.

> +	/* Just update the base values (i.e. touchpad in untouched state) */
> +	if (dev->data[dev->datalen-1] & ATP_STATUS_BIT_BASE_UPDATE)
> +	{

Ditto.

>  	for (i =3D 0; i < ATP_XSENSORS + ATP_YSENSORS; i++) {
> -		/* accumulate the change */
> -		signed char change =3D dev->xy_old[i] - dev->xy_cur[i];
> -		dev->xy_acc[i] -=3D change;
> +		/* calculate the change */
> +		dev->xy_acc[i] =3D dev->xy_cur[i] - dev->xy_old[i];
> +
> +		/* this is a round-robin value, so couple with that */
> +		if (dev->xy_acc[i] > 127)
> +			dev->xy_acc[i] -=3D 256;
> +
> +		if (dev->xy_acc[i] < -127)
> +			dev->xy_acc[i] +=3D 256;
> +
> +		/* Needed for the older Geyser */
> +		if (!atp_is_geyser_3_4(dev))
> +		{

Ditto.

> +			/* store new 'untouched' value, if any new */
> +			if (dev->xy_acc[i] < -1)
> +				dev->xy_old[i] =3D dev->xy_cur[i];
> +		}

You need more rationale for the algorithm change.

> -	key =3D dev->data[dev->datalen - 1] & 1;
> -
> +	key =3D dev->data[dev->datalen - 1] & ATP_STATUS_BIT_BUTTON;
> +=20

Shouldn't this depend on the new format appletouch?

> @@ -549,16 +610,28 @@
>  	 * work on Fountain touchpads.
>  	 */
>  	if (!atp_is_fountain(dev)) {
> +
> +		/* Button must not be pressed when entering suspend,
> +		   otherwise we will never release the button. */

Useless whitespace, CodingStyle for comments looks differently.

[stopped here]

Please read CodingStyle, then split your patch at least into the
renames/code changes that don't really change anything and the actual
algorithm changes. Also, if you're feeling motivated, it would be good
if the "is_atp_xxx" foo was replaced by the driver_info in struct
usb_device_id.

johannes

--=-z3h5whUJcr0mty4AX0VG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASBBJJaVg1VMiehFYAQIpGhAAvqqn/KYS13GEkOE39tYxu7FfERMRn/N+
uexv++4lboUR6vjaiuEbw6JzdNNwZfPVIaFoWr9Yspm43TNHF8QugfXAR1TsTO30
e+qQIuZqd1Q/aEDPwlrALI9WgYG9ZivY/t5Dzm8JWmwSKqSUG4iyOOQ6UTWYBVvz
LjIJp9/1fMfO06+KBxGurYqH0EUPUuIBFYRNeL4Su3C3lb3D1Zclo1OFO6zRn3nr
RS59KhPrspYUgm3MPManxNRvrrxKuOfWdKIAUa6gTk8bovA88u8d48ybMFYt+GvE
1huXHaqHVpHaju0x/q0rpDwUWMKHoG4Kf9slWFBaLFAGsnvLZba/DUiob3epJ5ja
ifmX2jUTtGI66hJl0QdzUm/KcZzZEKuivhTgHTSmTnPBQwVXznJuifP8ScG4S8Cb
Wnn6oW9FvMfHo6cytAmsGw21zracjG1rmuA5Ep8QhNioRhrrBeT/ZcS8WtRXfDb8
/D1FjBw77mBzVM6X6bDZ2tgsMzxgw98zOvjAZ7/BzztD1B0RO5p3BXGg+XYiRp0u
9iKfyEO4gElE3Ey7SxQQRRXY3DLloztbLJ1C6VgY+BxWB6KRn0MRm9fM6K9ws9v9
rW9C0i1qH09sGUeENB5Jo5epdTDArFOdmHDryEU2m1mnA+EaI6tBotPYFI3ZXB3g
QqHtsUGb9lg=
=7ItF
-----END PGP SIGNATURE-----

--=-z3h5whUJcr0mty4AX0VG--

