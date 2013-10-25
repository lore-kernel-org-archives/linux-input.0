From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv7][ 1/4] Input: tsc2007: Add device tree support.
Date: Fri, 25 Oct 2013 10:33:06 +0200
Message-ID: <20131025083305.GE19622@ulmo.nvidia.com>
References: <1382618536-25320-1-git-send-email-denis@eukrea.com>
 <20131024151736.GE9044@ulmo.nvidia.com>
 <20131025083951.18675574@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:51878 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab3JYIdK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Oct 2013 04:33:10 -0400
Content-Disposition: inline
In-Reply-To: <20131025083951.18675574@ipc1.ka-ro>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Denis Carikli <denis@eukrea.com>, Rob Herring <rob.herring@calxeda.com>, Shawn Guo <shawn.guo@linaro.org>, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>


--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2013 at 08:39:51AM +0200, Lothar Wa=C3=9Fmann wrote:
> Hi,
>=20
> Thierry Reding wrote:
> > On Thu, Oct 24, 2013 at 02:42:13PM +0200, Denis Carikli wrote:
> > > Cc: Rob Herring <rob.herring@calxeda.com>
> > > Cc: Pawel Moll <pawel.moll@arm.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: linux-input@vger.kernel.org
> > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> > > Cc: Eric B=C3=A9nard <eric@eukrea.com>
> > > Signed-off-by: Denis Carikli <denis@eukrea.com>
> > > ---
> > > ChangeLog v6->v7:
> > > - One small whitespace cleanup.
> > > - The properties specific to that driver are now prefixed with "ti,".
> > > - The ti,fuzzy property has now better documentation.
> > > ---
> > >  .../bindings/input/touchscreen/tsc2007.txt         |   45 +++++
> > >  drivers/input/touchscreen/tsc2007.c                |  194 ++++++++++=
+++++-----
> > >  2 files changed, 198 insertions(+), 41 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/input/touchscre=
en/tsc2007.txt
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2=
007.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> > > new file mode 100644
> > > index 0000000..516b63b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> > > @@ -0,0 +1,45 @@
> > > +* Texas Instruments tsc2007 touchscreen controller
> > > +
> > > +Required properties:
> > > +- compatible: must be "ti,tsc2007".
> > > +- reg: I2C address of the chip.
> > > +- ti,x-plate-ohms: X-plate resistance in ohms.
> > > +
> > > +Optional properties:
> > > +- gpios: the interrupt gpio the chip is connected to (trough the pen=
irq pin)
> > > +  (see GPIO binding[2] for more details).
> > > +- interrupt-parent: the phandle for the gpio controller
> > > +  (see interrupt binding[1]).
> > > +- interrupts: (gpio) interrupt to which the chip is connected
> > > +  (see interrupt binding[1]).
> > > +- pinctrl-0: Should specify pin control groups used for the gpio
> > > +  (see pinctrl bindings[0]).
> > > +- pinctrl-names: Should contain only one value - "default"
> > > +  (see pinctrl bindings[0]).
> >=20
> > Also I haven't seen a response as to why this can't be handled by the
> > GPIO driver. Adding Linus Walleij, perhaps he knows a more definitive
> > answer.
> >=20
> > Linus, the issue here is that the pinctrl properties for this chip are
> > supposed to pinmux the pendown GPIO for this chip. I was under the
> > impression that this should be handled by the GPIO controller itself, so
> > that when gpio_request() was called on a pin it would be the GPIO
> > controller driver's responsibility to pinmux it appropriately.
> >=20
> When a GPIO is requested the GPIO layer cannot know what it is
> requested for and how the pinmux for the pin function should be
> configured (pullups, drive strength, ...). A pin may have multiple
> functions depending on what modules are plugged into a baseboard.

But GPIO is one specific function of a given pin, isn't it?

> Thus the pinctrl binding needs to be with the driver that uses the pin.

I wonder if this really needs to be dynamically configured depending on
the driver. Properties like pullups and driver strength can potentially
harm hardware when they're wrong, so relying on the driver's probe to
configure them correctly doesn't sound very safe. It's always possible
to disable the device (either via modifying the DTS or by having the
bootloader patch it). That means the driver won't be probed at all, and
therefore none of the pinctrl or pinmux settings will be applied.

Thierry

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaizBAAoJEN0jrNd/PrOhiFgP/3FMHPZ5Ejpx3TYPzlUPPmOl
pRR0BnPMinHuQvuvgBO4QUCnMS2aiDKR0F/6UGAER+lT251iVCHTOwe/o+gx6Hk8
MO8MohKpYHf6Qdck8nfZZ0RsQAOg/d8FQs2G/Iz3jj7l2KHuu0fVcrHbg87CV8N/
oqQ1AV84xrEQCaphTMtO1fUMcCNPPxW7NOluqFEsjbru0eE66q0v0TbuxNIi2XgI
xmtWGk85jCf1ZdrAQeZVVFXQbzqvbrAdBOwdh3l8g363ujALSgfwmghdOhAy+dKG
tk4zXjm8QbphcfyoPS3j2XByNl3Uon3H155d/k+9YtNuDCaQ+SF7ZNknWk/L+g8a
eZUUOFYiUfcZGvcpOwakcv6VAOV5u7S2ZKODBYZFs4D782FI9HyTQ60SnK4mpSUk
ZVKn/nhdV0IPk4SI7PNaim/s0YByNSIGxRROyaHE3xNtwWzjrobRYCxJRIfOggfT
WbnrUi3gM4ImVjnBiBOEBPs27yavw5q3lmPD1aaQN6/h9oGjknWGMZ2KeZlv+xnP
DZ7C+YBQ0HidnpyWL9aljh/m+8uv0GSA0Jw8QPtJibrDyN5FqQQhyUNgH8/XkzDV
PmmeNuXurbu+oUDsYOFdGpoUx/iCD1vvx7DXAD480UpoQJ0IVQ1ltjzdbHoYoZwG
+ylHWJ+mmXrkSUrqyfT7
=S0mB
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--
