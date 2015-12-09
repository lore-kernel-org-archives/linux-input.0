From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 000/182] Rid struct gpio_chip from container_of() usage
Date: Wed, 9 Dec 2015 11:30:34 -0800
Message-ID: <20151209193034.GE27131@dtor-ws>
References: <1449666515-23343-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449666515-23343-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Dec 09, 2015 at 02:08:35PM +0100, Linus Walleij wrote:
> This removes the use of container_of() constructions from *all*
> GPIO drivers in the kernel. It is done by instead adding an
> optional void *data pointer to the struct gpio_chip and an
> accessor function, gpiochip_get_data() to get it from a driver.
> 
> WHY?
> 
> Because we want to have a proper userspace ABI for GPIO chips,
> which involves using a character device that the user opens
> and closes. While the character device is open, the underlying
> kernel objects must not go away.
> 
> Currently the GPIO drivers keep their state in the struct
> gpio_chip, and that is often allocated by the drivers, very
> often as a part of a containing per-instance state container
> struct for the driver:
> 
> struct foo_state {
>    struct gpio_chip chip;  <- OMG my state is there
> };
> 
> Drivers cannot allocate and manage this state: if a user has the
> character device open, the objects allocated must stay around
> even if the driver goes away. Instead drivers need to pass a
> descriptor to the GPIO core, and then the core should allocate
> and manage the lifecycle of things related to the device, such
> as the chardev itself or the struct device related to the GPIO
> device.

Yes, but it does not mean that the object that is being maintained by
the subsystem and that us attached to character device needs to be
gpio_chip itself. You can have something like

struct gpio_chip_chardev {
	struct cdev chardev;
	struct gpio_chip *chip;
	bool dead;
};

struct gpio_chip {
	...
	struct gpio_chip_chardev *chardev;
	...
};

You alloctae the new structure when you register/export gpio chip in
gpio subsystem core and leave all the individual drivers alone.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
