From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add driver for EETI touchpanels [v3]
Date: Fri, 15 May 2009 19:46:33 -0700
Message-ID: <20090516024602.GB12099@dtor-d630.eng.vmware.com>
References: <1242380193-15924-1-git-send-email-daniel@caiaq.de> <20090515094111.GD19808@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:65032 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220AbZEPCqj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2009 22:46:39 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1228239rvb.1
        for <linux-input@vger.kernel.org>; Fri, 15 May 2009 19:46:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090515094111.GD19808@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org

Hi Daniel,

Looks pretty good, a couple of things below. On the next iteration
please CC Jean Delvare for the I2C bits.

On Fri, May 15, 2009 at 11:41:11AM +0200, Daniel Mack wrote:
> +
> +	mutex_lock(&priv->mutex);
> +
> +	while (!gpio_get_value(irq_to_gpio(priv->irq)) && --to)
> +		i2c_master_recv(priv->client, buf, sizeof(buf));
> +
> +	if (!to) {
> +		dev_err(&priv->client->dev,
> +			"unable to clear IRQ - line stuck?\n");
> +		mutex_lock(&priv->mutex);

Tsk, tsk... Please just use standard "goto out;" schema and unlock the
mutex there.

> +		return;
> +	}
> +
> +	/* drop non-report packets */
> +	if (!(buf[0] & 0x80)) {
> +		mutex_unlock(&priv->mutex);
> +		return;
> +	}
> +
> +	pressed = buf[0] & REPORT_BIT_PRESSED;
> +	res = REPORT_RES_BITS(buf[0] & (REPORT_BIT_AD0 | REPORT_BIT_AD1));
> +	x = buf[2] | (buf[1] << 8);
> +	y = buf[4] | (buf[3] << 8);
> +
> +	/* fix the range to 11 bits */
> +	x >>= res - EETI_TS_BITDEPTH;
> +	y >>= res - EETI_TS_BITDEPTH;
> +
> +	if (flip_x)
> +		x = EETI_MAXVAL - x;
> +
> +	if (flip_y)
> +		y = EETI_MAXVAL - y;
> +
> +	if ((buf[0] & REPORT_BIT_HAS_PRESSURE) && !pressed)
> +		input_report_abs(priv->input, ABS_PRESSURE, buf[5]);

Please report the pressure always (if you have it of course), not only
at the beginning of the touch. This will allow userspace control
sensitivity.

> +
> +	input_report_abs(priv->input, ABS_X, x);
> +	input_report_abs(priv->input, ABS_Y, y);
> +	input_report_key(priv->input, BTN_TOUCH, !!pressed);
> +	input_sync(priv->input);
> +	mutex_unlock(&priv->mutex);
> +}
> +
> +static irqreturn_t eeti_ts_isr(int irq, void *dev_id)
> +{
> +	struct eeti_ts_priv *priv = dev_id;
> +
> +	 /* postpone I2C transactions as we are atomic */
> +	schedule_delayed_work(&priv->work, HZ / 100);

Why delayed work? I'd think you want to schedule it immediately.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int eeti_ts_open(struct input_dev *dev)
> +{
> +	struct eeti_ts_priv *priv = input_get_drvdata(dev);
> +
> +	enable_irq(priv->irq);
> +
> +	/* Read the events once to arm the IRQ */
> +	eeti_ts_read(&priv->work.work);
> +
> +	return 0;
> +}
> +
> +static void eeti_ts_close(struct input_dev *dev)
> +{
> +	struct eeti_ts_priv *priv = input_get_drvdata(dev);
> +
> +	disable_irq(priv->irq);
> +	cancel_delayed_work_sync(&priv->work);
> +}
> +
> +static int eeti_ts_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *idp)

__devinit?

> +{
> +	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +	struct eeti_ts_priv *priv;
> +	struct input_dev *input;
> +	int err = -ENOMEM;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
> +		return -EIO;
> +
> +	/* In contrast to what's described in the datasheet, there seems
> +	 * to be no way of probing the presence of that device using I2C
> +	 * commands. So we need to blindly believe it is there, and wait
> +	 * for interrupts to occur. */
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		dev_err(&client->dev, "failed to allocate driver data\n");
> +		goto err0;
> +	}
> +
> +	mutex_init(&priv->mutex);
> +	input = input_allocate_device();
> +
> +	if (!input) {
> +		dev_err(&client->dev, "Failed to allocate input device.\n");
> +		goto err1;
> +	}
> +
> +	input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> +	input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> +
> +	input_set_abs_params(input, ABS_X, 0, EETI_MAXVAL, 0, 0);
> +	input_set_abs_params(input, ABS_Y, 0, EETI_MAXVAL, 0, 0);
> +	input_set_abs_params(input, ABS_PRESSURE, 0, 0xff, 0, 0);
> +
> +	input->name = client->name;
> +	input->id.bustype = BUS_I2C;
> +	input->dev.parent = &client->dev;
> +	input->open = eeti_ts_open;
> +	input->close = eeti_ts_close;
> +
> +	input_set_drvdata(input, priv);
> +
> +	priv->client = client;
> +	priv->input = input;
> +	priv->irq = client->irq;
> +	dev_set_drvdata(&client->dev, priv);
> +	INIT_DELAYED_WORK(&priv->work, eeti_ts_read);
> +
> +	err = input_register_device(input);
> +	if (err)
> +		goto err1;
> +
> +	err = request_irq(priv->irq, eeti_ts_isr, IRQF_TRIGGER_FALLING,
> +			  client->name, priv);
> +	if (err) {
> +		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
> +		goto err2;
> +	}
> +
> +	/* Disable the irq for now. It will be enabled once the input device
> +	 * is opened. */
> +	disable_irq(priv->irq);
> +
> +	device_init_wakeup(&client->dev, 0);
> +	return 0;
> +
> +err2:
> +	input_unregister_device(input);
> +	input = NULL; /* so we dont try to free it below */
> +err1:
> +	input_free_device(input);
> +	kfree(priv);
> +err0:
> +	dev_set_drvdata(&client->dev, NULL);
> +	return err;
> +}
> +
> +static int eeti_ts_remove(struct i2c_client *client)

__devexit?

> +{
> +	struct eeti_ts_priv *priv = dev_get_drvdata(&client->dev);
> +
> +	free_irq(priv->irq, priv);
> +	input_unregister_device(priv->input);
> +	dev_set_drvdata(&client->dev, NULL);
> +	kfree(priv);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int eeti_ts_suspend(struct i2c_client *client, pm_message_t mesg)
> +{
> +	struct eeti_ts_priv *priv = dev_get_drvdata(&client->dev);
> +
> +	if (device_may_wakeup(&client->dev))
> +		enable_irq_wake(priv->irq);
> +
> +	return 0;
> +}
> +
> +static int eeti_ts_resume(struct i2c_client *client)
> +{
> +	struct eeti_ts_priv *priv = dev_get_drvdata(&client->dev);
> +
> +	if (device_may_wakeup(&client->dev))
> +		disable_irq_wake(priv->irq);
> +
> +	return 0;
> +}
> +#else
> +#define eeti_ts_suspend NULL
> +#define eeti_ts_resume NULL
> +#endif
> +
> +static const struct i2c_device_id eeti_ts_id[] = {
> +	{ "eeti_ts", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, eeti_ts_id);
> +
> +static struct i2c_driver eeti_ts_driver = {
> +	.driver = {
> +		.name = "eeti_ts",
> +	},
> +	.probe = eeti_ts_probe,
> +	.remove = eeti_ts_remove,

__devexit_p?

Thanks.

-- 
Dmitry
