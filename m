From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: touchscreen: Convert timers to use timer_setup()
Date: Tue, 24 Oct 2017 10:05:43 -0700
Message-ID: <20171024170543.rsb7rcmfomjvhx6b@dtor-ws>
References: <20171024141858.GA78061@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171024141858.GA78061@beast>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Ferruh Yigit <fery@cypress.com>, Wan ZongShun <mcuos.com@gmail.com>, Guenter Roeck <linux@roeck-us.net>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 24, 2017 at 07:18:58AM -0700, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Ferruh Yigit <fery@cypress.com>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-input@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Applied...

>  drivers/input/touchscreen/ad7877.c       |  6 +++---

With the exception of this that I already had a patch for.

>  drivers/input/touchscreen/ad7879.c       |  6 +++---
>  drivers/input/touchscreen/atmel-wm97xx.c | 10 ++++++----
>  drivers/input/touchscreen/cyttsp4_core.c |  7 +++----
>  drivers/input/touchscreen/tsc200x-core.c |  6 +++---
>  drivers/input/touchscreen/w90p910_ts.c   |  7 +++----
>  6 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
> index 9c250ae780d9..0381c7809d1b 100644
> --- a/drivers/input/touchscreen/ad7877.c
> +++ b/drivers/input/touchscreen/ad7877.c
> @@ -385,9 +385,9 @@ static inline void ad7877_ts_event_release(struct ad7877 *ts)
>  	input_sync(input_dev);
>  }
>  
> -static void ad7877_timer(unsigned long handle)
> +static void ad7877_timer(struct timer_list *t)
>  {
> -	struct ad7877 *ts = (void *)handle;
> +	struct ad7877 *ts = from_timer(ts, t, timer);
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&ts->lock, flags);
> @@ -718,7 +718,7 @@ static int ad7877_probe(struct spi_device *spi)
>  	ts->spi = spi;
>  	ts->input = input_dev;
>  
> -	setup_timer(&ts->timer, ad7877_timer, (unsigned long) ts);
> +	timer_setup(&ts->timer, ad7877_timer, 0);
>  	mutex_init(&ts->mutex);
>  	spin_lock_init(&ts->lock);
>  
> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
> index 7d74a0ae2c94..6bad23ee47a1 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -237,9 +237,9 @@ static void ad7879_ts_event_release(struct ad7879 *ts)
>  	input_sync(input_dev);
>  }
>  
> -static void ad7879_timer(unsigned long handle)
> +static void ad7879_timer(struct timer_list *t)
>  {
> -	struct ad7879 *ts = (void *)handle;
> +	struct ad7879 *ts = from_timer(ts, t, timer);
>  
>  	ad7879_ts_event_release(ts);
>  }
> @@ -570,7 +570,7 @@ int ad7879_probe(struct device *dev, struct regmap *regmap,
>  	ts->irq = irq;
>  	ts->regmap = regmap;
>  
> -	setup_timer(&ts->timer, ad7879_timer, (unsigned long) ts);
> +	timer_setup(&ts->timer, ad7879_timer, 0);
>  	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
>  
>  	input_dev->name = "AD7879 Touchscreen";
> diff --git a/drivers/input/touchscreen/atmel-wm97xx.c b/drivers/input/touchscreen/atmel-wm97xx.c
> index 8cf0b2be2df4..9140a43cfe20 100644
> --- a/drivers/input/touchscreen/atmel-wm97xx.c
> +++ b/drivers/input/touchscreen/atmel-wm97xx.c
> @@ -208,9 +208,12 @@ static void atmel_wm97xx_acc_pen_up(struct wm97xx *wm)
>  	}
>  }
>  
> -static void atmel_wm97xx_pen_timer(unsigned long data)
> +static void atmel_wm97xx_pen_timer(struct timer_list *t)
>  {
> -	atmel_wm97xx_acc_pen_up((struct wm97xx *)data);
> +	struct atmel_wm97xx *atmel_wm97xx = from_timer(atmel_wm97xx, t,
> +						       pen_timer);
> +
> +	atmel_wm97xx_acc_pen_up(atmel_wm97xx->wm);
>  }
>  
>  static int atmel_wm97xx_acc_startup(struct wm97xx *wm)
> @@ -348,8 +351,7 @@ static int __init atmel_wm97xx_probe(struct platform_device *pdev)
>  	atmel_wm97xx->gpio_pen	= atmel_gpio_line;
>  	atmel_wm97xx->gpio_irq	= gpio_to_irq(atmel_wm97xx->gpio_pen);
>  
> -	setup_timer(&atmel_wm97xx->pen_timer, atmel_wm97xx_pen_timer,
> -			(unsigned long)wm);
> +	timer_setup(&atmel_wm97xx->pen_timer, atmel_wm97xx_pen_timer, 0);
>  
>  	ret = request_irq(atmel_wm97xx->ac97c_irq,
>  			  atmel_wm97xx_channel_b_interrupt,
> diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
> index beaf61ce775b..e7710397e0ad 100644
> --- a/drivers/input/touchscreen/cyttsp4_core.c
> +++ b/drivers/input/touchscreen/cyttsp4_core.c
> @@ -1237,9 +1237,9 @@ static void cyttsp4_stop_wd_timer(struct cyttsp4 *cd)
>  	del_timer_sync(&cd->watchdog_timer);
>  }
>  
> -static void cyttsp4_watchdog_timer(unsigned long handle)
> +static void cyttsp4_watchdog_timer(struct timer_list *t)
>  {
> -	struct cyttsp4 *cd = (struct cyttsp4 *)handle;
> +	struct cyttsp4 *cd = from_timer(cd, t, watchdog_timer);
>  
>  	dev_vdbg(cd->dev, "%s: Watchdog timer triggered\n", __func__);
>  
> @@ -2074,8 +2074,7 @@ struct cyttsp4 *cyttsp4_probe(const struct cyttsp4_bus_ops *ops,
>  	}
>  
>  	/* Setup watchdog timer */
> -	setup_timer(&cd->watchdog_timer, cyttsp4_watchdog_timer,
> -		(unsigned long)cd);
> +	timer_setup(&cd->watchdog_timer, cyttsp4_watchdog_timer, 0);
>  
>  	/*
>  	 * call startup directly to ensure that the device
> diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
> index 88ea5e1b72ae..542db26d7fd0 100644
> --- a/drivers/input/touchscreen/tsc200x-core.c
> +++ b/drivers/input/touchscreen/tsc200x-core.c
> @@ -202,9 +202,9 @@ static irqreturn_t tsc200x_irq_thread(int irq, void *_ts)
>  	return IRQ_HANDLED;
>  }
>  
> -static void tsc200x_penup_timer(unsigned long data)
> +static void tsc200x_penup_timer(struct timer_list *t)
>  {
> -	struct tsc200x *ts = (struct tsc200x *)data;
> +	struct tsc200x *ts = from_timer(ts, t, penup_timer);
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&ts->lock, flags);
> @@ -506,7 +506,7 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
>  	mutex_init(&ts->mutex);
>  
>  	spin_lock_init(&ts->lock);
> -	setup_timer(&ts->penup_timer, tsc200x_penup_timer, (unsigned long)ts);
> +	timer_setup(&ts->penup_timer, tsc200x_penup_timer, 0);
>  
>  	INIT_DELAYED_WORK(&ts->esd_work, tsc200x_esd_work);
>  
> diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/touchscreen/w90p910_ts.c
> index da6004e97753..638c1d78ca3a 100644
> --- a/drivers/input/touchscreen/w90p910_ts.c
> +++ b/drivers/input/touchscreen/w90p910_ts.c
> @@ -146,9 +146,9 @@ static irqreturn_t w90p910_ts_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static void w90p910_check_pen_up(unsigned long data)
> +static void w90p910_check_pen_up(struct timer_list *t)
>  {
> -	struct w90p910_ts *w90p910_ts = (struct w90p910_ts *) data;
> +	struct w90p910_ts *w90p910_ts = from_timer(w90p910_ts, t, timer);
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&w90p910_ts->lock, flags);
> @@ -232,8 +232,7 @@ static int w90x900ts_probe(struct platform_device *pdev)
>  	w90p910_ts->input = input_dev;
>  	w90p910_ts->state = TS_IDLE;
>  	spin_lock_init(&w90p910_ts->lock);
> -	setup_timer(&w90p910_ts->timer, w90p910_check_pen_up,
> -		    (unsigned long)w90p910_ts);
> +	timer_setup(&w90p910_ts->timer, w90p910_check_pen_up, 0);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
> -- 
> 2.7.4
> 
> 
> -- 
> Kees Cook
> Pixel Security

-- 
Dmitry
