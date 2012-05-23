From: "Henrik Rydberg" <rydberg@bitmath.se>
Subject: Re: [PATCH v4] input: Add MELFAS mms114 touchscreen driver
Date: Wed, 23 May 2012 13:52:03 +0200
Message-ID: <20120523115203.GA2506@polaris.bitmath.org>
References: <1337325527-5272-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp2.one.com ([91.198.169.22]:15849 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939Ab2EWLpW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 May 2012 07:45:22 -0400
Content-Disposition: inline
In-Reply-To: <1337325527-5272-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com

Hi Joonyoung,

> This is a initial driver for new touchscreen chip mms114 of MELFAS.
> It uses I2C interface and supports 10 multi touch.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---

Look good overall, some minor comments below which may be
ignored. Thank you,

    Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Henrik

> +static void mms114_proc_mt(struct mms114_data *data, u8 *buf)
> +{
> +	const struct mms114_platform_data *pdata = data->pdata;
> +	struct i2c_client *client = data->client;
> +	struct input_dev *input_dev = data->input_dev;
> +	unsigned int id;
> +	unsigned int type;
> +	unsigned int pressed;
> +	unsigned int x;
> +	unsigned int y;
> +	unsigned int width;
> +	unsigned int strength;
> +
> +	id = (buf[0] & MMS114_ID_MASK) - 1;
> +	if (id >= MMS114_MAX_TOUCH) {
> +		dev_dbg(&client->dev, "Wrong touch id (%d)\n", id);
> +		return;
> +	}
> +
> +	type = (buf[0] >> MMS114_TYPE_OFFSET) & MMS114_TYPE_MASK;
> +	if (type != MMS114_TYPE_TOUCHSCREEN) {
> +		dev_dbg(&client->dev, "Wrong touch type (%d)\n", type);
> +		return;
> +	}
> +
> +	x = buf[2] | (buf[1] & 0xf) << 8;
> +	y = buf[3] | ((buf[1] >> 4) & 0xf) << 8;
> +	if (x > pdata->x_size || y > pdata->y_size) {
> +		dev_dbg(&client->dev, "Wrong touch coordinates (%d, %d)\n",
> +				x, y);
> +		return;
> +	}
> +
> +	if (pdata->x_invert)
> +		x = pdata->x_size - x;
> +	if (pdata->y_invert)
> +		y = pdata->y_size - y;
> +
> +	pressed = (buf[0] >> MMS114_ACT_OFFSET) & MMS114_ACT_MASK;
> +	width = buf[4];
> +	strength = buf[5];

Why not pass a struct like this instead:

struct mms114_touch {
       u8 id : 4, type : 3, pressed : 1;
       u8 x_hi : 4, y_hi : 4;
       u8 x_lo;
       u8 y_lo;
       u8 width;
       u8 strength;
} __packed;

Most of the code above would go away, together with some defines.

> +
> +	dev_dbg(&client->dev, "id: %d, type: %d, pressed: %d\n",
> +			id, type, pressed);
> +	dev_dbg(&client->dev, "x: %d, y: %d, width: %d, strength: %d\n",
> +			x, y, width, strength);
> +
> +	input_mt_slot(input_dev, id);
> +	input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, pressed);
> +
> +	if (pressed) {
> +		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, width);
> +		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
> +		input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
> +		input_report_abs(input_dev, ABS_MT_PRESSURE, strength);
> +	}
> +}

> +static int mms114_start(struct mms114_data *data)
> +{
> +	int error;
> +
> +	mutex_lock(&data->mutex);
> +	if (!data->enabled) {
> +		if (data->core_reg)
> +			regulator_enable(data->core_reg);
> +		if (data->io_reg)
> +			regulator_enable(data->io_reg);
> +		mdelay(MMS114_POWERON_DELAY);
> +
> +		error = mms114_setup_regs(data);
> +		if (error < 0) {
> +			mutex_unlock(&data->mutex);
> +			return error;
> +		}
> +
> +		data->enabled = true;
> +	}
> +	mutex_unlock(&data->mutex);
> +	return 0;
> +}

A more canonical formulation of the above function would be:

  int error = 0;

  mutex_lock(&data->mutex);
  if (data->enabled)
          goto out;

  if (data->core_reg)
          regulator_enable(data->core_reg);
  if (data->io_reg)
          regulator_enable(data->io_reg);
  mdelay(MMS114_POWERON_DELAY);

  error = mms114_setup_regs(data);
  if (error)
          goto out;

  data->enabled = true;
out:
  mutex_unlock(&data->mutex);
  return error;


> +static void mms114_stop(struct mms114_data *data)
> +{
> +	mutex_lock(&data->mutex);
> +	if (data->enabled) {
> +		if (data->io_reg)
> +			regulator_disable(data->io_reg);
> +		if (data->core_reg)
> +			regulator_disable(data->core_reg);
> +
> +		data->enabled = false;
> +	}
> +	mutex_unlock(&data->mutex);
> +}

Ditto.

> +static int mms114_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mms114_data *data = i2c_get_clientdata(client);
> +	struct input_dev *input_dev = data->input_dev;
> +	int id;
> +
> +	disable_irq(client->irq);
> +
> +	/* Release all touch */
> +	for (id = 0; id < MMS114_MAX_TOUCH; id++) {
> +		input_mt_slot(input_dev, id);
> +		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, false);
> +	}
> +
> +	input_mt_report_pointer_emulation(input_dev, true);
> +	input_sync(input_dev);
> +
> +	mutex_lock(&input_dev->mutex);
> +	if (input_dev->users)
> +		mms114_stop(data);

It should really stop unconditionally here, but the above ought to
yield the same result.

> +	mutex_unlock(&input_dev->mutex);
> +
> +	if (data->pdata->cfg_pin)
> +		data->pdata->cfg_pin(false);
> +
> +	return 0;
> +}

> +static int mms114_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mms114_data *data = i2c_get_clientdata(client);
> +	struct input_dev *input_dev = data->input_dev;
> +	int error;
> +
> +	if (data->pdata->cfg_pin)
> +		data->pdata->cfg_pin(true);
> +
> +	mutex_lock(&input_dev->mutex);
> +	if (input_dev->users) {
> +		error = mms114_start(data);
> +		if (error < 0) {
> +			mutex_unlock(&input_dev->mutex);
> +			return error;
> +		}
> +	}
> +	mutex_unlock(&input_dev->mutex);
> +
> +	enable_irq(client->irq);
> +	return 0;
> +}

Could use more gotos here as well.

Thanks,
Henrik
