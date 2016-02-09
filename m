From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] input: cygnus-update touchscreen dt node document
Date: Tue, 09 Feb 2016 12:04 +0100
Message-ID: <2631849.GeOulu78vx@wuerfel>
References: <1455008277-8312-1-git-send-email-raveendra.padasalagi@broadcom.com> <1455008277-8312-2-git-send-email-raveendra.padasalagi@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:55450 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbcBILEn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Feb 2016 06:04:43 -0500
In-Reply-To: <1455008277-8312-2-git-send-email-raveendra.padasalagi@broadcom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Richardson <jonathar@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

On Tuesday 09 February 2016 14:27:55 Raveendra Padasalagi wrote:
> +
> +One of the below 2 property is mandatory.
> +- ts_syscon: handler of syscon node defining physical base address
> +  of the controller and length of memory mapped region.
> +  If this property is selected please make sure MFD_SYSCON config
> +  is enabled in the defconfig file.
> +or
> +- reg: physical base address of the controller and length of memory
> +  mapped region.
> +
>  - clocks:  The clock provided by the SOC to driver the tsc
>  - clock-name:  name for the clock
>  - interrupts: The touchscreen controller's interrupt
> @@ -54,12 +62,16 @@ Optional properties:
>  - touchscreen-inverted-y: Y axis is inverted (boolean)
>  
>  Example:
> +       ts_adc_syscon: ts_adc_syscon@0x180a6000 {
> +               compatible = "syscon";
> +               reg = <0x180a6000 0xc30>;
> +       };
>  
>         touchscreen: tsc@0x180A6000 {
>                 compatible = "brcm,iproc-touchscreen";
>                 #address-cells = <1>;
>                 #size-cells = <1>;
> -               reg = <0x180A6000 0x40>;
> +               syscon = <&ts_adc_syscon>;
>                 clocks = <&adc_clk>;
>                 clock-names = "tsc_clk";
>                 interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;

This doesn't seem right: For one thing, it's an incompatible binding
change which you should try to avoid.

Worse, the syscon has a name indicating that it really has a particular
function, but the name is completely generic (just "syscon"). Please
add a specific compatible string identifying the device that owns
the registers, and put any other associated properties (clocks,
interrupts, ...) that are for that device in general rather than just
the touchscreen in there.

Your changelog text fails to describe why you do this change in
the first place, and why you can't do it in a backward-compatible
way, so please rewrite that text.

	Arnd
