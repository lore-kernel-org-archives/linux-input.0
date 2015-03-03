From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 1/8] ARM: dt: Binding documentation for imx25 ADC/TSC
Date: Tue, 03 Mar 2015 10:02:12 +0100
Message-ID: <2620642.Qp1W4O8uh6@wuerfel>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
 <1425369498-25541-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1425369498-25541-2-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Lars-Peter Clausen <lars@metafoo.de>, Samuel Ortiz <sameo@linux.intel.com>, Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Denis Carikli <denis@eukrea.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-arm-kernel@lists.infradead.org, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-input@vger.kernel.org

On Tuesday 03 March 2015 08:58:11 Markus Pargmann wrote:
> +Example:
> +       tscadc: tscadc@50030000 {
> +               compatible = "fsl,imx25-tsadc";
> +               reg = <0x50030000 0xc>;
> +               interrupts = <46>;
> +               clocks = <&clks 119>;
> +               clock-names = "ipg";
> +               interrupt-controller;
> +               #interrupt-cells = <1>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               tsc: tcq@50030400 {
> +                       compatible = "fsl,imx25-tcq";
> +                       reg = <0x50030400 0x60>;
> +                       ...
> +               };
> +
> +               adc: gcq@50030800 {
> +                       compatible = "fsl,imx25-gcq";
> +                       reg = <0x50030800 0x60>;
> +                       ...
> +               };
> +       };
> 

I wonder if we should just treat this MFD as a single IIO device
that also registers to the input layer.

Are there any other registers in the 0x50030000-0x50031000
range, or could the fsl,imx25-tcq and fsl,imx25-gcq devices
be reused outside of a fsl,imx25-tsadc device?

	Arnd
