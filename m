From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v4] input: Add MELFAS mms114 touchscreen driver
Date: Thu, 24 May 2012 10:32:04 +0900
Message-ID: <4FBD8F94.70605@samsung.com>
References: <1337325527-5272-1-git-send-email-jy0922.shim@samsung.com>
 <20120523115203.GA2506@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:8306 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845Ab2EXBcG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 May 2012 21:32:06 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M4I00G7K6XD3YA0@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Thu, 24 May 2012 10:32:04 +0900 (KST)
Received: from [165.213.219.123] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M4I00JZ26XGMDC0@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 24 May 2012 10:32:04 +0900 (KST)
In-reply-to: <20120523115203.GA2506@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.se>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com

Hi Henrik,

On 05/23/2012 08:52 PM, Henrik Rydberg wrote:
> Hi Joonyoung,
>
>> This is a initial driver for new touchscreen chip mms114 of MELFAS.
>> It uses I2C interface and supports 10 multi touch.
>>
>> Signed-off-by: Joonyoung Shim<jy0922.shim@samsung.com>
>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>> ---
> Look good overall, some minor comments below which may be
> ignored. Thank you,
>
>      Reviewed-by: Henrik Rydberg<rydberg@euromail.se>

I will update some codes with your comments. Thanks for review.

> Henrik
>
>> +static void mms114_proc_mt(struct mms114_data *data, u8 *buf)
>> +{
>> +	const struct mms114_platform_data *pdata = data->pdata;
>> +	struct i2c_client *client = data->client;
>> +	struct input_dev *input_dev = data->input_dev;
>> +	unsigned int id;
>> +	unsigned int type;
>> +	unsigned int pressed;
>> +	unsigned int x;
>> +	unsigned int y;
>> +	unsigned int width;
>> +	unsigned int strength;
>> +
>> +	id = (buf[0]&  MMS114_ID_MASK) - 1;
>> +	if (id>= MMS114_MAX_TOUCH) {
>> +		dev_dbg(&client->dev, "Wrong touch id (%d)\n", id);
>> +		return;
>> +	}
>> +
>> +	type = (buf[0]>>  MMS114_TYPE_OFFSET)&  MMS114_TYPE_MASK;
>> +	if (type != MMS114_TYPE_TOUCHSCREEN) {
>> +		dev_dbg(&client->dev, "Wrong touch type (%d)\n", type);
>> +		return;
>> +	}
>> +
>> +	x = buf[2] | (buf[1]&  0xf)<<  8;
>> +	y = buf[3] | ((buf[1]>>  4)&  0xf)<<  8;
>> +	if (x>  pdata->x_size || y>  pdata->y_size) {
>> +		dev_dbg(&client->dev, "Wrong touch coordinates (%d, %d)\n",
>> +				x, y);
>> +		return;
>> +	}
>> +
>> +	if (pdata->x_invert)
>> +		x = pdata->x_size - x;
>> +	if (pdata->y_invert)
>> +		y = pdata->y_size - y;
>> +
>> +	pressed = (buf[0]>>  MMS114_ACT_OFFSET)&  MMS114_ACT_MASK;
>> +	width = buf[4];
>> +	strength = buf[5];
> Why not pass a struct like this instead:
>
> struct mms114_touch {
>         u8 id : 4, type : 3, pressed : 1;
>         u8 x_hi : 4, y_hi : 4;
>         u8 x_lo;
>         u8 y_lo;
>         u8 width;
>         u8 strength;
> } __packed;
>
> Most of the code above would go away, together with some defines.

Yes, good idea.

>> +
>> +	dev_dbg(&client->dev, "id: %d, type: %d, pressed: %d\n",
>> +			id, type, pressed);
>> +	dev_dbg(&client->dev, "x: %d, y: %d, width: %d, strength: %d\n",
>> +			x, y, width, strength);
>> +
>> +	input_mt_slot(input_dev, id);
>> +	input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, pressed);
>> +
>> +	if (pressed) {
>> +		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, width);
>> +		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
>> +		input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
>> +		input_report_abs(input_dev, ABS_MT_PRESSURE, strength);
>> +	}
>> +}
>> +static int mms114_start(struct mms114_data *data)
>> +{
>> +	int error;
>> +
>> +	mutex_lock(&data->mutex);
>> +	if (!data->enabled) {
>> +		if (data->core_reg)
>> +			regulator_enable(data->core_reg);
>> +		if (data->io_reg)
>> +			regulator_enable(data->io_reg);
>> +		mdelay(MMS114_POWERON_DELAY);
>> +
>> +		error = mms114_setup_regs(data);
>> +		if (error<  0) {
>> +			mutex_unlock(&data->mutex);
>> +			return error;
>> +		}
>> +
>> +		data->enabled = true;
>> +	}
>> +	mutex_unlock(&data->mutex);
>> +	return 0;
>> +}
> A more canonical formulation of the above function would be:
>
>    int error = 0;
>
>    mutex_lock(&data->mutex);
>    if (data->enabled)
>            goto out;
>
>    if (data->core_reg)
>            regulator_enable(data->core_reg);
>    if (data->io_reg)
>            regulator_enable(data->io_reg);
>    mdelay(MMS114_POWERON_DELAY);
>
>    error = mms114_setup_regs(data);
>    if (error)
>            goto out;
>
>    data->enabled = true;
> out:
>    mutex_unlock(&data->mutex);
>    return error;
>

I don't want to return the variable of "error" name on error == 0 case,
just return 0, but i can use goto statement.

>> +static void mms114_stop(struct mms114_data *data)
>> +{
>> +	mutex_lock(&data->mutex);
>> +	if (data->enabled) {
>> +		if (data->io_reg)
>> +			regulator_disable(data->io_reg);
>> +		if (data->core_reg)
>> +			regulator_disable(data->core_reg);
>> +
>> +		data->enabled = false;
>> +	}
>> +	mutex_unlock(&data->mutex);
>> +}
> Ditto.
>
>> +static int mms114_suspend(struct device *dev)
>> +{
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	struct mms114_data *data = i2c_get_clientdata(client);
>> +	struct input_dev *input_dev = data->input_dev;
>> +	int id;
>> +
>> +	disable_irq(client->irq);
>> +
>> +	/* Release all touch */
>> +	for (id = 0; id<  MMS114_MAX_TOUCH; id++) {
>> +		input_mt_slot(input_dev, id);
>> +		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, false);
>> +	}
>> +
>> +	input_mt_report_pointer_emulation(input_dev, true);
>> +	input_sync(input_dev);
>> +
>> +	mutex_lock(&input_dev->mutex);
>> +	if (input_dev->users)
>> +		mms114_stop(data);
> It should really stop unconditionally here, but the above ought to
> yield the same result.

Right.

>> +	mutex_unlock(&input_dev->mutex);
>> +
>> +	if (data->pdata->cfg_pin)
>> +		data->pdata->cfg_pin(false);
>> +
>> +	return 0;
>> +}
>> +static int mms114_resume(struct device *dev)
>> +{
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	struct mms114_data *data = i2c_get_clientdata(client);
>> +	struct input_dev *input_dev = data->input_dev;
>> +	int error;
>> +
>> +	if (data->pdata->cfg_pin)
>> +		data->pdata->cfg_pin(true);
>> +
>> +	mutex_lock(&input_dev->mutex);
>> +	if (input_dev->users) {
>> +		error = mms114_start(data);
>> +		if (error<  0) {
>> +			mutex_unlock(&input_dev->mutex);
>> +			return error;
>> +		}
>> +	}
>> +	mutex_unlock(&input_dev->mutex);
>> +
>> +	enable_irq(client->irq);
>> +	return 0;
>> +}
> Could use more gotos here as well.
>
> Thanks,
> Henrik
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
