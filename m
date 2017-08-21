From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 2/2] dt-bindings: new binding for ps/2 gpio devices
Date: Mon, 21 Aug 2017 14:19:52 -0500
Message-ID: <CAL_JsqJFus4hQE-cBoSxBoB1ZtGSH9Am4kFs0_e_-2c=Qz2UNw@mail.gmail.com>
References: <20170821133112.22276-1-danilokrummrich@dk-develop.de> <20170821133112.22276-3-danilokrummrich@dk-develop.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170821133112.22276-3-danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Danilo Krummrich <danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Aug 21, 2017 at 8:31 AM, Danilo Krummrich
<danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org> wrote:
> The PS/2 gpio device binding defines the gpio pins (data and clock)
> as well as the interrupt which should be used to drive the ps/2 bus.
> It is expected to get an interrupt on the falling edge of the clock
> line.
>
> Also it can be configured whether the host should support writing to
> the device.
>
> Signed-off-by: Danilo Krummrich <danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org>
> ---
>  .../devicetree/bindings/serio/ps2-gpio.txt         | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt
>
> diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.txt b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
> new file mode 100644
> index 000000000000..83e05ea05883
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
> @@ -0,0 +1,22 @@
> +Device-Tree binding for ps/2 gpio device
> +
> +Required properties:
> +       - compatible = "ps2-gpio"
> +       - gpios: data and clock gpio

Doesn't match the example.

> +       - interrupts: Should trigger on the falling edge of the clock line.
> +
> +Optional properties:
> +       - write-enable: Indicates whether write function is provided
> +       to serio device. Possibly providing the write fn will not work, because
> +       of the tough timing requirements.
> +
> +Example nodes:
> +
> +ps2@0 {
> +       compatible = "ps2-gpio";
> +       interrupt-parent = <&gpio>;
> +       interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
> +       data-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
> +       clk-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
> +       write-enable;
> +};
> --
> 2.14.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
