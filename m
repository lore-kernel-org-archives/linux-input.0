From: maitysanchayan@gmail.com
Subject: Re: [PATCH v4 1/3] ARM: dts: vf500-colibri: Add device tree node for
 touchscreen support
Date: Sun, 23 Aug 2015 21:00:01 +0530
Message-ID: <20150823153001.GA3935@Sanchayan-Arch>
References: <cover.1440162473.git.maitysanchayan@gmail.com>
 <a960c538cf419a816d73fbea7d4380ea773aa6ba.1440162473.git.maitysanchayan@gmail.com>
 <a20cfadaea07ab255ac94fd5e567e5cf@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33563 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbbHWPdX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Aug 2015 11:33:23 -0400
Content-Disposition: inline
In-Reply-To: <a20cfadaea07ab255ac94fd5e567e5cf@agner.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, shawnguo@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 15-08-22 18:54:28, Stefan Agner wrote:
> On 2015-08-21 06:26, Sanchayan Maity wrote:
> > Add device tree node for touchscreen support on Colibri VF50. The
> > touchscreen functionality on VF50 uses the ADC channels of Vybrid
> > and some GPIOs. Also add pinctrl nodes for proper pinmux.
> > 
> > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > ---
> >  arch/arm/boot/dts/vf500-colibri-eval-v3.dts |  4 +++
> >  arch/arm/boot/dts/vf500-colibri.dtsi        | 47 +++++++++++++++++++++++++++++
> >  2 files changed, 51 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> > b/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> > index 7fc782c..14c0b00 100644
> > --- a/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> > +++ b/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> > @@ -15,3 +15,7 @@
> >  	model = "Toradex Colibri VF50 on Colibri Evaluation Board";
> >  	compatible = "toradex,vf500-colibri_vf50-on-eval",
> > "toradex,vf500-colibri_vf50", "fsl,vf500";
> >  };
> > +
> > +&touchscreen {
> > +	status = "okay";
> > +};
> > diff --git a/arch/arm/boot/dts/vf500-colibri.dtsi
> > b/arch/arm/boot/dts/vf500-colibri.dtsi
> > index cee34a3..84f091d 100644
> > --- a/arch/arm/boot/dts/vf500-colibri.dtsi
> > +++ b/arch/arm/boot/dts/vf500-colibri.dtsi
> > @@ -17,4 +17,51 @@
> >  	memory {
> >  		reg = <0x80000000 0x8000000>;
> >  	};
> > +
> > +	touchscreen: vf50-touchscreen {
> > +		compatible = "toradex,vf50-touchscreen";
> > +		io-channels = <&adc1 0>,<&adc0 0>,
> > +				<&adc0 1>,<&adc1 2>;
> > +		xp-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
> > +		xm-gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
> > +		yp-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
> > +		ym-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
> > +		interrupt-parent = <&gpio0>;
> > +		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> > +		pinctrl-names = "idle","default","gpios";
> > +		pinctrl-0 = <&pinctrl_touchctrl_idle>;
> > +		pinctrl-1 = <&pinctrl_touchctrl_default>;
> > +		pinctrl-2 = <&pinctrl_touchctrl_gpios>;
> > +		vf50-ts-min-pressure = <200>;
> 
> Since this is a touch screen related property, we even would want to
> have that in the board specific device-tree (vf500-colibri-eval-v3.dts).

So the same property specified again in vf500-colibri-eval-v3.dts? Ok will
include the same.

- Sanchayan.
