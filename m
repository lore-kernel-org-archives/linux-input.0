From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt: add Atmel Captouch bindings
Date: Sat, 14 May 2016 09:52:05 -0500
Message-ID: <20160514145205.GA31009@rob-hp-laptop>
References: <1462932469-122552-1-git-send-email-grundler@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462932469-122552-1-git-send-email-grundler@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree <devicetree@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Hung-yu Wu <hywu@google.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>
List-Id: linux-input@vger.kernel.org

On Tue, May 10, 2016 at 07:07:48PM -0700, Grant Grundler wrote:
> From: Daniel Hung-yu Wu <hywu@google.com>
> 
> Add binding for Atmel Capacitive Touch Button device.
> 
> Signed-off-by: Daniel Hung-yu Wu <hywu@google.com>
> Signed-off-by: Grant Grundler <grundler@chromium.org>
> ---
>  .../devicetree/bindings/input/atmel,captouch.txt   | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/atmel,captouch.txt
> 
> I haven't posted the corresponding device driver and dtsi changes yet but will shortly.
> 
> V2: split Documentation/devicetree/bindings from driver patch
>     rename "atmel,atmegaxx_captouch" to "atmel,captouch" since it's irrelevant
>            which controller implements the register set/controller.

Is there any notion of firmware versions though?

> 
> V1: posted https://lkml.org/lkml/2016/5/3/613
> 
> diff --git a/Documentation/devicetree/bindings/input/atmel,captouch.txt b/Documentation/devicetree/bindings/input/atmel,captouch.txt
> new file mode 100644
> index 0000000..405d287
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/atmel,captouch.txt
> @@ -0,0 +1,34 @@
> +Device tree bindings for Atmel AtmegaXX capacitive touch sensor
> +
> +The node for this device must be a child of a I2C controller node, as the
> +device communicates via I2C.
> +
> +Required properties:
> +
> +	compatible:	Must be "atmel,captouch".
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
> +	atmel_captouch@51 {

No underscores in node names please.

> +		compatible = "atmel,captouch";
> +		reg = <0x51>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <67 IRQ_TYPE_EDGE_FALLING>;
> +		linux,keycodes = <BTN_0>, <BTN_1>,
> +			<BTN_2>, <BTN_3>,
> +			<BTN_4>, <BTN_5>,
> +			<BTN_6>, <BTN_7>;
> +		autorepeat;
> +	};
> -- 
> 2.1.2
> 
