From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/5] Documentation: Detail permitted DT properties for
 the imx6ul_tsc
Date: Mon, 27 Jul 2015 12:25:47 +0100
Message-ID: <20150727112547.GE9169@leverpostej>
References: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
 <1437996407-27266-3-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437996407-27266-3-git-send-email-haibo.chen@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haibo Chen <haibo.chen@freescale.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>, "hadess@hadess.net" <hadess@hadess.net>, "mchehab@osg.samsung.com" <mchehab@osg.samsung.com>, "mamlinav@gmail.com" <mamlinav@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "jonathar@broadcom.com" <jonathar@broadcom.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>, "scott.liu@emc.com.tw" <scott.liu@emc.com.tw>, "geert@linux-m68k.org" <geert@linux-m68k.org>, benjamin.tissoire
List-Id: linux-input@vger.kernel.org

On Mon, Jul 27, 2015 at 12:26:44PM +0100, Haibo Chen wrote:
> Here we apply required documentation for the imx6ul touch screen
> controller driver which describe available properties and how to
> use them.
> 
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> ---
>  .../devicetree/bindings/input/touchscreen/imx6ul_tsc.txt   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> new file mode 100644
> index 0000000..e34d752
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> @@ -0,0 +1,14 @@
> +* Freescale i.MX6UL Touch Controller
> +
> +Required properties:
> +- compatible: must be "fsl,imx6ul-tsc"
> +

What about all the other properties in the example?

> +Example:
> +	&tsc {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_tsc>;
> +		status = "okay";
> +		xnur-gpio = <&gpio1 3 GPIO_ACTIVE_HIGH>;
> +		measure_delay_time = <0xfff>;
> +		pre_charge_time = <0xffff>;

Thiose underscores should be dashes, and all the properties should be
documented.

Mark.
