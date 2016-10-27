From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v12 3/5] Input: goodix - add runtime power management
 support
Date: Thu, 27 Oct 2016 15:44:27 +0200
Message-ID: <1477575867.2458.22.camel@hadess.net>
References: <1473530257-7495-1-git-send-email-irina.tirdea@intel.com>
         <1473530257-7495-4-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473530257-7495-4-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, 2016-09-10 at 20:57 +0300, Irina Tirdea wrote:
> Add support for runtime power management so that the device is
> turned off when not used (when the userspace holds no open
> handles of the input device). The device uses autosuspend with a
> default delay of 2 seconds, so the device will suspend if no
> handles to it are open for 2 seconds.
> 
> The runtime management support is only available if the gpio pins
> are properly initialized from ACPI/DT.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
> 
<snip> 
> +static int goodix_set_power_state(struct goodix_ts_data *ts, bool
> on)

I don't like having booleans for this sort of thing[1], as it's never
clear whether "on" is "power state on" or "device is on".

I'd rather you defined a 2 member enum, with meaningful names, so that
the effect is clear when we're reading the caller.

[1]: https://blog.ometer.com/2011/01/20/boolean-parameters-are-wrong/

> +{
> +	int error;
> +
> +	if (on) {
> +		error = pm_runtime_get_sync(&ts->client->dev);
> +	} else {
> +		pm_runtime_mark_last_busy(&ts->client->dev);
> +		error = pm_runtime_put_autosuspend(&ts->client-
> >dev);
> +	}
> +
> +	if (error < 0) {
> +		dev_err(&ts->client->dev,
> +			"failed to change power state to %d\n", on);
> +		if (on)
> +			pm_runtime_put_noidle(&ts->client->dev);
> +
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
>  static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8
> *data)
>  {
>  	int touch_num;
> @@ -444,6 +474,10 @@ static ssize_t goodix_dump_config_show(struct
> device *dev,
>  
>  	wait_for_completion(&ts->firmware_loading_complete);
>  
> +	error = goodix_set_power_state(ts, true);
> +	if (error)
> +		return error;
> +
>  	error = goodix_i2c_read(ts->client, GOODIX_REG_CONFIG_DATA,
>  				config, ts->cfg_len);
>  	if (error) {
> @@ -452,6 +486,8 @@ static ssize_t goodix_dump_config_show(struct
> device *dev,
>  		return error;
>  	}
>  
> +	goodix_set_power_state(ts, false);
> +
>  	for (i = 0; i < ts->cfg_len; i++)
>  		count += scnprintf(buf + count, PAGE_SIZE - count,
> "%02x ",
>  				   config[i]);
> @@ -548,11 +584,13 @@ static ssize_t goodix_esd_timeout_store(struct
> device *dev,
>  		return error;
>  
>  	esd_timeout = atomic_read(&ts->esd_timeout);
> -	if (esd_timeout && !new_esd_timeout)
> +	if (esd_timeout && !new_esd_timeout &&
> +	    pm_runtime_active(&ts->client->dev))
>  		goodix_disable_esd(ts);
>  
>  	atomic_set(&ts->esd_timeout, new_esd_timeout);
> -	if (!esd_timeout && new_esd_timeout)
> +	if (!esd_timeout && new_esd_timeout &&
> +	    pm_runtime_active(&ts->client->dev))
>  		goodix_enable_esd(ts);
>  
>  	return count;
> @@ -573,6 +611,34 @@ static const struct attribute_group
> goodix_attr_group = {
>  	.attrs = goodix_attrs,
>  };
>  
> +static int goodix_open(struct input_dev *input_dev)
> +{
> +	struct goodix_ts_data *ts = input_get_drvdata(input_dev);
> +	int error;
> +
> +	if (!ts->gpiod_int || !ts->gpiod_rst)
> +		return 0;
> +
> +	wait_for_completion(&ts->firmware_loading_complete);
> +
> +	error = goodix_set_power_state(ts, true);
> +	if (error)
> +		return error;
> +	atomic_inc(&ts->open_count);
> +	return 0;
> +}
> +
> +static void goodix_close(struct input_dev *input_dev)
> +{
> +	struct goodix_ts_data *ts = input_get_drvdata(input_dev);
> +
> +	if (!ts->gpiod_int || !ts->gpiod_rst)
> +		return;
> +
> +	goodix_set_power_state(ts, false);
> +	atomic_dec(&ts->open_count);
> +}
> +
>  /**
>   * goodix_get_gpio_config - Get GPIO config from ACPI/DT
>   *
> @@ -754,6 +820,9 @@ static int goodix_request_input_dev(struct
> goodix_ts_data *ts)
>  	ts->input_dev->id.vendor = 0x0416;
>  	ts->input_dev->id.product = ts->id;
>  	ts->input_dev->id.version = ts->version;
> +	ts->input_dev->open = goodix_open;
> +	ts->input_dev->close = goodix_close;
> +	input_set_drvdata(ts->input_dev, ts);
>  
>  	error = input_register_device(ts->input_dev);
>  	if (error) {
> @@ -808,7 +877,8 @@ static int goodix_configure_dev(struct
> goodix_ts_data *ts)
>   * @ts: our goodix_ts_data pointer
>   *
>   * request_firmware_wait callback that finishes
> - * initialization of the device.
> + * initialization of the device. This will only be called
> + * when ts->gpiod_int and ts->gpiod_rst are properly initialized.
>   */
>  static void goodix_config_cb(const struct firmware *cfg, void *ctx)
>  {
> @@ -828,6 +898,19 @@ static void goodix_config_cb(const struct
> firmware *cfg, void *ctx)
>  
>  	goodix_enable_esd(ts);
>  
> +	pm_runtime_set_autosuspend_delay(&ts->client->dev,
> +					 GOODIX_AUTOSUSPEND_DELAY_MS
> );
> +	pm_runtime_use_autosuspend(&ts->client->dev);
> +	error = pm_runtime_set_active(&ts->client->dev);
> +	if (error) {
> +		dev_err(&ts->client->dev, "failed to set active:
> %d\n", error);
> +		goto err_release_cfg;
> +	}
> +	pm_runtime_enable(&ts->client->dev);
> +	/* Must not suspend immediately after device initialization
> */
> +	pm_runtime_mark_last_busy(&ts->client->dev);
> +	pm_request_autosuspend(&ts->client->dev);
> +
>  err_release_cfg:
>  	release_firmware(cfg);
>  	complete_all(&ts->firmware_loading_complete);
> @@ -854,6 +937,7 @@ static int goodix_ts_probe(struct i2c_client
> *client,
>  	i2c_set_clientdata(client, ts);
>  	init_completion(&ts->firmware_loading_complete);
>  	INIT_DELAYED_WORK(&ts->esd_work, goodix_esd_work);
> +	mutex_init(&ts->mutex);
>  
>  	error = goodix_get_gpio_config(ts);
>  	if (error)
> @@ -940,23 +1024,33 @@ static int goodix_ts_remove(struct i2c_client
> *client)
>  
>  	wait_for_completion(&ts->firmware_loading_complete);
>  
> +	pm_runtime_disable(&client->dev);
> +	pm_runtime_set_suspended(&client->dev);
> +	pm_runtime_put_noidle(&client->dev);
> +
>  	sysfs_remove_group(&client->dev.kobj, &goodix_attr_group);
>  	goodix_disable_esd(ts);
>  
>  	return 0;
>  }
>  
> -static int __maybe_unused goodix_suspend(struct device *dev)
> +static int __maybe_unused goodix_sleep(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct goodix_ts_data *ts = i2c_get_clientdata(client);
> -	int error;
> +	int error = 0;
>  
>  	/* We need gpio pins to suspend/resume */
>  	if (!ts->gpiod_int || !ts->gpiod_rst)
>  		return 0;
>  
>  	wait_for_completion(&ts->firmware_loading_complete);
> +
> +	mutex_lock(&ts->mutex);
> +
> +	if (ts->suspended)
> +		goto out_error;
> +
>  	goodix_disable_esd(ts);
>  
>  	/* Free IRQ as IRQ pin is used as output in the suspend
> sequence */
> @@ -966,7 +1060,7 @@ static int __maybe_unused goodix_suspend(struct
> device *dev)
>  	error = gpiod_direction_output(ts->gpiod_int, 0);
>  	if (error) {
>  		goodix_request_irq(ts);
> -		return error;
> +		goto out_error;
>  	}
>  
>  	usleep_range(5000, 6000);
> @@ -977,7 +1071,8 @@ static int __maybe_unused goodix_suspend(struct
> device *dev)
>  		dev_err(&ts->client->dev, "Screen off command
> failed\n");
>  		gpiod_direction_input(ts->gpiod_int);
>  		goodix_request_irq(ts);
> -		return -EAGAIN;
> +		error = -EAGAIN;
> +		goto out_error;
>  	}
>  
>  	/*
> @@ -986,44 +1081,77 @@ static int __maybe_unused
> goodix_suspend(struct device *dev)
>  	 * sooner, delay 58ms here.
>  	 */
>  	msleep(58);
> +	ts->suspended = true;
> +	mutex_unlock(&ts->mutex);
> +
>  	return 0;
> +
> +out_error:
> +	mutex_unlock(&ts->mutex);
> +	return error;
>  }
>  
> -static int __maybe_unused goodix_resume(struct device *dev)
> +static int __maybe_unused goodix_wakeup(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct goodix_ts_data *ts = i2c_get_clientdata(client);
> -	int error;
> +	int error = 0;
>  
>  	if (!ts->gpiod_int || !ts->gpiod_rst)
>  		return 0;
>  
> +	mutex_lock(&ts->mutex);
> +
> +	if (!ts->suspended)
> +		goto out_error;
> +
>  	/*
>  	 * Exit sleep mode by outputting HIGH level to INT pin
>  	 * for 2ms~5ms.
>  	 */
>  	error = gpiod_direction_output(ts->gpiod_int, 1);
>  	if (error)
> -		return error;
> +		goto out_error;
>  
>  	usleep_range(2000, 5000);
>  
>  	error = goodix_int_sync(ts);
>  	if (error)
> -		return error;
> +		goto out_error;
>  
>  	error = goodix_request_irq(ts);
>  	if (error)
> -		return error;
> +		goto out_error;
>  
>  	error = goodix_enable_esd(ts);
>  	if (error)
> -		return error;
> +		goto out_error;
> +
> +	ts->suspended = false;
> +	mutex_unlock(&ts->mutex);
>  
>  	return 0;
> +
> +out_error:
> +	mutex_unlock(&ts->mutex);
> +	return error;
> +}
> +
> +static int __maybe_unused goodix_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct goodix_ts_data *ts = i2c_get_clientdata(client);
> +
> +	if (!atomic_read(&ts->open_count))
> +		return 0;
> +
> +	return goodix_wakeup(dev);
>  }
>  
> -static SIMPLE_DEV_PM_OPS(goodix_pm_ops, goodix_suspend,
> goodix_resume);
> +static const struct dev_pm_ops goodix_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(goodix_sleep, goodix_resume)
> +	SET_RUNTIME_PM_OPS(goodix_sleep, goodix_wakeup, NULL)
> +};
>  
>  static const struct i2c_device_id goodix_ts_id[] = {
>  	{ "GDIX1001:00", 0 },
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
