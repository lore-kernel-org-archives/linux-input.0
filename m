From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3] input: add driver for pixcir i2c touchscreens
Date: Mon, 4 Jul 2011 22:49:35 +0200
Message-ID: <20110704204935.GB22437@polaris.bitmath.org>
References: <4DDB2516.6050302@pixcir.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:50251 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab1GDUrs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2011 16:47:48 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 0456AEA3B0
	for <linux-input@vger.kernel.org>; Mon,  4 Jul 2011 22:47:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DDB2516.6050302@pixcir.com.cn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jcbian <jcbian@pixcir.com.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, dqmeng <dqmeng@pixcir.com.cn>, zlchen <zlchen@pixcir.com.cn>

Hi jcbian,

> This patch adds a driver for PIXCIR's I2C connected touchscreens.
> Request the IRQ by doing request_threaded_irq() as v3.

Some MT comments below.

> +static int pixcir_ts_poscheck(struct pixcir_i2c_ts_data *data)

Perhaps it is possible to find a more descriptive name?

> +{
> +	struct pixcir_i2c_ts_data *tsdata = data;
> +
> +	u8 touching, oldtouching;
> +	u16 posx1, posy1, posx2, posy2;
> +	u8 rdbuf[10], wrbuf[1];
> +	int ret;
> +
> +	memset(wrbuf, 0, sizeof(wrbuf));
> +	memset(rdbuf, 0, sizeof(rdbuf));
> +
> +	wrbuf[0] = 0;
> +	ret = i2c_master_send(tsdata->client, wrbuf, 1);
> +	if (ret != 1) {
> +		dev_err(&tsdata->client->dev, "Unable to write to i2c touchscreen!\n");
> +		goto out;
> +	}

How about returning the error code here directly instead?

> +
> +	ret = i2c_master_recv(tsdata->client, rdbuf, sizeof(rdbuf));
> +	if (ret != sizeof(rdbuf)) {
> +		dev_err(&tsdata->client->dev, "Unable to read i2c page!\n");
> +		goto out;
> +	}

Ditto.

> +
> +	touching = rdbuf[0];
> +	oldtouching = rdbuf[1];

Is oldtouching ever used?

> +	posx1 = ((rdbuf[3] << 8) | rdbuf[2]);
> +	posy1 = ((rdbuf[5] << 8) | rdbuf[4]);
> +	posx2 = ((rdbuf[7] << 8) | rdbuf[6]);
> +	posy2 = ((rdbuf[9] << 8) | rdbuf[8]);
> +
> +	input_report_key(tsdata->input, BTN_TOUCH, touching);
> +
> +	if (touching == 1) {
> +		input_report_abs(tsdata->input, ABS_X, posx1);
> +		input_report_abs(tsdata->input, ABS_Y, posy1);
> +	}

No MT data for one finger?

> +
> +	if (touching == 2) {
> +		input_report_abs(tsdata->input, ABS_MT_POSITION_X, posx1);
> +		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, posy1);
> +		input_mt_sync(tsdata->input);
> +
> +		input_report_abs(tsdata->input, ABS_MT_POSITION_X, posx2);
> +		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, posy2);
> +		input_mt_sync(tsdata->input);
> +	} else
> +		input_mt_sync(tsdata->input);

input_mt_sync() is always called, please simplify.

> +	input_sync(tsdata->input);
> +
> +	return 0;
> +
> +out:
> +	return -EINVAL;
> +}
> +
[...]
> +static int pixcir_i2c_ts_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct pixcir_i2c_ts_data *tsdata;
> +	struct input_dev *input;
> +	const struct pixcir_i2c_ts_platform *pdata =
> +					client->dev.platform_data;
> +	int error;
> +
> +	if (!pdata) {
> +		dev_err(&client->dev, "platform data not defined\n");
> +		return -EINVAL;
> +	}
> +
> +	tsdata = kzalloc(sizeof(*tsdata), GFP_KERNEL);
> +	if (!tsdata) {
> +		dev_err(&client->dev, "Failed to allocate driver data!\n");
> +		error = -ENOMEM;
> +		dev_set_drvdata(&client->dev, NULL);
> +		return error;
> +	}
> +
> +	dev_set_drvdata(&client->dev, tsdata);
> +
> +	input = input_allocate_device();
> +	if (!input) {
> +		dev_err(&client->dev, "Failed to allocate input device!\n");
> +		error = -ENOMEM;
> +		input_free_device(input);
> +		kfree(tsdata);
> +	}
> +
> +	init_waitqueue_head(&tsdata->wait);
> +
> +	input->name = client->name;
> +	input->id.bustype = BUS_I2C;
> +	input->dev.parent = &client->dev;
> +
> +	input->close = pixcir_ts_close;
> +
> +	input_set_drvdata(input, tsdata);
> +
> +	tsdata->client = client;
> +	tsdata->input = input;
> +	tsdata->chip = pdata;
> +	tsdata->irq = client->irq;
> +
> +	set_bit(EV_SYN, input->evbit);
> +	set_bit(EV_KEY, input->evbit);
> +	set_bit(EV_ABS, input->evbit);
> +	set_bit(BTN_TOUCH, input->keybit);
> +	input_set_abs_params(input, ABS_X, 0, pdata->ts_x_max, 0, 0);
> +	input_set_abs_params(input, ABS_Y, 0, pdata->ts_y_max, 0, 0);
> +	input_set_abs_params(input, ABS_MT_POSITION_X, 0, pdata->ts_x_max, 0, 0);
> +	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, pdata->ts_y_max, 0, 0);

Is the device not capable of finger tracking? If not, it might be time
to turn finger tracking on in the input core. It is preferrable to use
protocol B these days.

> +
> +	if (input_register_device(input)) {
> +		input_free_device(input);
> +		kfree(tsdata);
> +	}
> +
> +	if (request_threaded_irq(tsdata->irq, NULL, pixcir_ts_isr,
> +			IRQF_TRIGGER_FALLING, client->name, tsdata)) {
> +		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
> +		input_unregister_device(input);
> +		input = NULL;
> +	}
> +
> +	device_init_wakeup(&client->dev, 1);
> +
> +	return 0;
> +}

Thanks,
Henrik
