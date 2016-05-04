From: Rob Herring <robh@kernel.org>
Subject: Re: Input: add Atmel Atmegaxx captouch driver
Date: Wed, 4 May 2016 08:51:23 -0500
Message-ID: <20160504135123.GA4567@rob-hp-laptop>
References: <1462295611-49684-1-git-send-email-grundler@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49153 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbcEDNv2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 May 2016 09:51:28 -0400
Content-Disposition: inline
In-Reply-To: <1462295611-49684-1-git-send-email-grundler@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, Hung-yu Wu <hywu@google.com>

On Tue, May 03, 2016 at 10:13:31AM -0700, Grant Grundler wrote:
> Add I2C driver for AtmegaXX capacitive touch device.
> 
> Signed-off-by: Hung-yu Wu <hywu@google.com>
> Signed-off-by: Grant Grundler <grundler@chromium.org>
> ---
>  .../bindings/input/atmel,atmegaxx_captouch.txt     |  34 +++

It is generally preferred that bindings are a separate patch.

>  drivers/input/misc/Kconfig                         |  11 +
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/atmegaxx_captouch.c             | 278 +++++++++++++++++++++
>  4 files changed, 324 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/atmel,atmegaxx_captouch.txt
>  create mode 100644 drivers/input/misc/atmegaxx_captouch.c
> 
> For those that like to know how sausage is made, ChromeOS code review history here:
>    https://chromium-review.googlesource.com/339950
> 
> Driver was tested with prototype HW and it reliably reports events correctly.
> Manual testing was just using "evtest /dev/input/event0" and watch for events.
> 
> diff --git a/Documentation/devicetree/bindings/input/atmel,atmegaxx_captouch.txt b/Documentation/devicetree/bindings/input/atmel,atmegaxx_captouch.txt
> new file mode 100644
> index 0000000..07a4b0b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/atmel,atmegaxx_captouch.txt
> @@ -0,0 +1,34 @@
> +Device tree bindings for Atmel AtmegaXX capacitive touch sensor
> +
> +The node for this device must be a child of a I2C controller node, as the
> +device communicates via I2C.
> +
> +Required properties:
> +
> +	compatible:	Must be "atmel,atmegaxx_captouch".

No wildcards in the compatible strings. Use the specific devices.

Also, use hyphen rather than underscore. However, if the device is only 
a touch controller, then '_captouch' is not needed. The part number is 
sufficient to identify the device.

> +	reg:		The I2C slave address of the device.
> +	interrupts:	Property describing the interrupt line the device
> +			is connected to. The device only has one interrupt
> +			source.
> +	linux,keycodes:	Specifies an array of numeric keycode values to
> +			be used for reporting button presses. The array can
> +			contain up to 8 entries.
> +
> +Optional properties:
> +
> +	autorepeat:	Enables the Linux input system's autorepeat
> +			feature on the input device.
> +
> +Example:
> +
> +	atmegaxx_captouch@51 {

atmegaxx@51 (with actual part number)

> +		compatible = "atmel,atmegaxx_captouch";
> +		reg = <0x51>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <67 IRQ_TYPE_EDGE_FALLING>;
> +		linux,keycodes = <BTN_0>, <BTN_1>,
> +			<BTN_2>, <BTN_3>,
> +			<BTN_4>, <BTN_5>,
> +			<BTN_6>, <BTN_7>;
> +		autorepeat;
> +	};
