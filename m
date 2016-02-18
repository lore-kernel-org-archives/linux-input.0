From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] input: cygnus-update touchscreen dt node document
Date: Thu, 18 Feb 2016 08:36:17 -0600
Message-ID: <20160218143617.GH9654@rob-hp-laptop>
References: <1455702226-20599-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1455702226-20599-2-git-send-email-raveendra.padasalagi@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455702226-20599-2-git-send-email-raveendra.padasalagi@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Richardson <jonathar@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Anup Patel <anup.patel@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-input@vger.kernel.org

On Wed, Feb 17, 2016 at 03:13:44PM +0530, Raveendra Padasalagi wrote:
> In Cygnus SOC touch screen controller registers are shared
> with ADC and flex timer. Using readl/writel could lead to
> race condition. So touch screen driver is enhanced to support
> 
> 1. If touchscreen register's are not shared. Register access
> is handled through readl/writel if "brcm,iproc-touchscreen"
> compatible is provided in touchscreen dt node. This will help
> for future SOC's if comes with dedicated touchscreen IP register's.
> 
> 2. If touchscreen register's are shared with other IP's, register
> access is handled through syscon framework API's to take care of
> mutually exclusive access. This feature can be enabled by selecting
> "brcm,iproc-touchscreen-syscon" compatible string in the touchscreen
> dt node.
> 
> Hence touchscreen dt node bindings document is updated to take care
> of above changes in the touchscreen driver.
> 
> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  .../input/touchscreen/brcm,iproc-touchscreen.txt   | 57 +++++++++++++++++++---
>  1 file changed, 51 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
> index 34e3382..f530c25 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
> @@ -1,12 +1,30 @@
>  * Broadcom's IPROC Touchscreen Controller
>  
>  Required properties:
> -- compatible: must be "brcm,iproc-touchscreen"
> -- reg: physical base address of the controller and length of memory mapped
> -  region.
> +- compatible: should be one of
> +        "brcm,iproc-touchscreen"
> +        "brcm,iproc-touchscreen-syscon"

More specific and this is not how you do syscon. Either the block is or 
isn't. You can't have it both ways.

> +- ts_syscon: if "brcm,iproc-touchscreen-syscon" compatible string
> +  is selected then "ts_syscon" is mandatory or else not required.
> +  The "ts_syscon" is handler of syscon node defining physical base
> +  address of the controller and length of memory mapped region.
> +  If this property is selected please make sure MFD_SYSCON config
> +  is enabled in the defconfig file.
> +- reg: if "brcm,iproc-touchscreen" compatible string is selected
> +  then "reg" property is mandatory or else not required.
> +  The "reg" should be physical base address of the controller and
> +  length of memory mapped region.

I thought every chip to date is a syscon. Add reg support when you 
actually need it.

>  - clocks:  The clock provided by the SOC to driver the tsc
>  - clock-name:  name for the clock
>  - interrupts: The touchscreen controller's interrupt
> +- address-cells: Specify the number of u32 entries needed in child nodes.
> +                 Should set to 1. This property is mandatory when
> +                 "brcm,iproc-touchscreen-syscon" compatible string is selected
> +                 or else not required.
> +- size-cells: Specify number of u32 entries needed to specify child nodes size
> +              in reg property. Should set to 1.This property is mandatory when
> +              "brcm,iproc-touchscreen-syscon" compatible string is selected or
> +              else not required.
>  
>  Optional properties:
>  - scanning_period: Time between scans. Each step is 1024 us.  Valid 1-256.
> @@ -53,13 +71,40 @@ Optional properties:
>  - touchscreen-inverted-x: X axis is inverted (boolean)
>  - touchscreen-inverted-y: Y axis is inverted (boolean)
>  
> -Example:
> +Example 1: An example of touchscreen node with "brcm,iproc-touchscreen-syscon"
> +           compatible string.
> +
> +	ts_adc_syscon: ts_adc_syscon@0x180a6000 {
> +		compatible = "syscon";
> +		reg = <0x180a6000 0xc30>;
> +	};
>  
>  	touchscreen: tsc@0x180A6000 {

Drop the '0x' and the node name should be touchscreen, not tsc.

> -		compatible = "brcm,iproc-touchscreen";
> +		compatible = "brcm,iproc-touchscreen-syscon";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -		reg = <0x180A6000 0x40>;
> +		ts_syscon = <&ts_adc_syscon>;
> +		clocks = <&adc_clk>;
> +		clock-names = "tsc_clk";
> +		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> +

> +		scanning_period = <5>;
> +		debounce_timeout = <40>;
> +		settling_timeout = <7>;
> +		touch_timeout = <10>;
> +		average_data = <5>;
> +		fifo_threshold = <1>;

New properties?

> +		/* Touchscreen is rotated 180 degrees. */
> +		touchscreen-inverted-x;
> +		touchscreen-inverted-y;
> +	};
> +
> +Example 2: An example of touchscreen node with "brcm,iproc-touchscreen"
> +          compatible string.
> +
> +	touchscreen: tsc@0x180A6000 {
> +		compatible = "brcm,iproc-touchscreen";
> +		reg = <0x180a6000 0x40>;
>  		clocks = <&adc_clk>;
>  		clock-names = "tsc_clk";
>  		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 1.9.1
> 
