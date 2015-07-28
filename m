From: Chen Bough <Haibo.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 5/5] ARM: dts: imx6ul-14x14-evk.dts: add tsc support
Date: Tue, 28 Jul 2015 08:50:39 +0000
Message-ID: <BY1PR03MB1388B543998289A17C7B31A99A8D0@BY1PR03MB1388.namprd03.prod.outlook.com>
References: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
 <1437996407-27266-6-git-send-email-haibo.chen@freescale.com>
 <20150727141259.GO12927@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150727141259.GO12927@tiger>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org" <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, "christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org" <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, benjamin.tissoire
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: Monday, July 27, 2015 10:13 PM
> To: Chen Haibo-B51421
> Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; pawel.moll-5wv7dgnIgG8@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org;
> ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org; galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org;
> kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org; dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org; arnd-r2nGTMty4D4@public.gmane.org;
> mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org; christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org; benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org; hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org; sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org;
> mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: Re: [PATCH 5/5] ARM: dts: imx6ul-14x14-evk.dts: add tsc support
> 
> On Mon, Jul 27, 2015 at 07:26:47PM +0800, Haibo Chen wrote:
> > Add touch screen surpport for i.MX6UL-EVK board.
> >
> > Signed-off-by: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/imx6ul-14x14-evk.dts | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> > index 61b41ee..323d32d 100644
> > --- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> > +++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> > @@ -44,6 +44,15 @@
> >  	soc-supply = <&reg_soc>;
> >  };
> >
> > +&tsc {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_tsc>;
> > +	status = "okay";
> 
> We generally have "status" at the bottom of the property list.
> 
> Shawn
>
 
[haibo] Yes, it's my negligence, I will amend this.

> > +	xnur-gpio = <&gpio1 3 0>;
> > +	measure_delay_time = <0xffff>;
> > +	pre_charge_time = <0xfff>;
> > +};
> > +
> >  &uart1 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&pinctrl_uart1>;
> > @@ -212,6 +221,15 @@
> >  		>;
> >  	};
> >
> > +	pinctrl_tsc: tscgrp {
> > +		fsl,pins = <
> > +			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01		0xb0
> > +			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02		0xb0
> > +			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03		0xb0
> > +			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04		0xb0
> > +		>;
> > +	};
> > +
> >  	pinctrl_uart1: uart1grp {
> >  		fsl,pins = <
> >  			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX 0x1b0b1
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
