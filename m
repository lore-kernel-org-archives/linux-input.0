From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v2 14/17] ARM: pxa: poodle: use new LoCoMo driver
Date: Tue, 28 Apr 2015 21:35:12 +0200
Message-ID: <87a8xsjbbj.fsf@belgarion.home>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
	<1430178954-11138-15-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430178954-11138-15-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> (Dmitry
	Eremin-Solenikov's message of "Tue, 28 Apr 2015 02:55:51 +0300")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> -#define POODLE_LOCOMO_GPIO_AMP_ON      LOCOMO_GPIO(8)
> -#define POODLE_LOCOMO_GPIO_MUTE_L      LOCOMO_GPIO(10)
> -#define POODLE_LOCOMO_GPIO_MUTE_R      LOCOMO_GPIO(11)
> -#define POODLE_LOCOMO_GPIO_232VCC_ON   LOCOMO_GPIO(12)
> -#define POODLE_LOCOMO_GPIO_JK_B        LOCOMO_GPIO(13)
> +#define POODLE_LOCOMO_GPIO_BASE	(PXA_NR_BUILTIN_GPIO + 12)
I missed that in the v1 serie : why twelve ?

> +#define POODLE_GPIO_LCD_VSHA_ON	(POODLE_LOCOMO_GPIO_BASE + 4)
> +#define POODLE_GPIO_LCD_VSHD_ON	(POODLE_LOCOMO_GPIO_BASE + 5)
> +#define POODLE_GPIO_LCD_VEE_ON	(POODLE_LOCOMO_GPIO_BASE + 6)
> +#define POODLE_GPIO_LCD_MOD	(POODLE_LOCOMO_GPIO_BASE + 7)
> +#define POODLE_GPIO_AMP_ON	(POODLE_LOCOMO_GPIO_BASE + 8)
> +#define POODLE_GPIO_FL_VR	(POODLE_LOCOMO_GPIO_BASE + 9)
> +#define POODLE_GPIO_MUTE_L	(POODLE_LOCOMO_GPIO_BASE + 10)
> +#define POODLE_GPIO_MUTE_R	(POODLE_LOCOMO_GPIO_BASE + 11)
> +#define POODLE_GPIO_232VCC_ON	(POODLE_LOCOMO_GPIO_BASE + 12)
> +#define POODLE_GPIO_JK_B	(POODLE_LOCOMO_GPIO_BASE + 13)
Why not keep the LOCOMO_GPIO() defines, and redevice LOCOMO_GPIO(x) to
(POODLE_LOCOMO_GPIO_BASE + (x)) ?

No comments on the remaining part, as long as it's tested, you know me by now
...

Cheers.

-- 
Robert
