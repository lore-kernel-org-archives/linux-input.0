From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v7] Touchscreen driver for FT5x06 based EDT displays
Date: Mon, 2 Jul 2012 11:31:07 +0200
Message-ID: <20120702093107.GA1286@polaris.bitmath.org>
References: <1340408898-491-1-git-send-email-simon.budig@kernelconcepts.de>
 <1341175006-24579-1-git-send-email-simon.budig@kernelconcepts.de>
 <1341175006-24579-2-git-send-email-simon.budig@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:47791 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932718Ab2GBJa6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Jul 2012 05:30:58 -0400
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 2F90FEB163
	for <linux-input@vger.kernel.org>; Mon,  2 Jul 2012 11:30:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1341175006-24579-2-git-send-email-simon.budig@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon.budig@kernelconcepts.de
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

Hi Simon,

> This is a driver for the EDT "Polytouch" family of touch controllers
> based on the FocalTech FT5x06 line of chips.
> 
> Signed-off-by: Simon Budig <simon.budig@kernelconcepts.de>
> ---

Thank you for the thorough set of changes. Some minor comments below.

> +#define MIN(a, b) (((a) < (b)) ? (a) : (b))

We have min() defined in kernel.h.

> +static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
> +{
> +	struct edt_ft5x06_ts_data *tsdata = dev_id;
> +	struct device *dev = &tsdata->client->dev;
> +	u8 cmd = 0xf9;
> +	u8 rdbuf[26];
> +	u8 crc;
> +	int i, type, x, y, id;
> +	int error;
> +
> +	memset(rdbuf, 0, sizeof(rdbuf));
> +
> +	error = edt_ft5x06_ts_readwrite(tsdata->client,
> +					sizeof(cmd), &cmd,
> +					sizeof(rdbuf), rdbuf);
> +	if (error) {
> +		dev_err_ratelimited(dev, "Unable to fetch data, error: %d\n",
> +				    error);
> +		goto out;
> +	}
> +
> +	if (rdbuf[0] != 0xaa || rdbuf[1] != 0xaa || rdbuf[2] != 26) {
> +		dev_err_ratelimited(dev, "Unexpected header: %02x%02x%02x!\n",
> +				    rdbuf[0], rdbuf[1], rdbuf[2]);
> +		goto out;
> +	}
> +
> +	crc = 0;
> +	for (i = 0; i < 25; i++)
> +		crc ^= rdbuf[i];
> +	if (crc != rdbuf[25]) {

A separate function for the crc check would be nice.

> +		dev_err_ratelimited(dev,
> +				    "crc error: 0x%02x expected, got 0x%02x\n",
> +				    crc, rdbuf[25]);

It is alright to let the string exceed 80 characters, even by checkpatch standards.

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


> +ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
> +					 char *buf,
> +					 size_t count,
> +					 loff_t *off)
> +{
> +	struct edt_ft5x06_ts_data *tsdata = file->private_data;
> +	int retries  = EDT_RAW_DATA_RETRIES;
> +	int ret = 0, error;
> +	int colbytes;
> +	int pos, endpos, start_off;
> +	char wrbuf[3];
> +	char *rdbuf;
> +
> +	colbytes = tsdata->num_y * 2;
> +
> +	if (*off < 0 || *off >= tsdata->num_x * colbytes)
> +		return 0;
> +
> +	rdbuf = kmalloc(colbytes, GFP_KERNEL);
> +	if (!rdbuf)
> +		return -ENOMEM;
> +
> +	mutex_lock(&tsdata->mutex);
> +
> +	if (!tsdata->factory_mode) {
> +		error = -EIO;
> +		goto out;
> +	}
> +
> +	error = edt_ft5x06_register_write(tsdata, 0x08, 0x01);
> +	if (error) {
> +		dev_dbg(&tsdata->client->dev,
> +			"failed to write 0x08 register, error %d\n",
> +			error);
> +		goto out;
> +	}
> +
> +	do {
> +		msleep(EDT_RAW_DATA_DELAY);
> +		ret = edt_ft5x06_register_read(tsdata, 0x08);
> +		if (ret < 1)
> +			break;
> +	} while (--retries > 0);
> +
> +	if (ret < 0) {
> +		error = ret;
> +		dev_dbg(&tsdata->client->dev,
> +			"failed to read 0x08 register, error %d\n",
> +			error);
> +		goto out;
> +	}
> +
> +	if (retries == 0) {
> +		dev_dbg(&tsdata->client->dev,
> +			"timed out waiting for register to settle\n");
> +		error = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	endpos = MIN(*off + count, colbytes * tsdata->num_x);
> +
> +	wrbuf[0] = 0xf5;
> +	wrbuf[1] = 0x0e;
> +	for (pos = *off; pos < endpos; pos += colbytes) {
> +		wrbuf[2] = pos / colbytes;  /* column index */
> +		error = edt_ft5x06_ts_readwrite(tsdata->client,
> +						sizeof(wrbuf), wrbuf,
> +						colbytes, rdbuf);
> +		if (error)
> +			goto out;
> +
> +		start_off = pos % colbytes;
> +		error = copy_to_user(buf + pos - *off, rdbuf + start_off,
> +				     MIN(colbytes - start_off, endpos - pos));

Quite a few variables in play here... it looks correct, but a)
breaking out parts of this function would not hurt, and b) I bet the
column-by column copy-to-user algorithm could be slightly less
involved.

> +		if (error)
> +			goto out;
> +
> +		pos -= start_off;
> +	}
> +
> +	ret = endpos - *off;
> +	if (!error)
> +		*off += ret;
> +out:
> +	mutex_unlock(&tsdata->mutex);
> +	kfree(rdbuf);
> +	return error ?: ret;
> +};


> +static int __devinit edt_ft5x06_ts_probe(struct i2c_client *client,
> +					 const struct i2c_device_id *id)
> +{
> +
> +	const struct edt_ft5x06_platform_data *pdata =
> +						client->dev.platform_data;
> +	struct edt_ft5x06_ts_data *tsdata;
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
> +	error = edt_ft5x06_ts_reset(client, pdata->reset_pin);
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
> +	error = edt_ft5x06_ts_identify(client, tsdata->name, fw_version);
> +	if (error) {
> +		dev_err(&client->dev, "touchscreen probe failed\n");
> +		goto err_free_mem;
> +	}
> +
> +	if (pdata->use_parameters) {
> +		/* pick up defaults from the platform data */
> +		if (pdata->threshold >= edt_ft5x06_attr_threshold.limit_low &&
> +		    pdata->threshold <= edt_ft5x06_attr_threshold.limit_high)
> +			edt_ft5x06_register_write(tsdata,
> +						  WORK_REGISTER_THRESHOLD,
> +						  pdata->threshold);
> +		if (pdata->gain >= edt_ft5x06_attr_gain.limit_low &&
> +		    pdata->gain <= edt_ft5x06_attr_gain.limit_high)
> +			edt_ft5x06_register_write(tsdata,
> +						  WORK_REGISTER_GAIN,
> +						  pdata->gain);
> +		if (pdata->offset >= edt_ft5x06_attr_offset.limit_low &&
> +		    pdata->offset <= edt_ft5x06_attr_offset.limit_high)
> +			edt_ft5x06_register_write(tsdata,
> +						  WORK_REGISTER_OFFSET,
> +						  pdata->offset);
> +		if (pdata->report_rate
> +				>= edt_ft5x06_attr_report_rate.limit_low &&
> +		    pdata->report_rate
> +				<= edt_ft5x06_attr_report_rate.limit_high)
> +			edt_ft5x06_register_write(tsdata,
> +						  WORK_REGISTER_REPORT_RATE,
> +						  pdata->report_rate);
> +	}

Putting this in a function, perhaps?

> +
> +	tsdata->threshold = edt_ft5x06_register_read(tsdata,
> +						     WORK_REGISTER_THRESHOLD);
> +	tsdata->gain = edt_ft5x06_register_read(tsdata, WORK_REGISTER_GAIN);
> +	tsdata->offset = edt_ft5x06_register_read(tsdata, WORK_REGISTER_OFFSET);
> +	tsdata->report_rate = edt_ft5x06_register_read(tsdata,
> +						WORK_REGISTER_REPORT_RATE);
> +	tsdata->num_x = edt_ft5x06_register_read(tsdata, WORK_REGISTER_NUM_X);
> +	tsdata->num_y = edt_ft5x06_register_read(tsdata, WORK_REGISTER_NUM_Y);

And this?

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
> +	error = input_mt_init_slots(input, MAX_SUPPORT_POINTS);
> +	if (error) {
> +		dev_err(&client->dev, "Unable to init MT slots.\n");
> +		goto err_free_mem;
> +	}
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
> +	error = sysfs_create_group(&client->dev.kobj, &edt_ft5x06_attr_group);
> +	if (error)
> +		goto err_free_irq;
> +
> +	error = input_register_device(input);
> +	if (error)
> +		goto err_remove_attrs;
> +
> +#if defined(CONFIG_DEBUG_FS)
> +	tsdata->debug_dir = debugfs_create_dir(dev_driver_string(&client->dev),
> +					       NULL);
> +
> +	if (tsdata->debug_dir) {
> +		debugfs_create_u16("num_x", S_IRUSR, tsdata->debug_dir,
> +				   &tsdata->num_x);
> +		debugfs_create_u16("num_y", S_IRUSR, tsdata->debug_dir,
> +				   &tsdata->num_y);
> +		debugfs_create_file("mode", S_IRUSR | S_IWUSR,
> +				    tsdata->debug_dir, tsdata,
> +				    &debugfs_mode_fops);
> +		debugfs_create_file("raw_data", S_IRUSR,
> +				    tsdata->debug_dir, tsdata,
> +				    &debugfs_raw_data_fops);
> +	}
> +#endif

And this?

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
> +	sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_attr_group);
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
