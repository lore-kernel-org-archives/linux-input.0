From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/4] Input: tsc2004 - Document ts2004 dt bindings
Date: Mon, 2 Nov 2015 09:19:50 -0600
Message-ID: <CAL_JsqKpbrWcHj4eubWMAjtVRHE8TTN_qC5S=J7qzcf8khpzng@mail.gmail.com>
References: <1446252086-24334-1-git-send-email-mwelling@ieee.org> <1446252086-24334-5-git-send-email-mwelling@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35692 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbbKBPUN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Nov 2015 10:20:13 -0500
In-Reply-To: <1446252086-24334-5-git-send-email-mwelling@ieee.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, Oct 30, 2015 at 7:41 PM, Michael Welling <mwelling@ieee.org> wrote:
> Adds documentation for the devicetree bindings of the new tsc2004 driver.
>
> Signed-off-by: Michael Welling <mwelling@ieee.org>
> ---
>  .../bindings/input/touchscreen/tsc2005.txt         | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> index 09089a6..27c6082 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> @@ -1,3 +1,42 @@
> +* Texas Instruments tsc2004 touchscreen controller
> +
> +Required properties:
> + - compatible                : "ti,tsc2004"
> + - interrupts                : IRQ specifier
> + - vio-supply                 : Regulator specifier

reg property?

> +
> +Optional properties:
> + - reset-gpios               : GPIO specifier
> + - ti,x-plate-ohms           : integer, resistance of the touchscreen's X plates
> +                               in ohm (defaults to 280)
> + - ti,esd-recovery-timeout-ms : integer, if the touchscreen does not respond after
> +                               the configured time (in milli seconds), the driver
> +                               will reset it. This is disabled by default.
> + - properties defined in touchscreen.txt
> +
> +Example:
> +
> +&i2c3 {
> +       tsc2004@48 {
> +               compatible = "ti,tsc2004";
> +               reg = <0x48>;
> +               vio-supply = <&vio>;
> +
> +               reset-gpios = <&gpio4 8 GPIO_ACTIVE_HIGH>;
> +               interrupts-extended = <&gpio1 27 IRQ_TYPE_EDGE_RISING>;
> +
> +               touchscreen-fuzz-x = <4>;
> +               touchscreen-fuzz-y = <7>;
> +               touchscreen-fuzz-pressure = <2>;
> +               touchscreen-size-x = <4096>;
> +               touchscreen-size-y = <4096>;
> +               touchscreen-max-pressure = <2048>;
> +
> +               ti,x-plate-ohms = <280>;
> +               ti,esd-recovery-timeout-ms = <8000>;
> +       };
> +}
> +
>  * Texas Instruments tsc2005 touchscreen controller
>
>  Required properties:
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
