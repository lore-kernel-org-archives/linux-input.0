From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v3] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Tue, 29 Jun 2010 11:13:05 +0900
Message-ID: <4C2956B1.8030000@samsung.com>
References: <1277725091-13456-1-git-send-email-jy0922.shim@samsung.com>
 <20100628175500.GA7427@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:37327 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab0F2CNT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 22:13:19 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L4R009X07HUWE80@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Tue, 29 Jun 2010 11:13:07 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L4R00JE87HUJ8@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Tue, 29 Jun 2010 11:13:06 +0900 (KST)
In-reply-to: <20100628175500.GA7427@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com, rydberg@euromail.se, khali@linux-fr.org

On 6/29/2010 2:55 AM, Dmitry Torokhov wrote:
> On Mon, Jun 28, 2010 at 08:38:11PM +0900, Joonyoung Shim wrote:
>> +
>> +static int qt602240_load_fw(struct device *dev, const char *fn)
>> +{
>> +	struct qt602240_data *data = dev_get_drvdata(dev);
>> +	struct i2c_client *client = data->client;
>> +	const struct firmware *fw = NULL;
>> +	unsigned int frame_size;
>> +	unsigned int pos = 0;
>> +	int ret;
>> +
>> +	if (!data) {
>> +		dev_err(dev, "The data is NULL\n");
>> +		return -EFAULT;
>> +	}
>> +
>> +	ret = request_firmware(&fw, fn, dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Unable to open firmware %s\n", fn);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/* Change to the bootloader mode */
>> +	qt602240_write_object(data, QT602240_GEN_COMMAND,
>> +			QT602240_COMMAND_RESET, QT602240_BOOT_VALUE);
>> +	msleep(QT602240_RESET_TIME);
>> +
>> +	/* Change to slave address of bootloader */
>> +	if (client->addr == QT602240_APP_LOW)
>> +		client->addr = QT602240_BOOT_LOW;
>> +	else
>> +		client->addr = QT602240_BOOT_HIGH;
>> +
>> +	ret = qt602240_check_bootloader(client, QT602240_WAITING_BOOTLOAD_CMD);
>> +	if (ret < 0)
>> +		goto err_fw;
>> +
>> +	/* Unlock bootloader */
>> +	qt602240_unlock_bootloader(client);
>> +
>> +	while (pos < fw->size) {
>> +		ret = qt602240_check_bootloader(client,
>> +				QT602240_WAITING_FRAME_DATA);
>> +		if (ret < 0)
>> +			goto err_fw;
>> +
>> +		frame_size = ((*(fw->data + pos) << 8) | *(fw->data + pos + 1));
>> +
>> +		/* We should add 2 at frame size as the the firmware data is not
>> +		 * included the CRC bytes.
>> +		 */
>> +		frame_size += 2;
>> +
>> +		/* Write one frame to device */
>> +		qt602240_fw_write(client, fw->data + pos, frame_size);
>> +
>> +		ret = qt602240_check_bootloader(client,
>> +				QT602240_FRAME_CRC_PASS);
>> +		if (ret < 0)
>> +			goto err_fw;
>> +
>> +		pos += frame_size;
>> +
>> +		dev_dbg(dev, "Updated %zd bytes / %zd bytes\n", pos, fw->size);
>> +	}
>> +
>> +err_fw:
>> +	/* Change to slave address of application */
>> +	if (client->addr == QT602240_BOOT_LOW)
>> +		client->addr = QT602240_APP_LOW;
>> +	else
>> +		client->addr = QT602240_APP_HIGH;
> 
> You are missing call to release_firmware() and thus leaking memory.
> 

Yep, i will add it.

>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t qt602240_update_fw_store(struct device *dev,
>> +		struct device_attribute *attr, const char *buf, size_t count)
>> +{
>> +	struct qt602240_data *data = dev_get_drvdata(dev);
>> +	unsigned int version;
>> +	int ret;
>> +
>> +	if (sscanf(buf, "%u", &version) != 1) {
>> +		dev_err(dev, "Invalid values\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Firmware update supports from version 21 */
>> +	if ((data->info.version < QT602240_VER_21) ||
>> +			(version < QT602240_VER_21)) {
>> +		dev_err(dev, "Firmware update supports from version 21\n");
> 
> "Firmware updates suppored starting with version 21"
> 

Will fix.

>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Interrupt disable */
>> +	disable_irq(data->irq);
>> +
>> +	ret = qt602240_load_fw(dev, QT602240_FW_NAME);
>> +	if (ret < 0)
>> +		dev_err(dev, "The firmware update failed(%d)\n", ret);
>> +	else {
>> +		dev_dbg(dev, "The firmware update successed\n");
> 
> "succeeded"
>

Will fix.
 
>> +
>> +		/* Wait for reset */
>> +		msleep(QT602240_FWRESET_TIME);
>> +
>> +		kfree(data->object_table);
>> +
>> +		qt602240_initialize(data);
>> +	}
>> +
>> +	/* Interrupt enable */
>> +	enable_irq(data->irq);
>> +
>> +	return count;
>> +}
>> +
>> +static DEVICE_ATTR(object, 0444, qt602240_object_show, NULL);
>> +static DEVICE_ATTR(update_fw, 0664, NULL, qt602240_update_fw_store);
>> +
>> +static struct attribute *qt602240_attrs[] = {
>> +	&dev_attr_object.attr,
>> +	&dev_attr_update_fw.attr,
>> +	NULL
>> +};
>> +
>> +static const struct attribute_group qt602240_attr_group = {
>> +	.attrs = qt602240_attrs,
>> +};
>> +
>> +static int qt602240_input_open(struct input_dev *dev)
>> +{
>> +	struct qt602240_data *data = input_get_drvdata(dev);
>> +
>> +	/* Touch enable */
>> +	qt602240_write_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_CTRL,
>> +			0x83);
> 
> Do you want to do this if device is suspended?
> 

Yes, is it better to make and reuse start and stop functions?

>> +
>> +	return 0;
>> +}
>> +
>> +static void qt602240_input_close(struct input_dev *dev)
>> +{
>> +	struct qt602240_data *data = input_get_drvdata(dev);
>> +
>> +	/* Touch disable */
>> +	qt602240_write_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_CTRL,
>> +			0);
> 
> Same here.
> 
>> +}
>> +
>> +static int __devinit qt602240_probe(struct i2c_client *client,
>> +		const struct i2c_device_id *id)
>> +{
>> +	struct qt602240_data *data;
>> +	struct input_dev *input_dev;
>> +	int ret;
>> +
>> +	if (!client->dev.platform_data)
>> +		return -EINVAL;
>> +
>> +	data = kzalloc(sizeof(struct qt602240_data), GFP_KERNEL);
>> +
>> +	input_dev = input_allocate_device();
>> +	if (!data || !input_dev) {
>> +		dev_err(&client->dev, "Failed to allocate memory\n");
>> +		ret = -ENOMEM;
>> +		goto err_free_mem;
>> +	}
>> +
>> +	input_dev->name = "AT42QT602240/ATMXT224 Touchscreen";
>> +	input_dev->id.bustype = BUS_I2C;
>> +	input_dev->dev.parent = &client->dev;
>> +	input_dev->open = qt602240_input_open;
>> +	input_dev->close = qt602240_input_close;
>> +
>> +	__set_bit(EV_ABS, input_dev->evbit);
>> +	__set_bit(EV_KEY, input_dev->evbit);
>> +	__set_bit(BTN_TOUCH, input_dev->keybit);
>> +
>> +	/* For single touch */
>> +	input_set_abs_params(input_dev, ABS_X, 0, QT602240_MAX_XC, 0,
>> +			0);
>> +	input_set_abs_params(input_dev, ABS_Y, 0, QT602240_MAX_YC, 0,
>> +			0);
>> +
>> +	/* For multi touch */
>> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
>> +			QT602240_MAX_AREA, 0, 0);
>> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
>> +			QT602240_MAX_XC, 0, 0);
>> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
>> +			QT602240_MAX_YC, 0, 0);
>> +
>> +	input_set_drvdata(input_dev, data);
>> +
>> +	INIT_WORK(&data->ts_resume_work, qt602240_resume_worker);
>> +	data->client = client;
>> +	data->input_dev = input_dev;
>> +	data->pdata = client->dev.platform_data;
>> +	data->irq = client->irq;
>> +
>> +	i2c_set_clientdata(client, data);
>> +
>> +	ret = qt602240_initialize(data);
>> +	if (ret < 0)
>> +		goto err_free_object;
>> +
>> +	ret = request_threaded_irq(client->irq, NULL, qt602240_interrupt,
>> +			IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
>> +
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "Failed to register interrupt\n");
>> +		goto err_free_object;
>> +	}
>> +
>> +	ret = input_register_device(input_dev);
>> +	if (ret < 0)
>> +		goto err_free_irq;
>> +
>> +	ret = sysfs_create_group(&client->dev.kobj, &qt602240_attr_group);
>> +	if (ret)
>> +		goto err_unregister_device;
>> +
>> +	return 0;
>> +
>> +err_unregister_device:
>> +	input_unregister_device(input_dev);
>> +err_free_irq:
>> +	free_irq(client->irq, data);
>> +err_free_object:
>> +	kfree(data->object_table);
>> +err_free_mem:
>> +	input_free_device(input_dev);
>> +	kfree(data);
>> +	return ret;
>> +}
>> +
>> +static int __devexit qt602240_remove(struct i2c_client *client)
>> +{
>> +	struct qt602240_data *data = i2c_get_clientdata(client);
>> +
>> +	free_irq(data->irq, data);
>> +	cancel_work_sync(&data->ts_resume_work);
>> +	input_unregister_device(data->input_dev);
>> +	kfree(data->object_table);
>> +	kfree(data);
>> +
>> +	sysfs_remove_group(&client->dev.kobj, &qt602240_attr_group);
>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int qt602240_suspend(struct i2c_client *client, pm_message_t mesg)
>> +{
>> +	struct qt602240_data *data = i2c_get_clientdata(client);
>> +	struct input_dev *input_dev = data->input_dev;
>> +
>> +	mutex_lock(&input_dev->mutex);
>> +
>> +	if (input_dev->users)
>> +		/* Touch disable */
>> +		qt602240_write_object(data, QT602240_TOUCH_MULTI,
>> +				QT602240_TOUCH_CTRL, 0);
>> +
>> +	mutex_unlock(&input_dev->mutex);
>> +
>> +	return 0;
>> +}
>> +
>> +static int qt602240_resume(struct i2c_client *client)
>> +{
>> +	struct qt602240_data *data = i2c_get_clientdata(client);
>> +
>> +	schedule_work(&data->ts_resume_work);
> 
> Like I said, I am concerned with pulling resume work out of line. The
> rest of the system might start accessing device that is not ready yet
> but is already marked as resumed. I'd rather did that short sleep right
> here in resume function.
> 

OK, resume work maybe cannot guarantee the device ready state 
immediately after resume. The clear way than uncertain would be better.

> Also, please CC Jean Delvare to make sure I2C bits look good.
> 

I add him to CC.

Thanks.
