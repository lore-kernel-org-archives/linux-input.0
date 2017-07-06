From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: input: Add Device tree bindings for
 Goodix GTx5 series touchscreen controller
Date: Thu, 6 Jul 2017 09:56:57 -0500
Message-ID: <20170706145657.o4lxj7w5wbai5uks@rob-hp-laptop>
References: <20170629021327.GA16992@andrew-dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35089 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdGFO5A (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Jul 2017 10:57:00 -0400
Content-Disposition: inline
In-Reply-To: <20170629021327.GA16992@andrew-dell>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wang Yafei <wangyafei@goodix.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, andrew@goodix.com, mouse@goodix.com

On Thu, Jun 29, 2017 at 10:13:27AM +0800, Wang Yafei wrote:
> Signed-off-by: Wang Yafei <wangyafei@goodix.com>
> ---
> since v1:
>  - Change device properties name
>  - Modified irq property format
>  - Modified linux,keycode format
>  - Modified panel configuration property name
>  - Remove time-delay properties
> ---
>  .../bindings/input/touchscreen/goodix-gtx5.txt     | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/goodix-gtx5.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix-gtx5.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix-gtx5.txt
> new file mode 100644
> index 0000000..9bb82c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix-gtx5.txt
> @@ -0,0 +1,61 @@
> +Device tree bindings for Goodix GTx5 series touchscreen controller
> +
> +Required properties:
> +
> +- compatible		: Should be "goodix,gt7589"
> +				 or "goodix,gt8589"
> +			         or "goodix,gt9589"
> +- reg			: I2C address of the chip. Should be 0x5d or 0x14
> +- interrupt-parent	: Interrupt controller to which the chip is connected
> +- interrupts		: Interrupt to which the chip is connected
> +- touchscreen-size-x	: horizontal resolution of touchscreen(in pixels)
> +- touchscreen-size-y	: vertical resolution of touchscreen(in pixels)
> +- touchscreen-max-id	: panel supported max touch number.
> +- touchscreen-max-w	: panel max width value.

Just "see touchscreen.txt" is fine for the description of common 
properties.

> +
> +Optional properties:
> +- reset-gpios		  : reset gpio.
> +- touchscreen-swapped-x-y : swap  x/y axis coordinates.
> +- linux,keycodes	  : Specifies an array of numeric keycode values to
> +			    be used for reporting button presses. The array can
> +			    contain up to 8 entries.
> +- goodix,normal-cfg-X	  : touch device normal config data, this config data is
> +		            touchpanel manufacturer related. normal-cfg-X, X
> +			    represent for a panel manufacturer, X is less than 10.
> +- vtouch-supply		  : power supply for the touch device.
> +
> +Example:
> +i2c@00000000 {
> +	/* ... */
> +
> +	gt8589@14 {
> +		compatible = "goodix,gt8589";
> +		reg = <0x14>;
> +		interrupt-parent = <&msm_gpio>;
> +		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> +		vtouch-supply = <&pm8916_l15>;
> +		reset-gpios = <&msm_gpio 12 0x0>;
> +		touchscreen-max-id = <10>;
> +		touchscreen-size-x = <400>;
> +		touchscreen-size-y = <400>;
> +		touchscreen-max-w = <400>;
> +		linux,keycodes = <KEY_HOMEPAGE>, <KEY_MENU>, <KEY_BACK>;
> +		goodix,normal-cfg-0 = [
> +			02 00 00 09 09 01 07 02 00 00 00 00 01 00 3C 00 07 07
> +			00 00 00 00 00 00 40 01 40 01 C8 00 96 00 F4 01 F4 01
> +			F4 01 20 01 11 0A 0A 03 14 14 14 14 0A 0C 01 01 11 11
> +			11 00 14 14 14 14 14 14 14 14 14 00 00 0F 00 00 00 00
> +			00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +			00 00 00 00 00 00 00 00 00 00 11 09 10 00 31 32 33 34
> +			00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 CA 64 00
> +			00 00 00 00 00 00 09 00 13 00 00 00 00 00 00 00 00 00
> +			50 B0 19 00 19 00 05 00 00 00 00 0A 05 00 00 00 00 00
> +			01 00 FF 00 0B 06 0D 02 FF 04 05 03 07 01 08 0A 0E 11
> +			0F 10 09 13 0C 16 17 14 18 12 19 15 1D 1E 1C 1F 1B 20
> +			1A 2A 29 28 25 2B 27 21 FF 24 22 2C 26 23 FF 00 00 00
> +			00 00 00 00 00 00 00 00 00 00 00 00 80 80 80 80 80 80
> +			80 80 80 80 80 80 80 80 80 80 9F 22 01 AE];
> +		};
> +	};
> +}
> +
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
