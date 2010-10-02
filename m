From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCHv5] input: ROHM BU21013 touch panel controller support
Date: Sat, 02 Oct 2010 08:24:40 +0200
Message-ID: <4CA6D028.7090102@euromail.se>
References: <1285930790-2206-1-git-send-email-naveen.gaddipati@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:40795 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751646Ab0JBGZ6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Oct 2010 02:25:58 -0400
In-Reply-To: <1285930790-2206-1-git-send-email-naveen.gaddipati@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Naveen Kumar G <naveen.gaddipati@stericsson.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, STEricsson_nomadik_linux@list.st.com, linux-input@vger.kernel.org, tsoni@codeaurora.org

On 10/01/2010 12:59 PM, Naveen Kumar G wrote:

> From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> 
> Added the ROHM BU21013 capacitive touch panel controller
> driver support with i2c interface.
> 
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> ---


Thank you very much for the changes. Please find a couple of comments inline.
Dmitry, with the comments addressed, feel free to add

Acked-by: Henrik Rydberg <rydberg@euromail.se>

> +static int bu21013_do_touch_report(struct bu21013_ts_data *data)
> +{
> +	u8	buf[LENGTH_OF_BUFFER];
> +	unsigned int pos_x[2], pos_y[2];
> +	bool	has_x_sensors, has_y_sensors;
> +	int	finger_down_count = 0;
> +	int	i;
> +
> +	if (data == NULL)
> +		return -EINVAL;
> +
> +	if (bu21013_read_block_data(data, buf) < 0)
> +		return -EINVAL;
> +
> +	has_x_sensors = hweight32(buf[0] & BU21013_SENSORS_EN_0_7);
> +	has_y_sensors = hweight32(((buf[1] & BU21013_SENSORS_EN_8_15) |
> +		((buf[2] & BU21013_SENSORS_EN_16_23) << SHIFT_8)) >> SHIFT_2);


The bitcounting hweight32 can actually be removed here.

> +	if (!has_x_sensors || !has_y_sensors)
> +		return 0;
> +
> +	for (i = 0; i < MAX_FINGERS; i++) {
> +		const u8 *p = &buf[4 * i + 3];
> +		unsigned int x = p[0] << SHIFT_2 | (p[1] & MASK_BITS);
> +		unsigned int y = p[2] << SHIFT_2 | (p[3] & MASK_BITS);
> +		if (x == 0 || y == 0)
> +			continue;
> +		pos_x[finger_down_count] = x;
> +		pos_y[finger_down_count] = y;
> +		finger_down_count++;
> +	}
> +
> +	if (finger_down_count == 2 &&
> +	    (abs(pos_x[0] - pos_x[1]) < DELTA_MIN ||
> +	     abs(pos_y[0] - pos_y[1]) < DELTA_MIN))
> +		return 0;
> +
> +	if (finger_down_count <= 0) {
> +		input_report_abs(data->in_dev, ABS_MT_TOUCH_MAJOR, 0);


Please do not use ABS_MT_TOUCH_MAJOR, since the device does not support it.

> +		input_mt_sync(data->in_dev);
> +	} else {
> +		for (i = 0; i < finger_down_count; i++) {
> +			if (data->chip->x_flip)
> +				pos_x[i] = data->chip->touch_x_max - pos_x[i];
> +			if (data->chip->y_flip)
> +				pos_y[i] = data->chip->touch_y_max - pos_y[i];
> +			input_report_abs(data->in_dev, ABS_MT_TOUCH_MAJOR,
> +						max(pos_x[i], pos_y[i]));
> +			input_report_abs(data->in_dev, ABS_MT_POSITION_X,
> +								pos_x[i]);
> +			input_report_abs(data->in_dev, ABS_MT_POSITION_Y,
> +								pos_y[i]);
> +			input_mt_sync(data->in_dev);
> +		}
> +	}


The pointer emulation ABS_X/ABS_Y/BTN_TOUCH was removed? Fine with me.

> +	input_sync(data->in_dev);
> +
> +	return 0;
> +}

[...]

> +static int __devinit bu21013_probe(struct i2c_client *client,
> +					const struct i2c_device_id *id)
> +{
> +	int retval;
> +	struct bu21013_ts_data *bu21013_data;
> +	struct input_dev *in_dev;
> +	const struct bu21013_platform_device *pdata =
> +					client->dev.platform_data;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +					I2C_FUNC_SMBUS_BYTE_DATA)) {
> +		dev_err(&client->dev, "i2c smbus byte data not supported\n");
> +		return -EIO;
> +	}
> +
> +	if (!pdata) {
> +		dev_err(&client->dev, "platform data not defined\n");
> +		retval = -EINVAL;
> +		return retval;
> +	}
> +
> +	bu21013_data = kzalloc(sizeof(struct bu21013_ts_data), GFP_KERNEL);
> +	if (!bu21013_data) {
> +		dev_err(&client->dev, "device memory alloc failed\n");
> +		retval = -ENOMEM;
> +		return retval;
> +	}
> +	/* allocate input device */
> +	in_dev = input_allocate_device();
> +	if (!in_dev) {
> +		dev_err(&client->dev, "input device memory alloc failed\n");
> +		retval = -ENOMEM;
> +		goto err_alloc;
> +	}
> +	bu21013_data->in_dev = in_dev;
> +	bu21013_data->chip = pdata;
> +	bu21013_data->client = client;
> +
> +	/* configure the gpio pins */
> +	if (pdata->cs_en) {
> +		retval = pdata->cs_en(pdata->cs_pin);
> +		if (retval < 0) {
> +			dev_err(&client->dev, "chip init failed\n");
> +			goto err_init_cs;
> +		}
> +	}
> +
> +	/* configure the touch panel controller */
> +	retval = bu21013_init_chip(bu21013_data);
> +	if (retval < 0) {
> +		dev_err(&client->dev, "error in bu21013 config\n");
> +		goto err_init_config;
> +	}
> +
> +	init_waitqueue_head(&bu21013_data->wait);
> +	bu21013_data->touch_stopped = false;
> +
> +	/* register the device to input subsystem */
> +	in_dev->name = DRIVER_TP;
> +	in_dev->id.bustype = BUS_I2C;
> +	in_dev->dev.parent = &client->dev;
> +
> +	__set_bit(EV_SYN, in_dev->evbit);
> +	__set_bit(EV_KEY, in_dev->evbit);
> +	__set_bit(EV_ABS, in_dev->evbit);
> +
> +	input_set_abs_params(in_dev, ABS_MT_POSITION_X, 0,
> +						pdata->x_max_res, 0, 0);
> +	input_set_abs_params(in_dev, ABS_MT_POSITION_Y, 0,
> +						pdata->y_max_res, 0, 0);
> +	input_set_abs_params(in_dev, ABS_MT_TOUCH_MAJOR, 0,
> +			max(pdata->x_max_res , pdata->y_max_res), 0, 0);


Same here - no ABS_MT_TOUCH_MAJOR, please.

> +	input_set_drvdata(in_dev, bu21013_data);
> +	retval = input_register_device(in_dev);
> +	if (retval)
> +		goto err_input_register;
> +
> +	retval = request_threaded_irq(pdata->irq, NULL, bu21013_gpio_irq,
> +					(IRQF_TRIGGER_FALLING | IRQF_SHARED),
> +					DRIVER_TP, bu21013_data);
> +	if (retval) {
> +		dev_err(&client->dev, "request irq %d failed\n", pdata->irq);
> +		goto err_init_irq;
> +	}
> +
> +	device_init_wakeup(&client->dev, pdata->wakeup);
> +	i2c_set_clientdata(client, bu21013_data);
> +
> +	return retval;
> +
> +err_init_irq:
> +	input_unregister_device(bu21013_data->in_dev);
> +	bu21013_data->in_dev = NULL;
> +err_input_register:
> +err_init_config:
> +	pdata->cs_dis(pdata->cs_pin);
> +err_init_cs:
> +	input_free_device(bu21013_data->in_dev);
> +err_alloc:
> +	kfree(bu21013_data);
> +
> +	return retval;
> +}


Thanks,
Henrik
