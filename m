From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] input: add synaptics_i2c driver
Date: Thu, 14 May 2009 09:28:18 +0200
Message-ID: <20090514092818.39a83282@hyperion.delvare>
References: <1242225003-8049-1-git-send-email-mike@compulab.co.il>
	<20090514025030.GB9461@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:28968 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760043AbZENH2d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 May 2009 03:28:33 -0400
In-Reply-To: <20090514025030.GB9461@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, grinberg@compulab.co.il, linux-input@vger.kernel.org

Hi Mike, Dmitry,

On Wed, 13 May 2009 19:50:39 -0700, Dmitry Torokhov wrote:
> On Wed, May 13, 2009 at 05:30:03PM +0300, Mike Rapoport wrote:
> > From: Igor Grinberg <grinberg@compulab.co.il>
> > 
> > This patch adds support for Synaptics i2c touchpad controller found on
> > eXeda machine.
> 
> I am CCing Jean Delvare for review of I2C bits.

Here you go:

> > +static s32 synaptics_i2c_reg_get(struct i2c_client *client, u16 reg)
> > +{
> > +	int ret;
> > +
> > +	ret = i2c_smbus_write_byte_data(client, PAGE_SEL_REG, reg >> 8);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 	i2c_smbus_read_byte_data(client, reg & 0xff);

Doubled space.

> > +}
> > +
> > +static s32 synaptics_i2c_reg_set(struct i2c_client *client, u16 reg, u8 val)
> > +{
> > +	int ret;
> > +
> > +	ret = i2c_smbus_write_byte_data(client, PAGE_SEL_REG, reg >> 8);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return i2c_smbus_write_byte_data(client, reg & 0xff, val);
> > +}
> > +
> > +static s32 synaptics_i2c_word_get(struct i2c_client *client, u16 reg)
> > +{
> > +	int ret;
> > +
> > +	ret = i2c_smbus_write_byte_data(client, PAGE_SEL_REG, reg >> 8);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return i2c_smbus_read_word_data(client, reg & 0xff);
> > +}
> > +
> > +static s32 synaptics_i2c_block_read(struct i2c_client *client,
> > +				    u16 reg, u8 length, u8 *values)

Function name is a little inconsistent (_read vs. _get/_set).

> > +{
> > +	int ret;
> > +
> > +	ret = i2c_smbus_write_byte_data(client, PAGE_SEL_REG, reg >> 8);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return i2c_smbus_read_i2c_block_data(client, reg & 0xff,
> > +					     length, values);
> > +}

All the functions above lack a common locking mechanism. As register
access needs to select a page beforehand, this is not atomic at the bus
level so you need to serialize access yourself. Unless concurrent call
of the functions above is never possible by design, of course, but you
should add a comment explaining this then.

> > +
> > +static int synaptics_i2c_query(struct i2c_client *client)
> > +{
> > +	u8 data[7];
> > +	char id[PRODUCT_ID_LENGTH + 1];
> > +	int ret, retry_count, control, status, sens;
> > +
> > +	/* DEV_QUERY_REG0 is the Function Query area for 2D devices. */
> > +	/* We're only interested in entries DEV_QUERY_REG2 */
> > +	/* and following registers right now. */
> > +	for (retry_count = 0; retry_count < 3; retry_count++) {

You try up to 3 times...

> > +		ret = synaptics_i2c_block_read(client, DEV_QUERY_REG2,
> > +					       sizeof(data), data);
> > +		if (ret != sizeof(data))
> > +			continue;
> > +
> > +		dev_info(&client->dev, "Number of extra positions: %d\n",
> > +			  data[0] & NUM_EXTRA_POS_MSK);
> > +		dev_info(&client->dev, "Has 2D Scroll: %d\n",
> > +			  GET_BIT(HAS_2D_SCROLL, data[1]));
> > +		dev_info(&client->dev, "Has Scroller: %d\n",
> > +			  GET_BIT(HAS_SCROLLER, data[1]));
> > +		dev_info(&client->dev, "Has Multifing: %d\n",
> > +			  GET_BIT(HAS_MULTI_FING, data[1]));
> > +		dev_info(&client->dev, "Has Palm Det: %d\n",
> > +			  GET_BIT(HAS_PALM_DETECT, data[1]));
> > +		dev_info(&client->dev, "Sensor Max X: %d\n",
> > +			((data[2] & MSB_POSITION_MSK) << REGISTER_LENGTH)
> > +			| data[3]);
> > +		dev_info(&client->dev, "Sensor Max Y: %d\n",
> > +			((data[4] & MSB_POSITION_MSK) << REGISTER_LENGTH)
> > +			| data[5]);
> > +		dev_info(&client->dev, "Sensor Resolution: %d\n", data[6]);
> > +		break;
> > +	}
> > +	if (retry_count >= 5)
> > +		dev_warn(&client->dev,
> > +			  "Query command failed: block read failed\n");

... but only warn about errors after 5 failures. This is never going to
happen. I suggest moving all the dev_info() calls out of the above loop
and changing the second test to make the code more robust:

	for (retry_count = 0; retry_count < 3; retry_count++) {
		ret = synaptics_i2c_block_read(client, DEV_QUERY_REG2,
					       sizeof(data), data);
		if (ret == sizeof(data))
			break;
	}

	if (ret != sizeof(data)) {
		dev_warn(&client->dev, ...);
	} else {
		dev_info(&client->dev, ...);
		dev_info(&client->dev, ...);
		dev_info(&client->dev, ...);
		...
	}

> > (...)
> > +struct synaptics_i2c *synaptics_i2c_touch_create(struct i2c_client *client)
> > +{
> > +	struct synaptics_i2c *touch;
> > +
> > +	touch = kzalloc(sizeof(struct synaptics_i2c), GFP_KERNEL);
> > +	if (!touch)
> > +		return NULL;
> > +
> > +	memset(touch, 0, sizeof(struct synaptics_i2c));

That's pointless, kzalloc() already did it for you.

> > +	touch->client = client;
> > +	touch->no_decel_param = no_decel;
> > +	touch->scan_rate_param = scan_rate;
> > +	set_scan_rate(touch, scan_rate);
> > +	touch->accel_param = accel;
> > +	set_acceleration(touch, accel);
> > +	init_completion(&touch->touch_completion);
> > +	init_completion(&touch->thread_completion);
> > +
> > +	return touch;
> > +}
> > +

> > (...)
> > +static const struct i2c_device_id synaptics_i2c_id_table[] = {
> > +	{ DRIVER_NAME, 0 },

This is conceptually wrong, what goes in this table are _device_ names
and not _driver_ names - even though it might happen to be the same
string in your case.

> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(i2c, synaptics_i2c_id_table);
> > +
> > +static int synaptics_i2c_probe(struct i2c_client *client,
> > +			       const struct i2c_device_id *dev_id)
> > +{
> > +	int ret;
> > +	struct synaptics_i2c *touch = NULL;

Initialization not needed AFAICS.

> > +
> > +	ret = synaptics_i2c_reset_config(client);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (query) {
> > +		ret = synaptics_i2c_query(client);
> > +		if (ret) {
> > +			dev_err(&client->dev, "Query failed: %d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	touch = synaptics_i2c_touch_create(client);
> > +	if (!touch)
> > +		goto err_mem;
> > +
> > +	i2c_set_clientdata(client, touch);
> > +
> > +	if (client->irq < 1)
> > +		polling_req = 1;
> > +
> > +	touch->input = input_allocate_device();
> > +	if (!touch->input)
> > +		goto err_mem;
> > +
> > +	synaptics_i2c_set_input_params(touch);
> > +
> > +	if (!polling_req)
> > +		dev_info(&touch->client->dev,
> > +			  "IRQ will be used: %d\n", touch->client->irq);
> > +	else
> > +		dev_info(&touch->client->dev,
> > +			  "Using polling at rate: %d times/sec\n", scan_rate);
> > +
> > +	/* Register the device in input subsystem */
> > +	ret = input_register_device(touch->input);
> > +	if (ret) {
> > +		dev_err(&client->dev,
> > +			 "Input device register failed: %d\n", ret);
> > +		goto err_free;
> > +	}
> > +	return 0;
> > +
> > +err_mem:
> > +	dev_err(&client->dev, "Insufficient memory\n");
> > +	ret = -ENOMEM;
> > +
> > +err_free:
> > +	input_free_device(touch->input);

touch may be NULL at this point, in which case your driver will crash.
This whole error path is weird, you should really just undo things in
the reverse order the function did them to avoid that kind of mistake.

> > +	i2c_set_clientdata(client, NULL);
> > +	kfree(touch);
> > +
> > +	return ret;
> > +}

The rest looks OK.

-- 
Jean Delvare
