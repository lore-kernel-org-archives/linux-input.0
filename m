From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] input: gpio-joy - GPIO joystick driver
Date: Fri, 6 Feb 2015 11:02:57 +0000
Message-ID: <20150206110257.GB10324@leverpostej>
References: <1423215122-19947-1-git-send-email-hans.holmberg@intel.com>
 <1423215122-19947-3-git-send-email-hans.holmberg@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423215122-19947-3-git-send-email-hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans Holmberg <hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Feb 06, 2015 at 09:32:02AM +0000, Hans Holmberg wrote:
> This is an interrupt-driven driver for digital joysticks
> connected to GPIOs. Supports any digital joystick with
> signals for up, down, left, right and one signal for
> trigger button press, i.e. C64/Atari joysticks.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/input/joystick/Kconfig    |  10 ++
>  drivers/input/joystick/Makefile   |   1 +
>  drivers/input/joystick/gpio_joy.c | 208 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 219 insertions(+)
>  create mode 100644 drivers/input/joystick/gpio_joy.c

[...]

> +static int gpio_joy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct input_dev *input;
> +	struct gpio_joy_drvdata *ddata;
> +	int i, err;
> +	unsigned int debounce_ms;

This should be a u32 given you pass it to a function expecting a u32
pointer.

> +
> +	ddata = devm_kzalloc(dev, sizeof(struct gpio_joy_drvdata), GFP_KERNEL);

Use sizeof(*ddata)

[...]

> +	return 0;
> +fail:
> +	return err;
> +}

Given there's no cleanup, the fail path seems redundant.

[...]

> +static const struct of_device_id gpio_joy_of_match[] = {
> +	{ .compatible = DRV_NAME, },
> +	{ },
> +};

The compatible string should be independent of DRV_NAME, because it must
match the binding. The driver can be arbitrarily and independently renamed.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
