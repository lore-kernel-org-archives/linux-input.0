From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 04/17] input: make LoCoMo keyboard driver support both
 poodle and collie
Date: Mon, 18 May 2015 09:50:58 -0700
Message-ID: <20150518165058.GB19708@dtor-ws>
References: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
 <1431880077-26321-5-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431880077-26321-5-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, May 17, 2015 at 07:27:44PM +0300, Dmitry Eremin-Solenikov wrote:
> Keyboards on collie and poodle differ only in wiring of 'Home' key.
> Instead of complicating the driver with platform data, just check for
> the machine for the time being. This will be converted to DTS property
> sometime in the future.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/input/keyboard/locomokbd.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
> index 1657bc0..b422608 100644
> --- a/drivers/input/keyboard/locomokbd.c
> +++ b/drivers/input/keyboard/locomokbd.c
> @@ -33,6 +33,9 @@
>  #include <linux/slab.h>
>  #include <linux/mfd/locomo.h>
>  
> +/* There is one minor difference between mappings on poodle and collie */
> +#include <asm/mach-types.h>
> +
>  #define KEY_ACTIVITY		KEY_F16
>  #define KEY_CONTACT		KEY_F18
>  #define KEY_CENTER		KEY_F15
> @@ -45,7 +48,7 @@
>  static const unsigned char
>  locomokbd_keycode[LOCOMOKBD_NUMKEYS] = {
>  	0, KEY_ESC, KEY_ACTIVITY, 0, 0, 0, 0, 0, 0, 0,				/* 0 - 9 */
> -	0, 0, 0, 0, 0, 0, 0, KEY_MENU, KEY_HOME, KEY_CONTACT,			/* 10 - 19 */
> +	0, 0, 0, 0, 0, 0, 0, KEY_MENU, 0, KEY_CONTACT,				/* 10 - 19 */
>  	0, 0, 0, 0, 0, 0, 0, 0, 0, 0,						/* 20 - 29 */
>  	0, 0, 0, KEY_CENTER, 0, KEY_MAIL, 0, 0, 0, 0,				/* 30 - 39 */
>  	0, 0, 0, 0, 0, 0, 0, 0, 0, KEY_RIGHT,					/* 40 - 49 */
> @@ -278,6 +281,11 @@ static int locomokbd_probe(struct platform_device *dev)
>  			locomokbd_keycode,
>  			sizeof(locomokbd->keycode));
>  
> +	if (machine_is_collie())
> +		locomokbd->keycode[18] = KEY_HOME;
> +	else
> +		locomokbd->keycode[3] = KEY_HOME;
> +
>  	for (i = 0; i < LOCOMOKBD_NUMKEYS; i++)
>  		input_set_capability(input_dev, EV_KEY, locomokbd->keycode[i]);
>  	input_set_capability(input_dev, EV_PWR, KEY_SUSPEND);
> -- 
> 2.1.4
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
