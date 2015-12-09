From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 000/182] Rid struct gpio_chip from container_of() usage
Date: Wed, 9 Dec 2015 13:44:11 +0000
Message-ID: <20151209134410.GH8644@n2100.arm.linux.org.uk>
References: <1449666515-23343-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449666515-23343-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Dec 09, 2015 at 02:08:35PM +0100, Linus Walleij wrote:
> Because we want to have a proper userspace ABI for GPIO chips,
> which involves using a character device that the user opens
> and closes. While the character device is open, the underlying
> kernel objects must not go away.

Okay, so you stop the gpio_chip struct from going away.  What
about the code which is called via gpio_chip - say, if userspace
keep shte chardev open, and someone rmmod's the driver providing
the GPIO driver.

I'm not sure that splitting up objects in this way really solves
anything at all.  Yes, it divorses the driver's private data from
the subsystem data, but is that really an advantage?

Network drivers have a similar issue, and the way this problem is
solved there is that alloc_netdev() is always used to allocate the
subsystem data structure and any driver private data structure as
one allocation, and the lifetime of both objects remains under the
control of the subsystem.

The allocated memory is only freed when the last user goes away,
and net has protection to prevent an unregistered driver from
being called (via locks on every path into the layer.)

Things get a little more complex with gpio, because there's the
issue that some methods are spinlocked while others can take
semaphores, but it should be possible to come up with a solution
to that - maybe an atomic_t which is incremented whenever we're
in some operation provided it's >= 0 (otherwise it fails), and
decremented when the operation completes.  We can then control
in the unregistration path further GPIO accesses, and also
prevent new accesses occuring by setting the atomic_t to -1.
This shouldn't require any additional locking in any path.  It
does mean that the unregistration path needs careful thought to
ensure that when we set it to -1, we wait for it to be dropped
by the appropriate amount.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
