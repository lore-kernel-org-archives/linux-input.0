From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v3] input: pwm-beeper: Add devicetree probing support
Date: Fri, 2 Nov 2012 10:10:10 +0100
Message-ID: <20121102091010.GA11881@avionic-0098.mockup.avionic-design.de>
References: <1351845842-15652-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:65439 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab2KBJKV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Nov 2012 05:10:21 -0400
Content-Disposition: inline
In-Reply-To: <1351845842-15652-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2012 at 09:44:02AM +0100, Sascha Hauer wrote:
> A very simple binding, the only property is the phandle to the PWM.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>=20
> changes since v2:
>=20
> - protect of match table with #ifdef CONFIG_OF
>=20
> changes since v1:
>=20
> - first use new pwm API, if that fails, use legacy API
> - add 'depends on PWM'
>=20
>  Documentation/devicetree/bindings/input/pwm-beeper.txt |    7 +++++++
>  drivers/input/misc/Kconfig                             |    2 +-
>  drivers/input/misc/pwm-beeper.c                        |   14 ++++++++++=
+++-
>  3 files changed, 21 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
>=20
> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Doc=
umentation/devicetree/bindings/input/pwm-beeper.txt
> new file mode 100644
> index 0000000..7388b82
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> @@ -0,0 +1,7 @@
> +* PWM beeper device tree bindings
> +
> +Registers a PWM device as beeper.
> +
> +Required properties:
> +- compatible: should be "pwm-beeper"
> +- pwms: phandle to the physical pwm device

I'd like to see this rewritten as "physical PWM device", but other than
that:

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQk43yAAoJEN0jrNd/PrOhvysP/iqQr2xZfDM9nBzS1196SX8t
50q5mTz7DhREF5wT3NixHqubeA0U8wAnEqUXwkysGyH34osa/Ej6Nq964GMPTfsx
Q/iGCYC9ZyixmZQHcg1Ie6yQKrux6QHM2BU+hoY+soOcdoBMpvc/5Gle0LifsRbr
timzAXH+trQFJnZ2954WTUjHlw89TZOHyYJgbqHEHB3s+4kIfMp8dCISNthON3dG
Smm+ZReyItC6xqVHt5z4R11rNjBo/ZNqCL5LXhtygYMsujh+OhUE/7/A4j7elcTK
bAxAR2o0hC/Uix7XpcQvraX72Ty9xeepNpFaSJjQ16czaRGJpjDhNdGrRwn4440l
IFK3CpnfvrOeOFezT0eWBedEgMbBHBR3OidDnsr/0VmG+hy653aqrJPIFMVTCm9a
i93rNmPleumKpypsMmDtLysZJjZyRB/HgcG+XnlXUxNA/VFTjdlbCAh36CrAh4rD
624cZ9zieNRdz0xz5nvElmLe9bPpICumcOhRwLjhXxw7EoQ7Hb0w6/qqlwmmDjfT
5iyXT3VnPEEpYgXIoG5Aj1pxJJuk1X3jWTn/Fg2f4cTE8/GjsYa8qIr5MfRWoErE
nHDxkrjNozKqc8wwqpcJR2URLzHdAK3y8WUYDvlxLeS07PvUJiJJ4ihX9u6AUz6P
7IPhCRUF1cOn2EOjxiSC
=RA3d
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
