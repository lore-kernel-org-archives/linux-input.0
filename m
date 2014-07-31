From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: Re: [PATCH] input: Add ROHM BU21023/24 Dual touch support resistive
 touchscreens
Date: Thu, 31 Jul 2014 17:24:42 +0530
Message-ID: <53DA2E82.1040704@smartplayin.com>
References: <20140731195434.d141b39f3920686485c64191@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp120.ord1c.emailsrvr.com ([108.166.43.120]:54448 "EHLO
	smtp120.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750702AbaGaLvA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jul 2014 07:51:00 -0400
In-Reply-To: <20140731195434.d141b39f3920686485c64191@linux-mips.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Yoichi,

On Thursday 31 July 2014 04:24 PM, Yoichi Yuasa wrote:
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  drivers/input/touchscreen/Kconfig        |   11 +
>  drivers/input/touchscreen/Makefile       |    1 +
>  drivers/input/touchscreen/rohm_bu21023.c |  791 ++++++++++++++++++++++++++++++
>  drivers/input/touchscreen/rohm_bu21023.h |  255 ++++++++++
>  4 files changed, 1058 insertions(+)

[snip]

> +
> +/*
> + * rohm_i2c_burst_read - execute combined I2C message for ROHM BU21023/24
> + * @adap: Handle to I2C bus
> + * @msgs: combined messages to execute
> + * @num: Number of messages to be executed.
> + *
> + * Returns negative errno, else the number of messages executed.
> + *
> + * Note
> + * In BU21023/24 burst read, stop condition is needed after "address write".
> + * Therefore, transmission is performed in 2 steps.
> + */
> +static inline int rohm_i2c_burst_read(struct i2c_adapter *adap,
> +				      struct i2c_msg *msgs, int num)
> +{
> +	int ret, i;
> +
> +	if (!adap->algo->master_xfer) {
> +		dev_dbg(&adap->dev, "I2C level transfers not supported\n");
Should it be dev_err?

> +		return -EOPNOTSUPP;
> +	}
> +
> +	i2c_lock_adapter(adap);
> +
> +	for (i = 0; i < num; i++) {
> +		ret = __i2c_transfer(adap, &msgs[i], 1);
.
[snip]
.
> +
> +	return 0;
> +}
> +
> +static int rohm_bu21023_i2c_probe(struct i2c_client *client,
> +				  const struct i2c_device_id *id)
> +{
> +	struct rohm_ts_data *ts;
> +	struct device *dev = &client->dev;
> +	struct input_dev *input_dev;
> +	int ret;
> +
> +	ts = kzalloc(sizeof(struct rohm_ts_data), GFP_KERNEL);
Can you please move to managed resources? devm_kzalloc in this case?

> +	if (!ts)
> +		return -ENOMEM;
> +
> +	INIT_WORK(&ts->work, rohm_ts_work_func);
> +
> +	ts->client = client;
> +	i2c_set_clientdata(client, ts);
> +
> +	ret = rohm_ts_device_init(client);
> +	if (ret) {
> +		dev_err(dev, "Failed to device initialization\n");
> +		goto err_ts_free_exit;
> +	}
> +
> +	input_dev = input_allocate_device();
Same here as well. You can use devm_input_allocate_device here. These
helps in error handling and clean unbinding of driver.

> +	if (!input_dev) {
> +		ret = -ENOMEM;
> +		dev_err(dev, "Failed to allocate input device\n");
> +		goto err_ts_free_exit;
> +	}
> +
> +	input_dev->name = BU21023_NAME;
> +	input_dev->id.bustype = BUS_I2C;
> +	input_dev->dev.parent = &client->dev;
> +
> +	ts->input_dev = input_dev;
> +
> +	set_bit(EV_SYN, input_dev->evbit);
> +	set_bit(EV_KEY, input_dev->evbit);
> +	set_bit(EV_ABS, input_dev->evbit);
> +
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> +			     ROHM_TS_ABS_X_MIN, ROHM_TS_ABS_X_MAX, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> +			     ROHM_TS_ABS_Y_MIN, ROHM_TS_ABS_Y_MAX, 0, 0);
> +
> +	ret = input_register_device(input_dev);
> +	if (ret) {
> +		dev_err(dev, "Unable to register input device\n");
> +		goto err_input_free_device_exit;
> +	}
> +
> +	ts->workqueue = create_singlethread_workqueue("rohm_ts_wq");
> +	if (!ts->workqueue) {
> +		dev_err(dev, "Cannot create workqueue\n");
> +		ret = -ENOMEM;
> +		goto err_input_unregister_device_exit;
> +	}
> +
> +	if (client->irq) {
> +		ret = request_irq(client->irq, rohm_ts_irq_handler,
> +				  IRQF_TRIGGER_FALLING, client->name, ts);
Use devm_request_irq.
> +
> +		/* If the request IRQ failed, use polling mode */
> +		if (!ret)
> +			ts->use_irq = 1;
> +	}
> +
> +	hrtimer_init(&ts->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	ts->hrtimer.function = rohm_ts_timer_func;
> +	if (!ts->use_irq)
> +		hrtimer_start(&ts->hrtimer, INACTIVE_POLLING_INTERVAL_KTIME,
> +			      HRTIMER_MODE_REL);
> +
> +	dev_info(dev, "%s mode\n", ts->use_irq ? "interrupt" : "polling");
> +
> +	return 0;
> +
> +err_input_unregister_device_exit:
> +	input_unregister_device(input_dev);
> +
> +err_input_free_device_exit:
> +	input_free_device(input_dev);
> +
> +err_ts_free_exit:
> +	kfree(ts);
> +
> +	return ret;
You can get rid of these lables with managed resources as they will be
release automatically when device is unbinded.

> +}
> +
> +static int rohm_bu21023_i2c_remove(struct i2c_client *client)
> +{
> +	struct rohm_ts_data *ts = i2c_get_clientdata(client);
> +
> +	if (ts->use_irq)
> +		free_irq(client->irq, ts);
Use of Managed resources will get rid of this as well.
> +	else
> +		hrtimer_cancel(&ts->hrtimer);
> +
> +	if (ts->workqueue)
> +		destroy_workqueue(ts->workqueue);
> +
> +	input_unregister_device(ts->input_dev);
This too.
> +
> +	i2c_smbus_write_byte_data(client, SYSTEM,
> +				  ANALOG_POWER_ON | CPU_POWER_OFF);
> +
> +	i2c_smbus_write_byte_data(client, SYSTEM,
> +				  ANALOG_POWER_OFF | CPU_POWER_OFF);
> +
> +	kfree(ts);
This too.
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id rohm_bu21023_i2c_id[] = {
> +	{BU21023_NAME, 0},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, rohm_bu21023_i2c_id);
> +
> +static struct i2c_driver rohm_bu21023_i2c_driver = {
> +	.driver = {
> +		   .name = BU21023_NAME,
> +		   },
> +	.probe = rohm_bu21023_i2c_probe,
> +	.remove = rohm_bu21023_i2c_remove,
> +	.id_table = rohm_bu21023_i2c_id,
> +};
> +
> +module_i2c_driver(rohm_bu21023_i2c_driver);
> +
> +MODULE_DESCRIPTION("ROHM BU21023/24 Touchscreen driver");
> +MODULE_LICENSE("GPL");
Make it GPL v2.
MODULE_AUTHOR missing.

> diff --git a/drivers/input/touchscreen/rohm_bu21023.h b/drivers/input/touchscreen/rohm_bu21023.h
> new file mode 100644
> index 0000000..2db32848
> --- /dev/null
> +++ b/drivers/input/touchscreen/rohm_bu21023.h

[snip]

> 
