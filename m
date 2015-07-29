From: Gregor Riepl <onitake@gmail.com>
Subject: Re: [PATCH v2] Add generic driver for Silead tochscreens
Date: Wed, 29 Jul 2015 02:00:13 +0200
Message-ID: <55B8178D.3040602@gmail.com>
References: <1437585906-9601-1-git-send-email-robert.dolca@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36840 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbbG2ABY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2015 20:01:24 -0400
Received: by wicgb10 with SMTP id gb10so177616055wic.1
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2015 17:01:22 -0700 (PDT)
In-Reply-To: <1437585906-9601-1-git-send-email-robert.dolca@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Dolca <robert.dolca@intel.com>, linux-input@vger.kernel.org

> +static int silead_ts_read_props(struct i2c_client *client)
> +{
> +	struct silead_ts_data *data = i2c_get_clientdata(client);
> +	struct device *dev = &client->dev;
> +	int error;
> +
> +	error = device_property_read_u16(dev, SILEAD_DP_X_MAX, &data->x_max);
> +	if (error) {
> +		dev_err(dev, "Resolution X read error %d\n", error);
> +		goto error;
> +	}
> +
> +	error = device_property_read_u16(dev, SILEAD_DP_Y_MAX, &data->y_max);
> +	if (error) {
> +		dev_err(dev, "Resolution Y read error %d\n", error);
> +		goto error;
> +	}
> +
> +	error = device_property_read_u8(dev, SILEAD_DP_MAX_FINGERS,
> +				      &data->max_fingers);
> +	if (error) {
> +		dev_err(dev, "Max fingers read error %d\n", error);
> +		goto error;
> +	}
> +
> +	error = device_property_read_string(dev, SILEAD_DP_FW_NAME,
> +					  &data->custom_fw_name);
> +	if (error)
> +		dev_info(dev, "Firmware file name read error. Using default.");
> +
> +	dev_dbg(dev, "X max = %d, Y max = %d, max fingers = %d",
> +		data->x_max, data->y_max, data->max_fingers);
> +
> +	return 0;
> +
> +error:
> +	return error;
> +}

May I add another suggestion here?

The maximum values for panel width and height are constrained to 4095, because
that is the maximum value the 12 bits of data returned by the controller can
contain. Similarly, the maximum number of touch points the Silead controllers
can handle seems to be 10, and this is reflected in the driver code.
(hard-coded buffer lengths, etc.)

So, instead of bailing out when a device property is not available, why not
set them to those values? Although it will require manual Xinput calibration
later, it certainly does not cause any harm, and will make the driver more
compatible without requiring ACPI or DT overrides.

> +static int silead_ts_probe(struct i2c_client *client,
> +			   const struct i2c_device_id *id)
> +{
> +	struct silead_ts_data *data;
> +	struct device *dev = &client->dev;
> +	int error;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_I2C |
> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK |
> +				     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
> +		dev_err(dev, "I2C functionality check failed\n");
> +		return -ENXIO;
> +	}
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, data);
> +	data->client = client;
> +
> +	error = silead_ts_set_default_fw_name(data, id);
> +	if (error)
> +		return error;
> +
> +	/* If the IRQ is not filled by DT or ACPI subsytem
> +	 * we can't continue without it */
> +	if (client->irq <= 0)
> +		return -ENODEV;
> +
> +	/* Power GPIO pin */
> +	data->gpio_power = devm_gpiod_get(dev, SILEAD_PWR_GPIO_NAME,
> +					  GPIOD_OUT_LOW);
> +	if (IS_ERR(data->gpio_power)) {
> +		dev_err(dev, "Shutdown GPIO request failed\n");
> +		return PTR_ERR(data->gpio_power);
> +	}

The DSDT for the device I have does not contain named GPIO definitions. As a
fallback, I'd suggest adding a check for an indexed pin as well, or maybe drop
the requirement for a definition. This may not be optimal, but at least in my
case, the device will work without it, as the powerup/sleep sequences are
encoded as ACPI _PS3/_PS0 methods - at least that's what the DSDT suggests,
and I can definitely get the touchscreen working without any manual GPIO work.

This leaves the finger tracking. If it is possible to determine finger
tracking availability in hardware through a model ID or hardware register, the
driver could enable in-kernel finger tracking automatically.
