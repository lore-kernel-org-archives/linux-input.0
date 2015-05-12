From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 04/17] input: locomokbd: provide an Alt-SysRQ
 combination
Date: Tue, 12 May 2015 13:12:15 -0700
Message-ID: <20150512201215.GD20725@dtor-ws>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-5-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430178954-11138-5-git-send-email-dbaryshkov@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Tue, Apr 28, 2015 at 02:55:41AM +0300, Dmitry Eremin-Solenikov wrote:
> It is usefull sometimes to have an Alt-SysRQ combo on the keyboard to be
> able to trigger sysrq functions directly. Add an option providing sysrq
> mapping for Contact-Home keys.

No, if you want to remap the keys please do it from usepspace; locomokbd
supports it (EVIOCSKEYCODE ioctl).

Thanks.

> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/input/keyboard/Kconfig     |  7 +++++++
>  drivers/input/keyboard/locomokbd.c | 14 +++++++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 0a3d875..eb8b11b 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -343,6 +343,13 @@ config KEYBOARD_LOCOMO
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called locomokbd.
>  
> +config KEYBOARD_LOCOMO_SYSRQ
> +	bool "Provide SysRQ key on LoCoMo keyboard"
> +	depends on KEYBOARD_LOCOMO
> +	help
> +	  Say Y here to be able to use Contact-Home as Alt-Sysrq combo.
> +	  Say N if you want to use them as usual keys.
> +
>  config KEYBOARD_LPC32XX
>  	tristate "LPC32XX matrix key scanner support"
>  	depends on ARCH_LPC32XX && OF
> diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
> index eed0a94..eb8dbe2 100644
> --- a/drivers/input/keyboard/locomokbd.c
> +++ b/drivers/input/keyboard/locomokbd.c
> @@ -40,6 +40,14 @@
>  #define KEY_CONTACT		KEY_F18
>  #define KEY_CENTER		KEY_F15
>  
> +#ifdef CONFIG_KEYBOARD_LOCOMOKBD_SYSRQ
> +#define LOCOMO_KEY_CONTACT	KEY_LEFTALT
> +#define LOCOMO_KEY_HOME		KEY_SYSRQ
> +#else
> +#define LOCOMO_KEY_CONTACT	KEY_CONTACT
> +#define LOCOMO_KEY_HOME		KEY_HOME
> +#endif
> +
>  #define KB_ROWS			16
>  #define KB_COLS			8
>  #define LOCOMOKBD_NUMKEYS	(KB_ROWS * KB_COLS)
> @@ -48,7 +56,7 @@
>  static const unsigned char
>  locomokbd_keycode[LOCOMOKBD_NUMKEYS] = {
>  	0, KEY_ESC, KEY_ACTIVITY, 0, 0, 0, 0, 0, 0, 0,				/* 0 - 9 */
> -	0, 0, 0, 0, 0, 0, 0, KEY_MENU, 0, KEY_CONTACT,				/* 10 - 19 */
> +	0, 0, 0, 0, 0, 0, 0, KEY_MENU, 0, LOCOMO_KEY_CONTACT,			/* 10 - 19 */
>  	0, 0, 0, 0, 0, 0, 0, 0, 0, 0,						/* 20 - 29 */
>  	0, 0, 0, KEY_CENTER, 0, KEY_MAIL, 0, 0, 0, 0,				/* 30 - 39 */
>  	0, 0, 0, 0, 0, 0, 0, 0, 0, KEY_RIGHT,					/* 40 - 49 */
> @@ -280,9 +288,9 @@ static int locomokbd_probe(struct platform_device *dev)
>  			sizeof(locomokbd->keycode));
>  
>  	if (machine_is_collie())
> -		locomokbd->keycode[18] = KEY_HOME;
> +		locomokbd->keycode[18] = LOCOMO_KEY_HOME;
>  	else
> -		locomokbd->keycode[3] = KEY_HOME;
> +		locomokbd->keycode[3] = LOCOMO_KEY_HOME;
>  
>  	for (i = 0; i < LOCOMOKBD_NUMKEYS; i++)
>  		input_set_capability(input_dev, EV_KEY, locomokbd->keycode[i]);
> -- 
> 2.1.4
> 

-- 
Dmitry
