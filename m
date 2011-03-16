From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH 16/17] Input: tsc2005 - add open/close
Date: Wed, 16 Mar 2011 17:37:36 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1103161732550.2634@esdhcp041196.research.nokia.com>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv> <20110316071923.25664.10030.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:20015 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752987Ab1CPPkQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 11:40:16 -0400
In-Reply-To: <20110316071923.25664.10030.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

Hi,

On Wed, 16 Mar 2011, Dmitry Torokhov wrote:
> Introduce open and close methods for the input device to keep the device
> powered down when it is not in use. Also rework interaction between
> interrupt thread and starting/shutting off/resetting the device: instead
> of taking a mutex in the intterrupt thread and elsewhere disable interrupts
> before transitioning the device in a new state.

The driver is missing input_set_drvdata() (I guess that's the function),
so opening the device will crash.

> The ESD handling is also separated from the IRQ thread; we poll regularly
> at a given interval and simply skip reads if we see that valid interrupt
> happened not so long ago. This allows us not cancel and reschedule ESD
> work from interrupt context all the time.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> drivers/input/touchscreen/tsc2005.c |  216 ++++++++++++++++++++---------------
> 1 files changed, 122 insertions(+), 94 deletions(-)
>
> diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
> index f72df969..2e8c063 100644
> --- a/drivers/input/touchscreen/tsc2005.c
> +++ b/drivers/input/touchscreen/tsc2005.c
> @@ -133,13 +133,14 @@ struct tsc2005 {
> 	struct timer_list	penup_timer;
>
> 	unsigned int		esd_timeout;
> -	struct timer_list	esd_timer;
> -	struct work_struct	esd_work;
> +	struct delayed_work	esd_work;
> +	unsigned long		last_valid_interrupt;
>
> 	unsigned int		x_plate_ohm;
>
> 	bool			disabled;
> -	unsigned int		disable_depth;
> +	bool			opened;
> +	bool			suspended;
>
> 	bool			pen_down;
>
> @@ -258,11 +259,6 @@ static irqreturn_t tsc2005_irq_thread(int irq, void *_ts)
> 	u32 z1, z2;
> 	int error;
>
> -	mutex_lock(&ts->mutex);
> -
> -	if (unlikely(ts->disable_depth))
> -		goto out;
> -
> 	/* read the coordinates */
> 	error = spi_sync(ts->spi, &ts->spi_read_msg);
> 	if (unlikely(error))
> @@ -309,21 +305,13 @@ static irqreturn_t tsc2005_irq_thread(int irq, void *_ts)
> 	spin_lock_irqsave(&ts->lock, flags);
>
> 	tsc2005_update_pen_state(ts, x, y, pressure);
> -
> -	/* set the penup timer */
> 	mod_timer(&ts->penup_timer,
> 		  jiffies + msecs_to_jiffies(TSC2005_PENUP_TIME_MS));
>
> -	if (ts->esd_timeout && ts->set_reset) {
> -		/* update the watchdog timer */
> -		mod_timer(&ts->esd_timer, round_jiffies(jiffies +
> -					msecs_to_jiffies(ts->esd_timeout)));
> -	}
> -
> 	spin_unlock_irqrestore(&ts->lock, flags);
>
> +	ts->last_valid_interrupt = jiffies;
> out:
> -	mutex_unlock(&ts->mutex);
> 	return IRQ_HANDLED;
> }
>
> @@ -350,29 +338,31 @@ static void tsc2005_stop_scan(struct tsc2005 *ts)
> 	tsc2005_cmd(ts, TSC2005_CMD_STOP);
> }
>
> -/* must be called with mutex held */
> -static void tsc2005_disable(struct tsc2005 *ts)
> +/* must be called with ts->mutex held */
> +static void __tsc2005_disable(struct tsc2005 *ts)
> {
> -	if (ts->disable_depth++ != 0)
> -		return;
> +	tsc2005_stop_scan(ts);
> +
> 	disable_irq(ts->spi->irq);
> -	if (ts->esd_timeout)
> -		del_timer_sync(&ts->esd_timer);
> 	del_timer_sync(&ts->penup_timer);
> -	tsc2005_stop_scan(ts);
> +
> +	cancel_delayed_work_sync(&ts->esd_work);
> +
> +	enable_irq(ts->spi->irq);
> }
>
> -/* must be called with mutex held */
> -static void tsc2005_enable(struct tsc2005 *ts)
> +/* must be called with ts->mutex held */
> +static void __tsc2005_enable(struct tsc2005 *ts)
> {
> -	if (--ts->disable_depth != 0)
> -		return;
> 	tsc2005_start_scan(ts);
> -	enable_irq(ts->spi->irq);
> -	if (!ts->esd_timeout)
> -		return;
> -	mod_timer(&ts->esd_timer,
> -		  round_jiffies(jiffies + msecs_to_jiffies(ts->esd_timeout)));
> +
> +	if (ts->esd_timeout && ts->set_reset) {
> +		ts->last_valid_interrupt = jiffies;
> +		schedule_delayed_work(&ts->esd_work,
> +				round_jiffies(jiffies +
> +					msecs_to_jiffies(ts->esd_timeout)));
> +	}
> +
> }
>
> static ssize_t tsc2005_disable_show(struct device *dev,
> @@ -390,23 +380,29 @@ static ssize_t tsc2005_disable_store(struct device *dev,
> {
> 	struct spi_device *spi = to_spi_device(dev);
> 	struct tsc2005 *ts = spi_get_drvdata(spi);
> -	unsigned long res;
> -	int i;
> +	unsigned long val;
> +	int error;
>
> -	if (strict_strtoul(buf, 10, &res) < 0)
> -		return -EINVAL;
> -	i = res ? 1 : 0;
> +	error = strict_strtoul(buf, 10, &val);
> +	if (error)
> +		return error;
>
> 	mutex_lock(&ts->mutex);
> -	if (i == ts->disabled)
> -		goto out;
> -	ts->disabled = i;
> -	if (i)
> -		tsc2005_disable(ts);
> -	else
> -		tsc2005_enable(ts);
> -out:
> +
> +	if (!ts->suspended && ts->opened) {
> +		if (val) {
> +			if (!ts->disabled)
> +				__tsc2005_disable(ts);
> +		} else {
> +			if (ts->disabled)
> +				__tsc2005_enable(ts);
> +		}
> +	}
> +
> +	ts->disabled = !!val;
> +
> 	mutex_unlock(&ts->mutex);
> +
> 	return count;
> }
> static DEVICE_ATTR(disable, 0664, tsc2005_disable_show, tsc2005_disable_store);
> @@ -428,7 +424,7 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
> 	/*
> 	 * Test TSC2005 communications via temp high register.
> 	 */
> -	tsc2005_disable(ts);
> +	__tsc2005_disable(ts);
>
> 	error = tsc2005_read(ts, TSC2005_REG_TEMP_HIGH, &temp_high_orig);
> 	if (error) {
> @@ -484,7 +480,7 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
> 	}
>
> out:
> -	tsc2005_enable(ts);
> +	__tsc2005_enable(ts);
> 	mutex_unlock(&ts->mutex);
>
> 	return sprintf(buf, "%d\n", success);
> @@ -519,44 +515,79 @@ static const struct attribute_group tsc2005_attr_group = {
> 	.attrs		= tsc2005_attrs,
> };
>
> -static void tsc2005_esd_timer(unsigned long data)
> -{
> -	struct tsc2005 *ts = (struct tsc2005 *)data;
> -
> -	schedule_work(&ts->esd_work);
> -}
> -
> static void tsc2005_esd_work(struct work_struct *work)
> {
> -	struct tsc2005 *ts = container_of(work, struct tsc2005, esd_work);
> +	struct tsc2005 *ts = container_of(work, struct tsc2005, esd_work.work);
> 	int error;
> 	u16 r;
>
> 	mutex_lock(&ts->mutex);
>
> -	if (ts->disable_depth)
> +	if (time_is_after_jiffies(ts->last_valid_interrupt +
> +				  msecs_to_jiffies(ts->esd_timeout)))
> 		goto out;
>
> -	/*
> -	 * If we cannot read our known value from configuration register 0 then
> -	 * reset the controller as if from power-up and start scanning again.
> -	 */
> +	/* We should be able to read register without disabling interrupts. */
> 	error = tsc2005_read(ts, TSC2005_REG_CFR0, &r);
> -	if (error ||
> -	    ((r ^ TSC2005_CFR0_INITVALUE) & TSC2005_CFR0_RW_MASK)) {
> -		dev_info(&ts->spi->dev, "TSC2005 not responding - resetting\n");
> -		ts->set_reset(false);
> -		tsc2005_update_pen_state(ts, 0, 0, 0);
> -		usleep_range(100, 500); /* only 10us required */
> -		ts->set_reset(true);
> -		tsc2005_start_scan(ts);
> +	if (!error &&
> +	    !((r ^ TSC2005_CFR0_INITVALUE) & TSC2005_CFR0_RW_MASK)) {
> +		goto out;
> 	}
>
> -	/* re-arm the watchdog */
> -	mod_timer(&ts->esd_timer,
> -		  round_jiffies(jiffies + msecs_to_jiffies(ts->esd_timeout)));
> +	/*
> +	 * If we could not read our known value from configuration register 0
> +	 * then we should reset the controller as if from power-up and start
> +	 * scanning again.
> +	 */
> +	dev_info(&ts->spi->dev, "TSC2005 not responding - resetting\n");
> +
> +	disable_irq(ts->spi->irq);
> +	del_timer_sync(&ts->penup_timer);
> +
> +	tsc2005_update_pen_state(ts, 0, 0, 0);
> +
> +	ts->set_reset(false);
> +	usleep_range(100, 500); /* only 10us required */
> +	ts->set_reset(true);
> +
> +	enable_irq(ts->spi->irq);
> +	tsc2005_start_scan(ts);
>
> out:
> +	/* re-arm the watchdog */
> +	schedule_delayed_work(&ts->esd_work,
> +			      round_jiffies(jiffies +
> +					msecs_to_jiffies(ts->esd_timeout)));
> +	mutex_unlock(&ts->mutex);
> +}
> +
> +static int tsc2005_open(struct input_dev *input)
> +{
> +	struct tsc2005 *ts = input_get_drvdata(input);
> +
> +	mutex_lock(&ts->mutex);
> +
> +	if (!ts->suspended && !ts->disabled)
> +		__tsc2005_enable(ts);
> +
> +	ts->opened = true;
> +
> +	mutex_unlock(&ts->mutex);
> +
> +	return 0;
> +}
> +
> +static void tsc2005_close(struct input_dev *input)
> +{
> +	struct tsc2005 *ts = input_get_drvdata(input);
> +
> +	mutex_lock(&ts->mutex);
> +
> +	if (!ts->suspended && !ts->disabled)
> +		__tsc2005_disable(ts);
> +
> +	ts->opened = false;
> +
> 	mutex_unlock(&ts->mutex);
> }
>
> @@ -626,8 +657,7 @@ static int __devinit tsc2005_probe(struct spi_device *spi)
> 	spin_lock_init(&ts->lock);
> 	setup_timer(&ts->penup_timer, tsc2005_penup_timer, (unsigned long)ts);
>
> -	setup_timer(&ts->esd_timer, tsc2005_esd_timer, (unsigned long)ts);
> -	INIT_WORK(&ts->esd_work, tsc2005_esd_work);
> +	INIT_DELAYED_WORK(&ts->esd_work, tsc2005_esd_work);
>
> 	tsc2005_setup_spi_xfer(ts);
>
> @@ -645,6 +675,12 @@ static int __devinit tsc2005_probe(struct spi_device *spi)
> 	input_set_abs_params(input_dev, ABS_Y, 0, max_y, fudge_y, 0);
> 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, max_p, fudge_p, 0);
>
> +	input_dev->open = tsc2005_open;
> +	input_dev->close = tsc2005_close;
> +
> +	/* Ensure the touchscreen is off */
> +	tsc2005_stop_scan(ts);
> +
> 	error = request_threaded_irq(spi->irq, NULL, tsc2005_irq_thread,
> 				     IRQF_TRIGGER_RISING, "tsc2005", ts);
> 	if (error) {
> @@ -667,14 +703,6 @@ static int __devinit tsc2005_probe(struct spi_device *spi)
> 		goto err_remove_sysfs;
> 	}
>
> -	tsc2005_start_scan(ts);
> -
> -	if (ts->esd_timeout && ts->set_reset) {
> -		/* start the optional ESD watchdog */
> -		mod_timer(&ts->esd_timer, round_jiffies(jiffies +
> -					msecs_to_jiffies(ts->esd_timeout)));
> -	}
> -
> 	set_irq_wake(spi->irq, 1);
> 	return 0;
>
> @@ -695,16 +723,6 @@ static int __devexit tsc2005_remove(struct spi_device *spi)
>
> 	sysfs_remove_group(&ts->spi->dev.kobj, &tsc2005_attr_group);
>
> -	mutex_lock(&ts->mutex);
> -	tsc2005_disable(ts);
> -	mutex_unlock(&ts->mutex);
> -
> -	if (ts->esd_timeout)
> -		del_timer_sync(&ts->esd_timer);
> -	del_timer_sync(&ts->penup_timer);
> -
> -	flush_work(&ts->esd_work);
> -
> 	free_irq(ts->spi->irq, ts);
> 	input_unregister_device(ts->idev);
> 	kfree(ts);
> @@ -720,7 +738,12 @@ static int tsc2005_suspend(struct device *dev)
> 	struct tsc2005 *ts = spi_get_drvdata(spi);
>
> 	mutex_lock(&ts->mutex);
> -	tsc2005_disable(ts);
> +
> +	if (!ts->suspended && !ts->disabled && ts->opened)
> +		__tsc2005_disable(ts);
> +
> +	ts->suspended = true;
> +
> 	mutex_unlock(&ts->mutex);
>
> 	return 0;
> @@ -732,7 +755,12 @@ static int tsc2005_resume(struct device *dev)
> 	struct tsc2005 *ts = spi_get_drvdata(spi);
>
> 	mutex_lock(&ts->mutex);
> -	tsc2005_enable(ts);
> +
> +	if (ts->suspended && !ts->disabled && ts->opened)
> +		__tsc2005_enable(ts);
> +
> +	ts->suspended = false;
> +
> 	mutex_unlock(&ts->mutex);
>
> 	return 0;
>
