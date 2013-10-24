From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv7][ 1/4] Input: tsc2007: Add device tree support.
Date: Thu, 24 Oct 2013 17:17:37 +0200
Message-ID: <20131024151736.GE9044@ulmo.nvidia.com>
References: <1382618536-25320-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:38988 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab3JXPRl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Oct 2013 11:17:41 -0400
Content-Disposition: inline
In-Reply-To: <1382618536-25320-1-git-send-email-denis@eukrea.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Denis Carikli <denis@eukrea.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Shawn Guo <shawn.guo@linaro.org>, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Linus Walleij <linus.walleij@linaro.org>


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2013 at 02:42:13PM +0200, Denis Carikli wrote:
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree@vger.kernel.org
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> Cc: Eric B=C3=A9nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v6->v7:
> - One small whitespace cleanup.
> - The properties specific to that driver are now prefixed with "ti,".
> - The ti,fuzzy property has now better documentation.
> ---
>  .../bindings/input/touchscreen/tsc2007.txt         |   45 +++++
>  drivers/input/touchscreen/tsc2007.c                |  194 ++++++++++++++=
+-----
>  2 files changed, 198 insertions(+), 41 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/t=
sc2007.txt
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.=
txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> new file mode 100644
> index 0000000..516b63b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> @@ -0,0 +1,45 @@
> +* Texas Instruments tsc2007 touchscreen controller
> +
> +Required properties:
> +- compatible: must be "ti,tsc2007".
> +- reg: I2C address of the chip.
> +- ti,x-plate-ohms: X-plate resistance in ohms.
> +
> +Optional properties:
> +- gpios: the interrupt gpio the chip is connected to (trough the penirq =
pin)
> +  (see GPIO binding[2] for more details).
> +- interrupt-parent: the phandle for the gpio controller
> +  (see interrupt binding[1]).
> +- interrupts: (gpio) interrupt to which the chip is connected
> +  (see interrupt binding[1]).
> +- pinctrl-0: Should specify pin control groups used for the gpio
> +  (see pinctrl bindings[0]).
> +- pinctrl-names: Should contain only one value - "default"
> +  (see pinctrl bindings[0]).

Also I haven't seen a response as to why this can't be handled by the
GPIO driver. Adding Linus Walleij, perhaps he knows a more definitive
answer.

Linus, the issue here is that the pinctrl properties for this chip are
supposed to pinmux the pendown GPIO for this chip. I was under the
impression that this should be handled by the GPIO controller itself, so
that when gpio_request() was called on a pin it would be the GPIO
controller driver's responsibility to pinmux it appropriately.

> +- ti,max-rt: maximum pressure.
> +- ti,fuzzy: specifies the absolute input fuzz value.
> +  If set, it will permit noise in the data up to +- the value given to t=
he fuzz
> +  parameter, that is used to filter noise from the event stream.

Any reason why these can't be specified per axis? From my experience
with this chip it can make sense to use different values for the
different axes. Well, perhaps X and Y axes can share one fuzz factor,
but the Z axis is sometimes different.

You also modify the driver to ignore the X and Z axes fuzz factor even
for platform data where specifying all three separately was explicitly
allowed. Have you verified that this doesn't cause any regressions?

Thierry

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaToQAAoJEN0jrNd/PrOhRMwQAJ+3XXcV8RtTdpDb8ga1Rw9c
FcX3JlgcGGcQwFwqri4MNn/2eq+LQTkSOmzN1Pw31poA5zPjr52JZS5ZksRC89cc
xCv6iBxp03e74lA0ctgad90qtKS9xUVTxYxTybrZsjW9ywEsSeirgKxlSMXxzoUO
Q3QMpttOrHN4TVuHrBefz/XLFYZeeAM4swU0fKVlSM6ZdbwSUJAwDOSSzZtvuMcT
nkiSUn/4aTJYixQNE2P9PA6VvvBX4fhFpeoyWqjBcu99fYcicYU0TBFlUJe3dqxj
rWXjOmWJmk5nxbhLvCIEYaJWAeriD8rnSwKp59ifONNY2IvbAjVlITERQPVb7+RR
zW0sG3OwVi6qlVYMI7aJnMRi+3wml0nrgwl8eAtm1SZ8dJ/7VhONf3d1pgB4c2c7
265lclZ8+suXVPXijW/EhEDZphkBgah4f38s106W4cJ397l4x8y25Y3A6Yn9Kms3
r2fhLSPzLwu33EuD+6JC/KtiJoqZHgrf6UJfzJy6TbjkiN3WHpAiCRnJruLbWEP5
Tg9M9XYL2qAkz1gHgeATAGH/HEjmjwyZoMUM8KZQC6YNskcothchkAtGpst2aPzG
7xi/HwZAoendrICqk74glerQFrO0QrLD/uDe2dYo8fB6U+clAqSfSIfTXJDiMx9P
WYk/SaWFHBK14Fp5CEDN
=0ekz
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--
