From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 6/9] power_supply: wm97xx_battery: use
 power_supply_get_drvdata
Date: Thu, 24 Nov 2016 00:13:20 +0100
Message-ID: <20161123231320.fo3kilw5h7cctngc@earth>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-7-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkhjhr2u2sgpauj6"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933204AbcKWXNZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Nov 2016 18:13:25 -0500
Content-Disposition: inline
In-Reply-To: <1477510907-23495-7-git-send-email-robert.jarzmik@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org


--vkhjhr2u2sgpauj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Robert,

On Wed, Oct 26, 2016 at 09:41:44PM +0200, Robert Jarzmik wrote:
> As the power supply framework provides a way to store and retrieve
> private supply data, use it.
>=20
> In the process, change the platform data for wm97xx_battery from a
> container of a single struct wm97xx_batt_pdata to the direct point to wm9=
7xx_batt_pdata.
>=20
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/input/touchscreen/wm97xx-core.c |  2 +-
>  drivers/power/supply/wm97xx_battery.c   | 25 ++++++++++---------------
>  2 files changed, 11 insertions(+), 16 deletions(-)

I queued this into power-supply's for-next branch.

-- Sebastian

--vkhjhr2u2sgpauj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlg2IpAACgkQ2O7X88g7
+pr25w//beIkNI5JttriQyzPkMKP+e3tuxw5q4zPRdJcoQID6UWgPuEN+U4Sqv4Q
G7Oo9qyIpocirsokSkiq9Pf6CKwiL7SWqJy0gCpqGFeSQWnIOf2s5LurVCBCwPaI
+VPYarKZMIB3QEepNS1Kl6k8vGMDKVk7XyX0TZ1dfBMTjqsLeTZm7uIxrv9jZEP2
P1+FHrjRAWlEkamct9cJKVhjTFvZMz3PjrUjA5q2lbMqPzehk7afGXrcsh8rTz0Z
l2jMN5BqRRBpz7qMnv3ABCAmihI/YjUdX6vpdvNPJjqKTZbSGY3jBkTS2GHkpz0h
DMmOJCfwWFA6J7LZ1rjxaJzf0/pMLT8aXaE38vqhmWy1ECPoNIm/2BhYx/q/odzH
wC91b3PGD+PBzMg1p5wwvJ8CEJFCJqtQlcX1i/1VXHVapbHPREkoZ2gDpBnPj8z1
Aoap1Iv7XVNZe3c5k2EHq3W8OosHLvbWX5ubIV1YOMzRufw/+q4aJgwLeRGp9QxE
vFiLn3v/d0jVXcq1Xau6YPtN+jNJDfUvCbjPPOfltC79J3d3fbA0T9rSLU+pD7BM
9IKYrNmaiG4q+Mnx6R9wJdh2OX9j7aaCUstwlsQmWVhH5eNFL4hOcLDxZN/FXvcL
I7BNVTja40IFVY7snC3q2D4bhAnFwkbTSJvtlPp1tP9T9RlsS3k=
=CqX6
-----END PGP SIGNATURE-----

--vkhjhr2u2sgpauj6--
