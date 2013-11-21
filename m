From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCHv9][ 3/3] ARM: dts: cpuimx35 Add touchscreen support.
Date: Thu, 21 Nov 2013 09:00:52 +0100
Message-ID: <20131121090052.1684db75@ipc1.ka-ro>
References: <1383916659-9988-1-git-send-email-denis@eukrea.com>
	<1383916659-9988-3-git-send-email-denis@eukrea.com>
	<20131121050922.GF18477@ns203013.ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:64303 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab3KUIBH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Nov 2013 03:01:07 -0500
In-Reply-To: <20131121050922.GF18477@ns203013.ovh.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Denis Carikli <denis@eukrea.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, linux-arm-kernel@lists.infradead.org, Eric B??nard <eric@eukrea.com>

Hi,

Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 14:17 Fri 08 Nov     , Denis Carikli wrote:
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Pawel Moll <pawel.moll@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > Cc: Grant Likely <grant.likely@linaro.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: linux-input@vger.kernel.org
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Eric B=C3=A9nard <eric@eukrea.com>
> > Signed-off-by: Denis Carikli <denis@eukrea.com>
> > ---
> > ChangeLog v8->v9:
> > - Added Grant Likely in the cc list.
> > - Adapted to the removal of the pinctrl properties in the tsc2007 d=
ocumentation.
> > - Fixed the gpios property (before, it was set to active high by er=
ror).
> >=20
> > ChangeLog v7->v8:
> > - Added Shawn Guo in the cc list.
> > ---
> >  arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi |   21 ++++++++++++++=
+++++++
> >  1 file changed, 21 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi b/arch/ar=
m/boot/dts/imx35-eukrea-cpuimx35.dtsi
> > index b9cb5a5..f25a40f 100644
> > --- a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
> > +++ b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
> > @@ -36,6 +36,27 @@
> >  		compatible =3D "nxp,pcf8563";
> >  		reg =3D <0x51>;
> >  	};
> > +
> > +	tsc2007: tsc2007@48 {
> > +		compatible =3D "ti,tsc2007";
> > +		reg =3D <0x48>;
> > +		interrupt-parent =3D <&gpio3>;
> > +		interrupts =3D <0x2 0x8>;
> > +		gpios =3D <&gpio3 2 1>;
> as explain on the binding drop this gpios this is an IRQ not a gpio
>=20
> NACK
The driver needs an interrupt to get notified about pendown events and
needs to poll the pendown signal to find out when the pen has been
lifted. Both the interrupt and the pendown signal happen to be
signalled on the same pin. Thus, IMO it is perfectly well to have the
interrupt property as well as the gpios property here.

How would you tell the driver which pin to poll for detecting the pen
up event?

Having a platform callback with hardcoded GPIO numbers is not an option=
=2E


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
