From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] Documentation: devicetree: bindings: add bindings
 doc for ar1021 driver
Date: Thu, 13 Apr 2017 15:40:41 -0500
Message-ID: <20170413204041.lqtqfc24vueo5fbj@rob-hp-laptop>
References: <1491906479-17639-1-git-send-email-martin.kepplinger@ginzinger.com>
 <1491906479-17639-2-git-send-email-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1491906479-17639-2-git-send-email-martin.kepplinger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Kepplinger <martin.kepplinger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Apr 11, 2017 at 12:27:58PM +0200, Martin Kepplinger wrote:
> Add a simple binding document highlighting the supported devices and
> I2C bus address.

"dt-bindings: input: ..." for the subject please.

> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
> ---
>  .../devicetree/bindings/input/touchscreen/ar1021.txt     | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ar1021.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ar1021.txt b/Documentation/devicetree/bindings/input/touchscreen/ar1021.txt
> new file mode 100644
> index 0000000..87a8c72
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ar1021.txt
> @@ -0,0 +1,16 @@
> +* Microchip AR1020 and AR1021 touchscreen interface (I2C)
> +
> +Required properties:
> +- compatible		: use "microchip,ar1020-i2c" or "microchip,ar1021-i2c"
> +- reg			: I2C slave address
> +- interrupt-parent	: the phandle for the interrupt controller
> +- interrupts		: touch controller interrupt
> +
> +Example:
> +
> +	ar1020: ar1020@4d {

touchscreen@4d

> +		compatible = "microchip,ar1020-i2c";
> +		reg = <0x4d>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
