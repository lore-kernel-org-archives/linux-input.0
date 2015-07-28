From: Chen Bough <Haibo.Chen@freescale.com>
Subject: RE: [PATCH 2/5] Documentation: Detail permitted DT properties for the
 imx6ul_tsc
Date: Tue, 28 Jul 2015 08:48:08 +0000
Message-ID: <BY1PR03MB13888ECA78EBCB233E799BC09A8D0@BY1PR03MB1388.namprd03.prod.outlook.com>
References: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
 <1437996407-27266-3-git-send-email-haibo.chen@freescale.com>
 <20150727112547.GE9169@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1on0140.outbound.protection.outlook.com ([157.56.110.140]:12256
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752683AbbG1IsM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2015 04:48:12 -0400
In-Reply-To: <20150727112547.GE9169@leverpostej>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>, "hadess@hadess.net" <hadess@hadess.net>, "mchehab@osg.samsung.com" <mchehab@osg.samsung.com>, "mamlinav@gmail.com" <mamlinav@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "jonathar@broadcom.com" <jonathar@broadcom.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>, "scott.liu@emc.com.tw" <scott.liu@emc.com.tw>, "geert@linux-m68k.org" <geert@linux-m68k.org>, benjamin.tissoire

Hi Mark,



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: Monday, July 27, 2015 7:26 PM
> To: Chen Haibo-B51421
> Cc: robh+dt@kernel.org; Pawel Moll; ijc+devicetree@hellion.org.uk;
> galak@codeaurora.org; shawnguo@kernel.org; kernel@pengutronix.de;
> linux@arm.linux.org.uk; dmitry.torokhov@gmail.com; hans.verkuil@cisco.com;
> hadess@hadess.net; mchehab@osg.samsung.com; mamlinav@gmail.com;
> arnd@arndb.de; jonathar@broadcom.com; hdegoede@redhat.com;
> christian.gmeiner@gmail.com; scott.liu@emc.com.tw; geert@linux-m68k.org;
> benjamin.tissoires@redhat.com; sebastien.szymanski@armadeus.com;
> sbranden@broadcom.com; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> input@vger.kernel.org
> Subject: Re: [PATCH 2/5] Documentation: Detail permitted DT properties
> for the imx6ul_tsc
> 
> On Mon, Jul 27, 2015 at 12:26:44PM +0100, Haibo Chen wrote:
> > Here we apply required documentation for the imx6ul touch screen
> > controller driver which describe available properties and how to use
> > them.
> >
> > Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> > ---
> >  .../devicetree/bindings/input/touchscreen/imx6ul_tsc.txt   | 14
> ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> > b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> > new file mode 100644
> > index 0000000..e34d752
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.t
> > +++ xt
> > @@ -0,0 +1,14 @@
> > +* Freescale i.MX6UL Touch Controller
> > +
> > +Required properties:
> > +- compatible: must be "fsl,imx6ul-tsc"
> > +
> 
> What about all the other properties in the example?

[haibo] I will add other properties in the documentation. 

> 
> > +Example:
> > +	&tsc {
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_tsc>;
> > +		status = "okay";
> > +		xnur-gpio = <&gpio1 3 GPIO_ACTIVE_HIGH>;
> > +		measure_delay_time = <0xfff>;
> > +		pre_charge_time = <0xffff>;
> 
> Thiose underscores should be dashes, and all the properties should be
> documented.

[haibo] I will change to "measure-delay-time" and "pre-charge-time"

Thanks for your review!

Haibo.

> 
> Mark.
