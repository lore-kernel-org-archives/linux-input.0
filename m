From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/5 v2] input: mouse: Add DT bindings for GPIO mice
Date: Tue, 26 Sep 2017 09:54:46 -0700
Message-ID: <20170926165446.GC14833@dtor-ws>
References: <20170925163430.22397-1-linus.walleij@linaro.org>
 <20170925163430.22397-3-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35048 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969223AbdIZQyt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Sep 2017 12:54:49 -0400
Content-Disposition: inline
In-Reply-To: <20170925163430.22397-3-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>
Cc: linux-input@vger.kernel.org, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, devicetree@vger.kernel.org

On Mon, Sep 25, 2017 at 06:34:28PM +0200, Linus Walleij wrote:
> This adds DT bindings for simple mice attached to GPIO lines.
> As the properties are very general and pertains to all mice I
> can think of, we use very generic names for the 4-7 GPIO lines,
> "up", "down" etc.
> 
> Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Adding Rob. I am good with the patches unless there is objection to the
binding...

> ---
> ChangeLog v1->v2:
> - Collect Hand-Christian's ACK
> - Uses 5-7 lines rather than 4-7 lines
> - Add suffix "-ms" to the scan interval property
> - Fix compatible string in the example
> ---
>  .../devicetree/bindings/input/gpio-mouse.txt       | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/gpio-mouse.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-mouse.txt b/Documentation/devicetree/bindings/input/gpio-mouse.txt
> new file mode 100644
> index 000000000000..519510a11af9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/gpio-mouse.txt
> @@ -0,0 +1,32 @@
> +Device-Tree bindings for GPIO attached mice
> +
> +This simply uses standard GPIO handles to define a simple mouse connected
> +to 5-7 GPIO lines.
> +
> +Required properties:
> +	- compatible: must be "gpio-mouse"
> +	- scan-interval-ms: The scanning interval in milliseconds
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
> +	compatible = "gpio-mouse";
> +	scan-interval-ms = <50>;
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

-- 
Dmitry
