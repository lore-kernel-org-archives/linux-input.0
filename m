From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] Documentation: Device Tree binding information for
 gpio-joy driver
Date: Fri, 6 Feb 2015 10:53:36 +0000
Message-ID: <20150206105336.GA10324@leverpostej>
References: <1423215122-19947-1-git-send-email-hans.holmberg@intel.com>
 <1423215122-19947-2-git-send-email-hans.holmberg@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423215122-19947-2-git-send-email-hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans Holmberg <hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Feb 06, 2015 at 09:32:01AM +0000, Hans Holmberg wrote:
> This document describes the Device Tree bindings for the gpio-joy
> driver.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/input/gpio-joy.txt         | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/gpio-joy.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-joy.txt b/Documentation/devicetree/bindings/input/gpio-joy.txt
> new file mode 100644
> index 0000000..ef8ad09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/gpio-joy.txt
> @@ -0,0 +1,29 @@
> +Device-Tree bindings for input/joystick/gpio_joy.c joystick driver
> +
> +This driver can be used for connecting i.e. C64 and Atari joysticks.

The binding should be for a class of hardware, not for a driver. Please
describe the class of hardware the binding represents, and remove
references to the Linux driver.

> +Required properties:
> +	- compatible    = "gpio-joy";

That does not strike me as a very informative compatible string. At the
least, s/joy/joystick/.

> +
> +	- left-gpio     : gpio connected to the "left" joystick signal
> +	- right-gpio    : gpio connected to the "right" joystick signal
> +	- up-gpio       : gpio connected to the "up" joystick signal
> +	- down-gpio     : gpio connected to the "down" joystick signal
> +	- button-gpio   : gpio connected to the "button" joystick signal

Only one button?

Thanks,
Mark.

> +		See OF device-tree gpio specification.
> +
> +Optional properties:
> +	- debounce-interval-ms: debounce interval in milliseconds for connected pins
> +		Default is 10 milliseconds
> +
> +Example node:
> +
> +joystick {
> +	compatible = "gpio-joy";
> +	left-gpio = <&gpio 24 GPIO_ACTIVE_LOW>;
> +	right-gpio = <&gpio 10 GPIO_ACTIVE_LOW>;
> +	up-gpio	= <&gpio 3 GPIO_ACTIVE_LOW>;
> +	down-gpio = <&gpio 27 GPIO_ACTIVE_LOW>;
> +	button-gpio = <&gpio 2 GPIO_ACTIVE_LOW>;
> +};
> +
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
