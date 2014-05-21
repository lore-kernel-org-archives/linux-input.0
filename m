From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2] Input: mcs_touchkey: add device tree binding document
Date: Wed, 21 May 2014 14:53:06 +0100
Message-ID: <20140521135306.GH17827@leverpostej>
References: <537C3EFD.8040601@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:58530 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751429AbaEUNxN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 May 2014 09:53:13 -0400
Content-Disposition: inline
In-Reply-To: <537C3EFD.8040601@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

On Wed, May 21, 2014 at 06:51:57AM +0100, Beomho Seo wrote:
> This patch add simple device tree bindings to
> MELFAS MCS5000/5080 controller.
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
>  .../devicetree/bindings/input/mcs-touchkey.txt     |   25 ++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/mcs-touchkey.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/mcs-touchkey.txt b/Documentation/devicetree/bindings/input/mcs-touchkey.txt
> new file mode 100644
> index 0000000..8364799
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/mcs-touchkey.txt
> @@ -0,0 +1,25 @@
> +* mcs_touchkey MELFAS MCS5000/5080 controller
> +
> +Required properties:
> +- compatible: must be "mcs5000_touchkey" or "mcs5080_touchkey"

NAK. These should be in "$VENDOR,$DEVICE" format (e.g. "melfas,mcs5000").

It looks like "melfas" is already used, but is undocumented. Please add
it to vendor-prefixes.txt.

> +- reg : I2C address of the chip
> +- interrupts: interrupt to which the chip is connected
> +- key_maxval: size of keycode table

Surely this is already implicit in the size of the linux,code property
data?

This is superfluous and broken. Please get rid of it.

> +- code: key code for this device

This doesn't match the example or driver. If this is a standard
property, please refer to a definition of the format.

> +
> +Example:
> +
> +	i2c_touch_key: i2c-gpio-0 {
> +	       /* ... */
> +
> +	       touch_key@20 {
> +		       compatible = "mcs5080_touchkey";
> +		       reg = <0x20>;
> +		       interrupt-patrent = <gpj0>;
> +		       key_maxval = <2>;
> +		       linux, code = <0x0000009e
> +			              0x000000a9>;

Random spacing?

Please bracket individual list elements.

Cheers,
Mark.
