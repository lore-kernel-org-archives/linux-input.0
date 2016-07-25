From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: cros-ec-tunnel: Fix usage of cros_ec_cmd_xfer()
Date: Mon, 25 Jul 2016 22:43:13 +0200
Message-ID: <20160725204313.GA1698@katana>
References: <1469470451-111822-1-git-send-email-briannorris@chromium.org>
 <1469470451-111822-2-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54880 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861AbcGYUn1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 16:43:27 -0400
Content-Disposition: inline
In-Reply-To: <1469470451-111822-2-git-send-email-briannorris@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Olof Johansson <olof@lixom.net>, Brian Norris <computersforpeace@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Shawn Nematbakhsh <shawnn@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 25, 2016 at 11:14:10AM -0700, Brian Norris wrote:
> cros_ec_cmd_xfer returns success status if the command transport
> completes successfully, but the execution result is incorrectly ignored.
> In many cases, the execution result is assumed to be successful, leading
> to ignored errors and operating on uninitialized data.
>=20
> We've recently introduced the cros_ec_cmd_xfer_status() helper to avoid t=
hese
> problems. Let's use it.
>=20
> Signed-off-by: Brian Norris <briannorris@chromium.org>

I agree with Dmitry about Thierry pushing the patch. So:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXlnnhAAoJEBQN5MwUoCm2cTgP/05LQBiho0grHj4NTlPiWpce
kdvBbhyBgigcpxKcxRxQRrkgZMz9HSteJyulfAvvnJw1UEM1vMOT4MlEzkDrAjn4
PnrpFJiyCeKyzxRLLDkkhaRpBzHzSS82ydAWPIDhLPCp2mdsmpftRO+uL1xHe8rj
EzKO4ggxiZc51xJRRQjff5znqjAUcZAzuPwjw0HSqoFZOSWA6O+fs1zoO4xJuQGV
+ML1FRlOyhKzldZTx7iZwYtIe5yevFJH5tf2/rqH+1yn9IsrVs9B+4I+xF0amdT1
Uy3EJ6EDHfQKSBeEWLKqchOL38nKoWUePvuKGDMQWUMyO0q7oYOgUUSMSCPnk1DQ
THhchL7pFV4blCOzHhWB+HbjeNP2jqp5v8e/4y95dcJXWtivl0MWP8zOHB1eyc4g
2SVTCYgkUwtca67vIco5iySQDCzkXF5ZHGmYDUaZumJockdPsTY3LRLN4AnXZDng
EF2tZDgDRddAtodH9ZVDalUO7gEWJ/8Xi4njJlrLCLg4BTfcB4mZ4wsiKUcOc6xt
IoaTC1TUmmXY5oxxPflmvO0/n/G6/pYV9cjYsdnpPeTtHkRjV77E8Smb8vYkLXrg
jne24fgidVYfdLLwVXzf9/wX9xEViruzkXn4xRqpVpzOxvXH7INVKfyj2o2VveJk
Or9Za28+AsP+17UTUdnN
=hmpg
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
