From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: use syscon in cygnus touchscreen dt node
Date: Mon, 22 Feb 2016 13:40:05 +0530
Message-ID: <CAAFb_vocadoQ1Egt4PgOX4pW2Tz5aifqWZQxQKOhvNeq0frsYQ@mail.gmail.com>
References: <1456127379-25866-1-git-send-email-raveendra.padasalagi@broadcom.com>
	<1456127379-25866-4-git-send-email-raveendra.padasalagi@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:36137 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbcBVIKH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Feb 2016 03:10:07 -0500
Received: by mail-yw0-f174.google.com with SMTP id e63so112689730ywc.3
        for <linux-input@vger.kernel.org>; Mon, 22 Feb 2016 00:10:06 -0800 (PST)
In-Reply-To: <1456127379-25866-4-git-send-email-raveendra.padasalagi@broadcom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Richardson <jonathar@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Anup Patel <anup.patel@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>

On Mon, Feb 22, 2016 at 1:19 PM, Raveendra Padasalagi
<raveendra.padasalagi@broadcom.com> wrote:
> In Cygnus SOC touch screen controller registers are shared
> with ADC and flex timer. Using readl/writel could lead to
> race condition. So in such case register access is handled
> through syscon framework API's in the touch screen driver.
> This feature is enabled if "brcm,iproc-touchscreen-syscon"
> compatible string is selected in touchscreen dt node.
>
> So this patch enables syscon support in touchscreen driver
> by adding necessary properties in touchscreen dt node.
>
> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 3878793..1704dc0 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -351,9 +351,16 @@
>                                         <&pinctrl 142 10 1>;
>                 };
>
> +               ts_adc_syscon: ts_adc_syscon@180a6000 {
> +                       compatible = "brcm,iproc-ts-adc-syscon","syscon";
> +                       reg = <0x180a6000 0xc30>;
> +               };
> +
>                 touchscreen: tsc@180a6000 {
> -                       compatible = "brcm,iproc-touchscreen";
> -                       reg = <0x180a6000 0x40>;
> +                       compatible = "brcm,iproc-touchscreen-syscon";

Hi Rob,
In patchset V2 you had a comment as to have only "syscon" support,
Since having "syscon" only support breaks the dt backward compatibility
as the existing driver has support for "reg".  So in patchset V3 I have
not addressed this comment yet. Waiting for your opinion on whether
to proceed with "syscon" only support.

-Raveendra
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ts_syscon = <&ts_adc_syscon>;
>                         clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
>                         clock-names = "tsc_clk";
>                         interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> --
> 1.9.1
>
