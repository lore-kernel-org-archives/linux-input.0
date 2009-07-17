From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Add possibility to control the
	GPIO_STATUS shift
Date: Fri, 17 Jul 2009 15:52:03 +0100
Message-ID: <20090717145203.GA15061@rakim.wolfsonmicro.main>
References: <200907171001.16889.marek.vasut@gmail.com>
	<200907171353.59356.marek.vasut@gmail.com>
	<20090717121159.GA20904@rakim.wolfsonmicro.main>
	<200907171645.21352.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200907171645.21352.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jul 17, 2009 at 04:45:21PM +0200, Marek Vasut wrote:

> From 1ea286d088993e05b5b374a08ee6f933242d3561 Mon Sep 17 00:00:00 2001
> From: Marek Vasut <marek.vasut@gmail.com>
> Date: Thu, 4 Jun 2009 21:56:59 +0200
> Subject: [PATCH 2/2] Add possibility to control the GPIO_STATUS shift
> 
> This patch allows tweaking the behaviour of GPIO_STATUS register
> shift quirk that's in wm97xx-core. The problem with GPIO_STATUS
> register being shifted by one doesn't appear on all hardware it
> seems and causes problems with accelerated touchscreen drivers on
> Palm hardware. Therefore an accelerated touchscreen driver can select
> if the shift is/isn't happening on the hardware.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  drivers/input/touchscreen/mainstone-wm97xx.c |    3 +++
>  drivers/input/touchscreen/wm97xx-core.c      |    6 ++++--
>  include/linux/wm97xx.h                       |    7 +++++++
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/mainstone-wm97xx.c b/drivers/input/touchscreen/mainstone-wm97xx.c
> index de02f87..e000ab3 100644
> --- a/drivers/input/touchscreen/mainstone-wm97xx.c
> +++ b/drivers/input/touchscreen/mainstone-wm97xx.c
> @@ -198,6 +198,9 @@ static int wm97xx_acc_startup(struct wm97xx *wm)
>  	if (machine_is_palmt5() || machine_is_palmtx() || machine_is_palmld()) {
>  		pen_int = 1;
>  		irq = 27;
> +		/* There is some obscure mutant of WM9712 interbred with WM9713
> +		 * used on Palm HW */
> +		wm->variant = WM97xx_WM1613;
>  	} else if (machine_is_mainstone() && pen_int)
>  		irq = 4;
>  
> diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
> index 2957d48..252eb11 100644
> --- a/drivers/input/touchscreen/wm97xx-core.c
> +++ b/drivers/input/touchscreen/wm97xx-core.c
> @@ -204,7 +204,7 @@ void wm97xx_set_gpio(struct wm97xx *wm, u32 gpio,
>  	else
>  		reg &= ~gpio;
>  
> -	if (wm->id == WM9712_ID2)
> +	if (wm->id == WM9712_ID2 && wm->variant != WM97xx_WM1613)
>  		wm97xx_reg_write(wm, AC97_GPIO_STATUS, reg << 1);
>  	else
>  		wm97xx_reg_write(wm, AC97_GPIO_STATUS, reg);
> @@ -307,7 +307,7 @@ static void wm97xx_pen_irq_worker(struct work_struct *work)
>  					 WM97XX_GPIO_13);
>  		}
>  
> -		if (wm->id == WM9712_ID2)
> +		if (wm->id == WM9712_ID2 && wm->variant != WM97xx_WM1613)
>  			wm97xx_reg_write(wm, AC97_GPIO_STATUS, (status &
>  						~WM97XX_GPIO_13) << 1);
>  		else
> @@ -582,6 +582,8 @@ static int wm97xx_probe(struct device *dev)
>  
>  	wm->id = wm97xx_reg_read(wm, AC97_VENDOR_ID2);
>  
> +	wm->variant = WM97xx_GENERIC;
> +
>  	dev_info(wm->dev, "detected a wm97%02x codec\n", wm->id & 0xff);
>  
>  	switch (wm->id & 0xff) {
> diff --git a/include/linux/wm97xx.h b/include/linux/wm97xx.h
> index 6f69968..0c98781 100644
> --- a/include/linux/wm97xx.h
> +++ b/include/linux/wm97xx.h
> @@ -16,6 +16,12 @@
>  #include <linux/platform_device.h>
>  
>  /*
> + * WM97xx variants
> + */
> +#define	WM97xx_GENERIC			0x0000
> +#define	WM97xx_WM1613			0x1613
> +
> +/*
>   * WM97xx AC97 Touchscreen registers
>   */
>  #define AC97_WM97XX_DIGITISER1		0x76
> @@ -283,6 +289,7 @@ struct wm97xx {
>  	unsigned pen_is_down:1;		/* Pen is down */
>  	unsigned aux_waiting:1;		/* aux measurement waiting */
>  	unsigned pen_probably_down:1;	/* used in polling mode */
> +	u16 variant;			/* WM97xx chip variant */
>  	u16 suspend_mode;               /* PRP in suspend mode */
>  };
>  
> -- 
> 1.6.3.3
> 
