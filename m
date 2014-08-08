From: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/1] Input: atmel_mxt_ts - Get IRQ edge/level flags
 on DT booting
Date: Fri, 08 Aug 2014 20:41:06 +0200
Message-ID: <53E519C2.9060405@gmail.com>
References: <1407397492-17475-1-git-send-email-javier.martinez@collabora.co.uk> <53E4D9A5.908@itdev.co.uk> <20140808162146.GC26820@core.coreip.homeip.net> <53E4FD1B.6060600@collabora.co.uk> <53E5170C.10302@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53E5170C.10302-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nick Dyer <nick.dyer-8YpZQSjhsQH10XsdtD+oqA@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Yufeng Shen <miletus-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Thomas Abraham <thomas.ab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

+CC Linus, as this became also pinctrl related.

On 08.08.2014 20:29, Javier Martinez Canillas wrote:
> Hello,
> 
> On 08/08/2014 06:38 PM, Javier Martinez Canillas wrote:
>>
>>
>> It seems as if the first call to exynos_irq_set_type() that is made by OF is a
>> no-op while the second call is the one that actually setups the hw correctly.
>> Does this make any sense? Maybe is related to the pin not being muxed in the
>> correct function when the "interrupts" property is parsed by OF?
>>
> 
> So after a conversation with Tomasz Figa over IRC the problem was after all that
> the pin was reconfigured. The IRQ trigger type resulted to be just a red herring
> and not a direct cause.
> 
> The pinctrl-eyxnos driver does the IRQ pinmux setup in the .irq_set_type
> function handler. So what happened was that OF parsed the "interrupts" property
> and called exynos_irq_set_type() which did the pinmux setup.
> 
> But after that, due a DTS pinctrl configuration the pin function was changed as
> a GPIO input and that happened before the atmel driver was probed. So when the
> driver called request_threaded_irq(), the correct flags were used but the pin
> was not configured as an IRQ anymore so IRQ were not fired.
> 
> Setting a trigger type just had the side effect of calling exynos_irq_set_type()
> which again setup the pin as an IRQ.
> 
> To fix the issue a variation of patch [0] will be posted that moves the IRQ
> pinmux setup from .irq_set_type to the .irq_request_resources function handler.
> That way the pin will be setup as IRQ regardless of the the trigger type [1]
> when someone calls request_[threaded]_irq().
> 
> Only the mentioned patch fixes the issue but Tomasz said that even a call to
> gpio_direction_{input,output} can change the pin configuration so he will post
> another patch that will add a bit mask to samsung_pin_bank to prevent any pinmux
> reconfiguration.

To add a bit more information about the hardware, setting up a GPIO
interrupt on Samsung SoCs is a two-step operation - in addition to
trigger configuration in a dedicated register, the pinmux must be also
reconfigured to GPIO interrupt, which is a different function than
normal GPIO input, although I/O-wise they both behave in the same way
and gpio_get_value() can be used on a pin configured as IRQ as well.

I'm afraid that such design implies that handling of this in the driver
must be done on a very low level, because it involves three possible
interfaces changing the pinmux - pinctrl, GPIO and irqchip and such
subtletes like gpio_direction_input() that shouldn't neither fail if a
pin is already configured as an interrupt nor change the configuration
to normal input.

Best regards,
Tomasz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
