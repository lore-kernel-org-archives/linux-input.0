From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: melfas_mip4 - add devicetree binding documentations
Date: Fri, 7 Oct 2016 16:29:15 -0700
Message-ID: <20161007232915.GB8473@dtor-ws>
References: <1475736334-5087-1-git-send-email-jeesw@melfas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35224 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbcJGX3T (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2016 19:29:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id t25so3517868pfg.2
        for <linux-input@vger.kernel.org>; Fri, 07 Oct 2016 16:29:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1475736334-5087-1-git-send-email-jeesw@melfas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sangwon Jee <jeesw@melfas.com>
Cc: linux-input@vger.kernel.org

On Thu, Oct 06, 2016 at 03:45:34PM +0900, Sangwon Jee wrote:
> Add devicetree binding documentations.
> 
> Signed-off-by: Sangwon Jee <jeesw@melfas.com>

Applied, thank you.

> ---
>  .../bindings/input/touchscreen/melfas_mip4.txt      | 21 +++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt         |  1 +
>  2 files changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/melfas_mip4.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/melfas_mip4.txt b/Documentation/devicetree/bindings/input/touchscreen/melfas_mip4.txt
> new file mode 100644
> index 0000000..4e4dfbe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/melfas_mip4.txt
> @@ -0,0 +1,21 @@
> +* MELFAS MIP4 Touchscreen
> +
> +Required properties:
> +- compatible: must be "melfas,mip4_ts"
> +- reg: I2C slave address of the chip (0x48 or 0x34)
> +- interrupt-parent: interrupt controller to which the chip is connected
> +- interrupts: interrupt to which the chip is connected
> +
> +Optional properties:
> +- ce-gpio: GPIO connected to the CE(chip enable) pin of the chip
> +
> +Example:
> +	i2c@00000000 {
> +		melfas_mip4_ts@48 {
> +			compatible = "melfas,mip4_ts";
> +			reg = <0x48>;
> +			interrupt-parent = <&gpio>;
> +			interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
> +			ce-gpio = <&gpio 0 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 99029cf..1457fd4 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -143,6 +143,7 @@ marvell	Marvell Technology Group Ltd.
>  maxim	Maxim Integrated Products
>  mediatek	MediaTek Inc.
>  melexis	Melexis N.V.
> +melfas	MELFAS Inc.
>  merrii	Merrii Technology Co., Ltd.
>  micrel	Micrel Inc.
>  microchip	Microchip Technology Inc.
> -- 
> 1.9.1
> 

-- 
Dmitry
