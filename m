From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] input: add synaptics_i2c driver
Date: Thu, 14 May 2009 16:28:42 +0200
Message-ID: <20090514162842.09182a39@hyperion.delvare>
References: <1242225003-8049-1-git-send-email-mike@compulab.co.il>
	<20090514025030.GB9461@dtor-d630.eng.vmware.com>
	<4A0C28AB.9030802@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:20060 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761618AbZENO2v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 May 2009 10:28:51 -0400
In-Reply-To: <4A0C28AB.9030802@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, grinberg@compulab.co.il, linux-input@vger.kernel.org

Hi Mike,

On Thu, 14 May 2009 17:20:27 +0300, Mike Rapoport wrote:
> I've addressed all the comments Jean had, and I hopefully haven't broke any I2C
> bits this time, so I dare to add Jean's Ack.
> 
> This driver supports Synaptics I2C touchpad controller on eXeda
> mobile device.

I keep seeing new bugs, sorry for missing this one during the previous
round:

> +static int __devinit synaptics_i2c_probe(struct i2c_client *client,
> +			       const struct i2c_device_id *dev_id)
> +{
> +	int ret;
> +	struct synaptics_i2c *touch;
> +
> +	touch = synaptics_i2c_touch_create(client);
> +	if (!touch)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, touch);
> +
> +	ret = synaptics_i2c_reset_config(client);
> +	if (ret)
> +		goto err_mem_free;
> +
> +	if (client->irq < 1)
> +		polling_req = 1;
> +
> +	touch->input = input_allocate_device();
> +	if (!touch->input)
> +		goto err_mem_free;

You jump without setting err to -ENOMEM. err is 0 at this point so you
will return success while the probe failed. Bad...

> +
> +	synaptics_i2c_set_input_params(touch);
> +
> +	if (!polling_req)
> +		dev_info(&touch->client->dev,
> +			  "IRQ will be used: %d\n", touch->client->irq);
> +	else
> +		dev_info(&touch->client->dev,
> +			  "Using polling at rate: %d times/sec\n", scan_rate);
> +
> +	/* Register the device in input subsystem */
> +	ret = input_register_device(touch->input);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			 "Input device register failed: %d\n", ret);
> +		goto err_input_free;
> +	}
> +	return 0;
> +
> +err_input_free:
> +	input_free_device(touch->input);
> +err_mem_free:
> +	i2c_set_clientdata(client, NULL);
> +	kfree(touch);
> +
> +	return ret;
> +}

Also note that:

> +static const struct i2c_device_id synaptics_i2c_id_table[] = {
> +	{ "synaptics_i2c", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, synaptics_i2c_id_table);

The "_i2c" in the device name is kind of redundant, as you are already
in the namespace of i2c devices. But that's up to you, it's only a
minor aesthetic issue.

All the rest looks OK.

-- 
Jean Delvare
