From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 1/3] Input: gpio-keys - add support for wakeup event
 action
Date: Fri, 2 Mar 2018 17:10:17 -0800
Message-ID: <20180303011016.GA258190@rodete-desktop-imager.corp.google.com>
References: <20180302035102.10084-1-jeffy.chen@rock-chips.com>
 <20180302035102.10084-2-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180302035102.10084-2-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, briannorris@google.com, heiko@sntech.de, dtor@google.com, dianders@google.com, Guenter Roeck <linux@roeck-us.net>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Jeffy,

On Fri, Mar 02, 2018 at 11:51:00AM +0800, Jeffy Chen wrote:
> Add support for specifying event actions to trigger wakeup when using
> the gpio-keys input device as a wakeup source.
> 
> This would allow the device to configure when to wakeup the system. For
> example a gpio-keys input device for pen insert, may only want to wakeup
> the system when ejecting the pen.
> 
> Suggested-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v3:
> Adding more comments as Brian suggested.
> 
> Changes in v2:
> Specify wakeup event action instead of irq trigger type as Brian
> suggested.
> 
>  drivers/input/keyboard/gpio_keys.c     | 39 ++++++++++++++++++++++++++++++++++
>  include/linux/gpio_keys.h              |  2 ++
>  include/uapi/linux/input-event-codes.h |  9 ++++++++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 87e613dc33b8..607f3960c886 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c

...

> @@ -586,6 +606,12 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  
>  		isr = gpio_keys_irq_isr;
>  		irqflags = 0;
> +
> +		/*
> +		 * For IRQ buttons, the irq trigger type for press and release
> +		 * are the same. So we don't need to reconfigure the trigger
> +		 * type for wakeup.
> +		 */

Ah, I think I misunderstood what the (non-GPIO) IRQ-based trigger was
doing. It's just emulating an instantaneous press/release (or, with a
configurable release delay), so there isn't really a way to say "only
wake me on one edge".

So that still doesn't really mean we use the "same" trigger for all
wakeup trigger types. It really just means we can't support any
customization here -- we wake based on whatever the IRQ represents
(which today is probably just EV_ACT_ANY).

I guess it's fine to just ignore the wakeup-trigger-type property here,
but it would also be equally valid to reject it outright I think.

Anyway, that's only a mild complaint. For the whole series:

Tested-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks!

>  	}
>  
>  	bdata->code = &ddata->keymap[idx];
...
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 53fbae27b280..d7917b0bd438 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -32,6 +32,15 @@
>  #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)
>  
>  /*
> + * Event action types
> + */
> +#define EV_ACT_ANY			0x00	/* asserted or deasserted */
> +#define EV_ACT_ASSERTED			0x01	/* asserted */
> +#define EV_ACT_DEASSERTED		0x02	/* deasserted */
> +#define EV_ACT_MAX			0x02
> +#define EV_ACT_CNT			(EV_ACT_MAX+1)
> +
> +/*
>   * Event types
>   */
>  
> -- 
> 2.11.0
> 
> 
