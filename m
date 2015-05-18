From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 4/7] arm: dts: imx: update snvs to use syscon access
 register
Date: Mon, 18 May 2015 10:45:25 +0200
Message-ID: <1431938725.3209.15.camel@pengutronix.de>
References: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
	 <1431696990-23078-5-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50262 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbbERIpl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 May 2015 04:45:41 -0400
In-Reply-To: <1431696990-23078-5-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, sachin.kamat@linaro.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Hi Frank,

Am Freitag, den 15.05.2015, 21:36 +0800 schrieb Frank.Li@freescale.com:
> From: Frank Li <Frank.Li@freescale.com>
> 
> snvs is MFP device. Change dts to use syscon to allocate register resource.
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++--------
>  arch/arm/boot/dts/imx6sl.dtsi  | 12 ++++--------
>  arch/arm/boot/dts/imx6sx.dtsi  | 12 ++++--------
>  arch/arm/boot/dts/vfxxx.dtsi   |  9 +++------
>  4 files changed, 15 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 0482a66..6d8161d 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -687,21 +687,17 @@
>  			};
>  
>  			snvs@020cc000 {
> -				compatible = "fsl,sec-v4.0-mon", "simple-bus";
> -				#address-cells = <1>;
> -				#size-cells = <1>;
> -				ranges = <0 0x020cc000 0x4000>;
> +				compatible = "fsl,sec-v4.0-mon", "syscon",  "simple-bus";

The compatible should change from "simple-bus" to "simple-mfd", then.

regards
Philipp

