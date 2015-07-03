From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v1 1/4] ARM: dts: vfxxx: Add io-channel-cells property for
 ADC node
Date: Fri, 03 Jul 2015 14:57:45 +0200
Message-ID: <101a8c84fbe2063f6cf56737a5f9417f@agner.ch>
References: <cover.1435646447.git.maitysanchayan@gmail.com>
 <916569b56d60d41f9cd12c5244be3778857a971b.1435646447.git.maitysanchayan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:52868 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015AbbGCNAZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Jul 2015 09:00:25 -0400
In-Reply-To: <916569b56d60d41f9cd12c5244be3778857a971b.1435646447.git.maitysanchayan@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawn.guo@linaro.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 2015-06-30 08:54, Sanchayan Maity wrote:
> This commit adds io-channel-cells property to the ADC node. This
> property is required in order for an IIO consumer driver to work.
> Especially required for Colibri VF50, as the touchscreen driver
> uses ADC channels with the ADC driver based on IIO framework.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  arch/arm/boot/dts/vfxxx.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index 2c20f3f..f7d8fb6 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -227,6 +227,7 @@
>  				clocks = <&clks VF610_CLK_ADC0>;
>  				clock-names = "adc";
>  				status = "disabled";
> +				#io-channel-cells = <1>;
>  			};
>  
>  			tcon0: tcon@4003d000 {
> @@ -461,6 +462,7 @@
>  				clocks = <&clks VF610_CLK_ADC1>;
>  				clock-names = "adc";
>  				status = "disabled";
> +				#io-channel-cells = <1>;
>  			};
>  
>  			esdhc1: esdhc@400b2000 {

Minor nitpick: can you put the new property one line up? That way it
would be sorted alphabetically and status is conveniently still at the
end.

Otherwise:

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan
