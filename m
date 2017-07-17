From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Input: add support for HiDeep touchscreen
Date: Mon, 17 Jul 2017 12:31:53 -0500
Message-ID: <20170717173153.5el4yle7szlzvccx@rob-hp-laptop>
References: <1499235588-32219-1-git-send-email-anthony.kim@hideep.com>
 <1499837054-4659-1-git-send-email-anthony.kim@hideep.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1499837054-4659-1-git-send-email-anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anthony Kim <ktyrun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anthony Kim <anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jul 12, 2017 at 02:24:14PM +0900, Anthony Kim wrote:
> The HiDeep touchscreen device is a capacitive multi-touch controller
> mainly for multi-touch supported devices use. It use I2C interface for
> communication to IC and provide axis X, Y, Z locations for ten finger
> touch through input event interface to userspace.
> 
> It support the Crimson and the Lime two type IC. They are different
> the number of channel supported and FW size. But the working protocol
> is same.
> 
> Signed-off-by: Anthony Kim <anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/hideep.txt          |  37 +
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  drivers/input/touchscreen/Kconfig                  |  32 +
>  drivers/input/touchscreen/Makefile                 |   2 +
>  drivers/input/touchscreen/hideep.h                 | 329 ++++++++
>  drivers/input/touchscreen/hideep_core.c            | 924 +++++++++++++++++++++
>  drivers/input/touchscreen/hideep_dbg.c             | 405 +++++++++
>  drivers/input/touchscreen/hideep_dbg.h             |  24 +
>  drivers/input/touchscreen/hideep_isp.c             | 584 +++++++++++++
>  drivers/input/touchscreen/hideep_isp.h             |  96 +++
>  drivers/input/touchscreen/hideep_sysfs.c           | 249 ++++++
>  11 files changed, 2683 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hideep.txt
>  create mode 100644 drivers/input/touchscreen/hideep.h
>  create mode 100644 drivers/input/touchscreen/hideep_core.c
>  create mode 100644 drivers/input/touchscreen/hideep_dbg.c
>  create mode 100644 drivers/input/touchscreen/hideep_dbg.h
>  create mode 100644 drivers/input/touchscreen/hideep_isp.c
>  create mode 100644 drivers/input/touchscreen/hideep_isp.h
>  create mode 100644 drivers/input/touchscreen/hideep_sysfs.c
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/hideep.txt b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> new file mode 100644
> index 0000000..5eb8c1d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> @@ -0,0 +1,37 @@
> +* HiDeep Finger and Stylus touchscreen controller
> +
> +Required properties:
> +- compatible		: must be "hideep,hideep_ts".

See my reply on previous version.

> +- reg			: I2C slave address, (e.g. 0x6C).
> +- interrupt-parent : Interrupt controller to which the chip is connected.
> +- interrupts : Interrupt to which the chip is connected.
> +
> +Optional properties:
> +- vdd-supply	: It is the controller supply for controlling
> +					 main voltage(3.3V) through the regulator.
> +- vid-supply	: It is the controller supply for controlling
> +					IO voltage(1.8V) through the regulator.
> +- irq-gpios		: Define for interrupt gpio pin.
> +						It is to use for set interrupt type.

As mentioned in the last version, use "interrupts".

> +- reset-gpios	: Define for reset gpio pin.
> +						It is to use for reset IC.
> +- hideep,max_coords	: Max value for axis X, Y, W, Z.

s/_/-/

> +
> +Example:
> +
> +i2c@00000000 {
> +
> +	/* ... */
> +
> +	touchscreen@6c {
> +		compatible = "hideep,hideep_ts";
> +		reg = <0x6c>;
> +		interrupt-parent = <&gpx1>;
> +		interrupts = <2>;
> +		vdd-supply = <&ldo15_reg>";
> +		vid-supply = <&ldo18_reg>;
> +		irq-gpios = <&gpx1 2 0>;
> +		reset-gpios = <&gpx1 5 0>;
> +		hideep,max_coords = <1080 1920 65535 65535>;
> +	};
> +};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
