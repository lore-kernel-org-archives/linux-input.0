From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH -next] input/touchscreen: fix sur40.c build errors
Date: Wed, 15 Apr 2015 18:10:58 +0200
Message-ID: <552E8D92.1070805@butterbrot.org>
References: <552E899E.2050703@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AukwokdtJvQRf0OvxRVaBiIDULi6moXig"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:59569 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932554AbbDOQK7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2015 12:10:59 -0400
In-Reply-To: <552E899E.2050703@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AukwokdtJvQRf0OvxRVaBiIDULi6moXig
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Randy,

On 15.04.2015 17:54, Randy Dunlap wrote:
> ---
>  drivers/input/touchscreen/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>=20
> --- linux-next-20150415.orig/drivers/input/touchscreen/Kconfig
> +++ linux-next-20150415/drivers/input/touchscreen/Kconfig
> @@ -981,6 +981,7 @@ config TOUCHSCREEN_SUR40
>  	tristate "Samsung SUR40 (Surface 2.0/PixelSense) touchscreen"
>  	depends on USB
>  	depends on MEDIA_USB_SUPPORT
> +	depends on VIDEO_V4L2
>  	select INPUT_POLLDEV
>  	select VIDEOBUF2_DMA_SG
>  	help
>=20
Thanks for catching this. I assumed videobuf2 would to auto-select
video-v4l2 in any case.

Best, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--AukwokdtJvQRf0OvxRVaBiIDULi6moXig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlUujZIACgkQ7CzyshGvathRgACfevOIVBaRqKZog4esJBe8ncHj
XfIAnjX6sTzEky6aRwZE6SVazOCtilFG
=AlJ9
-----END PGP SIGNATURE-----

--AukwokdtJvQRf0OvxRVaBiIDULi6moXig--
