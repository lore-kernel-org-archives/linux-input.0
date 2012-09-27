From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] input: pwm-beeper: Add devicetree probing support
Date: Thu, 27 Sep 2012 21:39:06 +0200
Message-ID: <20120927193906.GA5483@avionic-0098.mockup.avionic-design.de>
References: <1348557351-12599-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:57480 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320Ab2I0TjR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Sep 2012 15:39:17 -0400
Content-Disposition: inline
In-Reply-To: <1348557351-12599-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 25, 2012 at 09:15:51AM +0200, Sascha Hauer wrote:
[...]
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-bee=
per.c
> index fc84c8a..dfb3c50 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
[...]
> @@ -171,6 +175,11 @@ static SIMPLE_DEV_PM_OPS(pwm_beeper_pm_ops,
>  #define PWM_BEEPER_PM_OPS NULL
>  #endif
> =20
> +static const struct of_device_id pwm_beeper_match[] =3D {
> +	{ .compatible =3D "pwm-beeper", },
> +	{ },
> +};
> +

This is usually protected by #ifdef CONFIG_OF...

>  static struct platform_driver pwm_beeper_driver =3D {
>  	.probe	=3D pwm_beeper_probe,
>  	.remove =3D __devexit_p(pwm_beeper_remove),
> @@ -178,6 +187,7 @@ static struct platform_driver pwm_beeper_driver =3D {
>  		.name	=3D "pwm-beeper",
>  		.owner	=3D THIS_MODULE,
>  		.pm	=3D PWM_BEEPER_PM_OPS,
> +		.of_match_table =3D pwm_beeper_match,

=2E.. and this of_match_ptr(pwm_beeper_match). They aren't technically
necessary but I guess it makes sense to not keep them around for !OF
configurations in order to save some bytes.

Thierry

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQZKtaAAoJEN0jrNd/PrOhou4P/j4WkQ/qfgTlCTgDmVoOryu8
COsRgaKvU89pzym2X4dNPIvaNhczPy25MS2o3vp2pksQlCePLxYw2hGvojBMKaC7
Bj7iJ9g0WLyZ0PocqIeVszDOEEU7qFgmK6aJgHJuhbOrUtXGiAM4bYl5+Kii/mtf
lYWiOK+Tvd031yjgf35jqefwr4bcYOGzcsDTUo662Q2dPHOJIeEBuzNeIdYwXda5
F4b7Yig4y4pV313QJvc9UhMfHHqsm3/y1HdpyrEucD07pykVEugmQvwNvQlsHSap
+/GN0286TypJ6Q4W41JvDwRTzRkcGA+9eprQUJMC7IEq+26uNPOqOTSM1kaPF4ZL
COTqnEOAMhB6+1oDbtdTHMO49+YdNyQP5xIvBHINv8WWcCOy2g//KIoaIFkC6BQS
lBEk2PctTswJXo3htl94orN8XE51E10GqVUIUiZia2mXT0YGQEh3S8jjqcaBj8sN
+1K65a3KL+0fhRVrdMCUJzjLHMTx2xDcICMk8MkuvbxNiYnId2vmUDs406qbywei
L9+6WvaySGQzPMckH5jVYyplPKbv3P1Yqm1yNWLbnitLHVIfICGuBsc9xoCRNwT1
Nc8MvqL4bAiNv523VHctdU/OT1vvDwh4lOjtOHelnicK2ENSa0AtNA9ssBdPlhvL
irqlFkM7ymY02yCCSg2R
=TH2/
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
