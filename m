From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Fri, 18 Mar 2016 16:04:50 -0500
Message-ID: <20160318210450.GA28913@rob-hp-laptop>
References: <1458031457-1315-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56729 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbcCRVE6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Mar 2016 17:04:58 -0400
Content-Disposition: inline
In-Reply-To: <1458031457-1315-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jeffrey.lin" <yajohn@gmail.com>
Cc: pawel.moll@arm.com, mark.rutland@arm.com, jc+devicetree@hellion.org.uk, galak@codeaurora.org, treding@nvidia.com, inki.dae@samsung.com, djkurtz@chromium.org, dusonlin@emc.com.tw, ajaykumar.rs@samsung.com, jeesw@melfas.com, dmitry.torokhov@gmail.com, rydberg@euromail.se, grant.likely@linaro.org, bleung@chromium.org, scott.liu@emc.com.tw, jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Mar 15, 2016 at 04:44:17PM +0800, jeffrey.lin wrote:
> Raydium I2C touch driver.
> 
> Signed-off-by: jeffrey.lin <jeffrey.lin@rad-ic.com>
> ---
>  .../devicetree/bindings/input/raydium_i2c_ts.txt   |  23 +
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +

It is generally preferred to split bindings from driver changes.

>  drivers/input/touchscreen/Kconfig                  |  12 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/raydium_i2c_ts.c         | 932 +++++++++++++++++++++
>  5 files changed, 969 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/raydium_i2c_ts.txt
>  create mode 100644 drivers/input/touchscreen/raydium_i2c_ts.c
> 
> diff --git a/Documentation/devicetree/bindings/input/raydium_i2c_ts.txt b/Documentation/devicetree/bindings/input/raydium_i2c_ts.txt
> new file mode 100644
> index 0000000..329864d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/raydium_i2c_ts.txt
> @@ -0,0 +1,23 @@
> +Raydium I2C touchscreen
> +
> +Required properties:
> +- compatible:
> +    "raydium,rm31100"
> +
> +- reg: The I2C address of the device
> +- interrupts: interrupt to which the chip is connected
> +    See ../interrupt-controller/interrupts.txt
> +Optional property:
> + - avdd-supply	: Analog power supply needed to power device
> + - vccio-supply: IO Power source
> +
> +Example:
> +
> +	raydium_i2c@0x39 {

touchscreen@39

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>


> +		compatible = "raydium,rm31100";
> +		avdd-supply = <&pm8226_l19>;
> +		vccio-supply = <&pm8226_lvs1>;
> +		reg = <0x39>;
> +		interrupt-parent = <&gpio>;
> +		interrupts = <0x0 IRQ_TYPE_EDGE_FALLING>;
> +	};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index af49e0f..5b6224b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -126,6 +126,7 @@ radxa	Radxa
>  raidsonic	RaidSonic Technology GmbH
>  ralink	Mediatek/Ralink Technology Corp.
>  ramtron	Ramtron International
> +raydium Raydium Semiconductor Corp.
>  realtek Realtek Semiconductor Corp.
>  renesas	Renesas Electronics Corporation
>  ricoh	Ricoh Co. Ltd.

