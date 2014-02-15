From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: adp5588-keys: get value from data out when
 dir is out
Date: Sat, 15 Feb 2014 13:14:04 -0800
Message-ID: <20140215211404.GA5373@core.coreip.homeip.net>
References: <1392051929-32290-1-git-send-email-jeff.dagenais@gmail.com>
 <1392051929-32290-2-git-send-email-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392051929-32290-2-git-send-email-jeff.dagenais@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc: michael.hennerich@analog.com, linus.walleij@linaro.org, gnurou@gmail.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Feb 10, 2014 at 12:05:29PM -0500, Jean-Francois Dagenais wrote:
> As discussed here: http://ez.analog.com/message/35852,
> the 5587 revC and 5588 revB spec sheets contain a mistake
> in the GPIO_DAT_STATx register description.
> 
> According to R.Shnell at ADI, as well as my own
> observations, it should read:
> "GPIO data status (shows GPIO state when read for inputs)".
> 
> This commit changes the get value function accordingly.
> 
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>


Applied, thank you.

> ---
>  drivers/input/keyboard/adp5588-keys.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
> index bb3b57b..5ef7fcf 100644
> --- a/drivers/input/keyboard/adp5588-keys.c
> +++ b/drivers/input/keyboard/adp5588-keys.c
> @@ -76,8 +76,18 @@ static int adp5588_gpio_get_value(struct gpio_chip *chip, unsigned off)
>  	struct adp5588_kpad *kpad = container_of(chip, struct adp5588_kpad, gc);
>  	unsigned int bank = ADP5588_BANK(kpad->gpiomap[off]);
>  	unsigned int bit = ADP5588_BIT(kpad->gpiomap[off]);
> +	int val;
>  
> -	return !!(adp5588_read(kpad->client, GPIO_DAT_STAT1 + bank) & bit);
> +	mutex_lock(&kpad->gpio_lock);
> +
> +	if (kpad->dir[bank] & bit)
> +		val = kpad->dat_out[bank];
> +	else
> +		val = adp5588_read(kpad->client, GPIO_DAT_STAT1 + bank);
> +
> +	mutex_unlock(&kpad->gpio_lock);
> +
> +	return !!(val & bit);
>  }
>  
>  static void adp5588_gpio_set_value(struct gpio_chip *chip,
> -- 
> 1.8.5.3
> 

-- 
Dmitry
