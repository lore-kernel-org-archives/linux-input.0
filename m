From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/5] input: mouse: Add DT bindings for GPIO mice
Date: Wed, 20 Sep 2017 15:53:05 -0500
Message-ID: <20170920205305.4qs44ymhmdcpjpov@rob-hp-laptop>
References: <20170917111445.30880-1-linus.walleij@linaro.org>
 <20170917111445.30880-4-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36580 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbdITUxH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 20 Sep 2017 16:53:07 -0400
Content-Disposition: inline
In-Reply-To: <20170917111445.30880-4-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, devicetree@vger.kernel.org

On Sun, Sep 17, 2017 at 01:14:43PM +0200, Linus Walleij wrote:
> This adds DT bindings for simple mice attached to GPIO lines.
> As the properties are very general and pertains to all mice I
> can think of, we use very generic names for the 4-7 GPIO lines,
> "up", "down" etc.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> This patch is inspired by the existance of a GPIO mouse driver
> with no in-kernel users.

In userspace? Doesn't seem like common h/w or that it would work well.

> ---
>  .../devicetree/bindings/input/gpio-mouse.txt       | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/gpio-mouse.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-mouse.txt b/Documentation/devicetree/bindings/input/gpio-mouse.txt
> new file mode 100644
> index 000000000000..82622a439745
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/gpio-mouse.txt
> @@ -0,0 +1,32 @@
> +Device-Tree bindings for GPIO attached mice
> +
> +This simply uses standard GPIO handles to define a simple mouse connected
> +to 4-7 GPIO lines.

Presumably we have to have 1 button, so 5-7 lines?

> +
> +Required properties:
> +	- compatible: must be "gpio-mouse"
> +	- scan-interval: The scanning interval in milliseconds

Add a unit suffix. Unless we can gain something sharing this with other 
input bindings.

> +	- up-gpios: GPIO line phandle to the line indicating "up"
> +	- down-gpios: GPIO line phandle to the line indicating "down"
> +	- left-gpios: GPIO line phandle to the line indicating "left"
> +	- right-gpios: GPIO line phandle to the line indicating "right"
> +
> +Optional properties:
> +	- button-left-gpios: GPIO line handle to the left mouse button
> +	- button-middle-gpios: GPIO line handle to the middle mouse button
> +	- button-right-gpios: GPIO line handle to the right mouse button
> +Example:
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +gpio-mouse {
> +	compatible = "gpio-keys";

copy-n-paste error.

> +	scan-interval = <50>;
> +	up-gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
> +	down-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
> +	left-gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
> +	right-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> +	button-left-gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
> +	button-middle-gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
> +	button-right-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
> +};
> -- 
> 2.13.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
