From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v6] Touchscreen driver for FT5x06 based EDT displays
Date: Mon, 25 Jun 2012 10:51:13 +0200
Message-ID: <20120625085113.GA648@polaris.bitmath.org>
References: <1333564079-23893-2-git-send-email-simon.budig@kernelconcepts.de>
 <1340408898-491-1-git-send-email-simon.budig@kernelconcepts.de>
 <1340408898-491-2-git-send-email-simon.budig@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:58735 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358Ab2FYIsH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 04:48:07 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id E2221C8DF
	for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 10:48:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1340408898-491-2-git-send-email-simon.budig@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon.budig@kernelconcepts.de
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

Hi Simon,

> +The driver allows configuration of the touch screen via a set of sysfs files:
> +
> +/sys/class/input/eventX/device/device/threshold:
> +    allows setting the "click"-threshold in the range from 20 to 80.
> +
> +/sys/class/input/eventX/device/device/gain:
> +    allows setting the sensitivity in the range from 0 to 31. Note that
> +    lower values indicate higher sensitivity.
> +
> +/sys/class/input/eventX/device/device/offset:
> +    allows setting the edge compensation in the range from 0 to 31.
> +
> +/sys/class/input/eventX/device/device/report_rate:
> +    allows setting the report rate in the range from 3 to 14.

I would very much prefer if the driver functioned well without such
settings, since they complicate userspace and are not likely to ever
go away. Oh well.

> +The touch screens have a "factory mode" that allows access to the raw sensor
> +data. However, the above mentioned settings are not available in this mode.
> +In particular this limits the use of the raw data for tuning the parameters
> +to a specific setup. Also the scan rate of the touch screen changes compared
> +to the regular operation mode.
> +
> +To access the raw data switch to factory mode:
> +    echo 1 > /sys/class/input/eventX/device/device/mode
> +
> +then read out the "raw_data" file. It contains X*Y big endian 16 bit values
> +where X and Y are the number of sensor fields of the touch glass. These values
> +are model specific and get be determined by dividing maximum x and y
> +coordinate by 64.
> +
> +Note that reading raw_data gives a I/O error when the device is not in factory
> +mode. The same happens when reading/writing to the parameter files when the
> +device is not in regular operation mode.

Raw data is nice (and an alternative driver could output only such
data), but extending the input interface by adding adhoc sysfs files
is far from optimal. Several devices of this kind have appeared
recently, so it is clear that the input interface is lacking.  I would
prefer if the raw data be moved to debugfs, awaiting a more stable
solution.  Dmitry, any opinion on this?

> +static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
> +{
> +	struct edt_ft5x06_i2c_ts_data *tsdata = dev_id;
> +	u8 cmd = 0xf9;
> +	u8 rdbuf[26];
> +	int i, type, x, y, id;
> +	int error;
> +
> +	memset(rdbuf, 0, sizeof(rdbuf));
> +
> +	error = edt_ft5x06_ts_readwrite(tsdata->client,
> +					sizeof(cmd), &cmd,
> +					sizeof(rdbuf), rdbuf);
> +	if (error) {
> +		dev_err(&tsdata->client->dev,
> +			"Unable to write to fetch data, error: %d\n", error);
> +		goto out;
> +	}

No risk of flooding the logs here? Perhaps rate-limit the outputs?

> +
> +	if (rdbuf[0] != 0xaa || rdbuf[1] != 0xaa || rdbuf[2] != 26) {
> +		dev_err(&tsdata->client->dev,
> +			"Unexpected header: %02x%02x%02x!\n",
> +			rdbuf[0], rdbuf[1], rdbuf[2]);
> +		goto out;
> +	}
> +
> +	for (i = 0; i < MAX_SUPPORT_POINTS; i++) {
> +		u8 *buf = &rdbuf[i * 4];
> +		bool down;
> +
> +		type = buf[5] >> 6;
> +		/* ignore Reserved events */
> +		if (type == TOUCH_EVENT_RESERVED)
> +			continue;

As per the implementation by Olivier, it seems these touches may get
stuck in the down position. No?

> +
> +		x = ((buf[5] << 8) | buf[6]) & 0x0fff;
> +		y = ((buf[7] << 8) | buf[8]) & 0x0fff;
> +		id = (buf[7] >> 4) & 0x0f;
> +		down = (type != TOUCH_EVENT_UP);
> +
> +		input_mt_slot(tsdata->input, id);
> +		input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER, down);
> +
> +		if (!down)
> +			continue;
> +
> +		input_report_abs(tsdata->input, ABS_MT_POSITION_X, x);
> +		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, y);
> +	}
> +
> +	input_mt_report_pointer_emulation(tsdata->input, true);
> +	input_sync(tsdata->input);
> +
> +out:
> +	return IRQ_HANDLED;
> +}

[...]

> +static int __devinit edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
> +					     const struct i2c_device_id *id)
> +{
> +
> +	const struct edt_ft5x06_platform_data *pdata =
> +						client->dev.platform_data;
> +	struct edt_ft5x06_i2c_ts_data *tsdata;
> +	struct input_dev *input;
> +	int error;
> +	char fw_version[EDT_NAME_LEN];
> +
> +	dev_dbg(&client->dev, "probing for EDT FT5x06 I2C\n");
> +
> +	if (!pdata) {
> +		dev_err(&client->dev, "no platform data?\n");
> +		return -EINVAL;
> +	}
> +
> +	error = edt_ft5x06_i2c_ts_reset(client, pdata->reset_pin);
> +	if (error)
> +		return error;
> +
> +	if (gpio_is_valid(pdata->irq_pin)) {
> +		error = gpio_request_one(pdata->irq_pin,
> +					 GPIOF_IN, "edt-ft5x06 irq");
> +		if (error) {
> +			dev_err(&client->dev,
> +				"Failed to request GPIO %d, error %d\n",
> +				pdata->irq_pin, error);
> +			return error;
> +		}
> +	}
> +
> +	tsdata = kzalloc(sizeof(*tsdata), GFP_KERNEL);
> +	input = input_allocate_device();
> +	if (!tsdata || !input) {
> +		dev_err(&client->dev, "failed to allocate driver data.\n");
> +		error = -ENOMEM;
> +		goto err_free_mem;
> +	}
> +
> +	mutex_init(&tsdata->mutex);
> +	tsdata->client = client;
> +	tsdata->input = input;
> +	tsdata->factory_mode = false;
> +
> +	error = edt_ft5x06_i2c_ts_identify(client, tsdata->name, fw_version);
> +	if (error) {
> +		dev_err(&client->dev, "touchscreen probe failed\n");
> +		goto err_free_mem;
> +	}
> +
> +	tsdata->threshold = edt_ft5x06_i2c_register_read(tsdata,
> +						WORK_REGISTER_THRESHOLD);
> +	tsdata->gain = edt_ft5x06_i2c_register_read(tsdata,
> +						WORK_REGISTER_GAIN);
> +	tsdata->offset = edt_ft5x06_i2c_register_read(tsdata,
> +						WORK_REGISTER_OFFSET);
> +	tsdata->report_rate = edt_ft5x06_i2c_register_read(tsdata,
> +						WORK_REGISTER_REPORT_RATE);
> +	tsdata->num_x = edt_ft5x06_i2c_register_read(tsdata,
> +						WORK_REGISTER_NUM_X);
> +	tsdata->num_y = edt_ft5x06_i2c_register_read(tsdata,
> +						WORK_REGISTER_NUM_Y);
> +
> +	dev_dbg(&client->dev,
> +		"Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
> +		tsdata->name, fw_version, tsdata->num_x, tsdata->num_y);
> +
> +	input->name = tsdata->name;
> +	input->id.bustype = BUS_I2C;
> +	input->dev.parent = &client->dev;
> +
> +	__set_bit(EV_SYN, input->evbit);
> +	__set_bit(EV_KEY, input->evbit);
> +	__set_bit(EV_ABS, input->evbit);
> +	__set_bit(BTN_TOUCH, input->keybit);
> +	input_set_abs_params(input, ABS_X, 0, tsdata->num_x * 64 - 1, 0, 0);
> +	input_set_abs_params(input, ABS_Y, 0, tsdata->num_y * 64 - 1, 0, 0);
> +	input_set_abs_params(input, ABS_MT_POSITION_X,
> +			     0, tsdata->num_x * 64 - 1, 0, 0);
> +	input_set_abs_params(input, ABS_MT_POSITION_Y,
> +			     0, tsdata->num_y * 64 - 1, 0, 0);
> +	input_mt_init_slots(input, MAX_SUPPORT_POINTS);

No error checking here?

> +
> +	input_set_drvdata(input, tsdata);
> +	i2c_set_clientdata(client, tsdata);
> +
> +	error = request_threaded_irq(client->irq, NULL, edt_ft5x06_ts_isr,
> +				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				     client->name, tsdata);
> +	if (error) {
> +		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
> +		goto err_free_mem;
> +	}
> +
> +	error = sysfs_create_group(&client->dev.kobj,
> +				   &edt_ft5x06_i2c_attr_group);
> +	if (error)
> +		goto err_free_irq;
> +
> +	error = input_register_device(input);
> +	if (error)
> +		goto err_remove_attrs;
> +
> +	device_init_wakeup(&client->dev, 1);
> +
> +	dev_dbg(&tsdata->client->dev,
> +		"EDT FT5x06 initialized: IRQ pin %d, Reset pin %d.\n",
> +		pdata->irq_pin, pdata->reset_pin);
> +
> +	return 0;
> +
> +err_remove_attrs:
> +	sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_i2c_attr_group);
> +err_free_irq:
> +	free_irq(client->irq, tsdata);
> +err_free_mem:
> +	input_free_device(input);
> +	kfree(tsdata);
> +
> +	if (gpio_is_valid(pdata->irq_pin))
> +		gpio_free(pdata->irq_pin);
> +
> +	return error;
> +}

Thanks,
Henrik
