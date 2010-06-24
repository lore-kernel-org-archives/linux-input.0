From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Thu, 24 Jun 2010 09:58:05 +0900
Message-ID: <4C22AD9D.2020402@samsung.com>
References: <1277298967-22596-1-git-send-email-jy0922.shim@samsung.com>
 <20100623173438.GB11512@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:48329 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955Ab0FXA6r (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jun 2010 20:58:47 -0400
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L4H00DSTUOPV4B0@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 24 Jun 2010 09:58:01 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L4H002V8UOPMD@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Thu, 24 Jun 2010 09:58:01 +0900 (KST)
In-reply-to: <20100623173438.GB11512@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com, Henrik Rydberg <rydberg@euromail.se>

On 6/24/2010 2:34 AM, Dmitry Torokhov wrote:
> Hi Joonyoung,
> 
> On Wed, Jun 23, 2010 at 10:16:07PM +0900, Joonyoung Shim wrote:
>> +
>> +static void qt602240_input_read(struct qt602240_data *data)
>> +{
>> +	struct qt602240_message message;
>> +	struct qt602240_object *object;
>> +	struct device *dev = &data->client->dev;
>> +	struct input_dev *input_dev = data->input_dev;
>> +	u8 reportid;
>> +	u8 max_reportid;
>> +	u8 min_reportid;
>> +
>> +repeat:
>> +	if (qt602240_read_message(data, &message)) {
>> +		dev_err(dev, "Failed to read message\n");
>> +		return;
>> +	}
>> +
>> +	reportid = message.reportid;
>> +
>> +	/* Check it remains the message to process */
>> +	if (reportid == 0xff)
>> +		return;
>> +
>> +	/* whether reportid is thing of QT602240_TOUCH_MULTI */
>> +	object = qt602240_get_object(data, QT602240_TOUCH_MULTI);
>> +	if (!object)
>> +		return;
>> +
>> +	max_reportid = object->max_reportid;
>> +	min_reportid = max_reportid - object->num_report_ids + 1;
>> +
>> +	if ((reportid >= min_reportid) && (reportid <= max_reportid)) {
>> +		u8 id;
>> +		u8 status;
>> +		int x;
>> +		int y;
>> +		int area;
>> +		int finger_num = 0;
>> +
>> +		id = reportid - min_reportid;
>> +		status = message.message[0];
>> +
>> +		/* Check the touch is present on the screen */
>> +		if (!(status & QT602240_DETECT))
>> +			goto release;
>> +
>> +		/* Check only AMP detection */
>> +		if (!(status & (QT602240_PRESS | QT602240_MOVE)))
>> +			goto repeat;
>> +
>> +		x = (message.message[1] << 2) |
>> +			((message.message[3] & ~0x3f) >> 6);
>> +		y = (message.message[2] << 2) |
>> +			((message.message[3] & ~0xf3) >> 2);
>> +		area = message.message[4];
>> +
>> +		dev_dbg(dev, "[%d] %s x: %d, y: %d, area: %d\n", id,
>> +				status & QT602240_MOVE ?  "moved" : "pressed",
>> +				x, y, area);
>> +
>> +		data->finger[id].status = status & QT602240_MOVE ?
>> +			QT602240_MOVE : QT602240_PRESS;
>> +		data->finger[id].x = x;
>> +		data->finger[id].y = y;
>> +		data->finger[id].area = area;
>> +
>> +		input_report_key(input_dev, BTN_TOUCH, 1);
>> +		input_report_abs(input_dev, ABS_X, x);
>> +		input_report_abs(input_dev, ABS_Y, y);
>> +
>> +		goto mt_report;
>> +
>> +release:
>> +		if (status & QT602240_RELEASE) {
>> +			dev_dbg(dev, "[%d] released\n", id);
>> +
>> +			data->finger[id].status = QT602240_RELEASE;
>> +			data->finger[id].area = 0;
>> +		}
>> +
>> +mt_report:
>> +		for (id = 0; id < QT602240_MAX_FINGER; id++) {
>> +			if (!data->finger[id].status)
>> +				continue;
>> +
>> +			input_report_abs(input_dev, ABS_MT_TRACKING_ID, id);
>> +			input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
>> +					data->finger[id].area);
>> +
>> +			if (data->finger[id].status == QT602240_RELEASE)
>> +				data->finger[id].status = 0;
>> +			else {
>> +				input_report_abs(input_dev, ABS_MT_POSITION_X,
>> +						data->finger[id].x);
>> +				input_report_abs(input_dev, ABS_MT_POSITION_Y,
>> +						data->finger[id].y);
>> +				finger_num++;
>> +			}
>> +
>> +			input_mt_sync(input_dev);
>> +		}
>> +
>> +		if (!finger_num)
>> +			input_report_key(input_dev, BTN_TOUCH, 0);
>> +		input_sync(input_dev);
>> +	} else {
>> +		qt602240_dump_message(dev, &message);
>> +		qt602240_check_config_error(data, &message, reportid);
>> +	}
>> +
>> +	goto repeat;
> 
> I really dislike gotos that implement logic flow control (i.e. for me
> gotos are acceptable in error path and in one-off cases when you restart
> processing, like the CRC error in one of the functions above). Please do
> not use old Fortran stylein kernel.
> 

OK. I used while statement at first then it gave me deep depth 
statements, but i will change goto to other as your opinion.

>> +}
>> +
>> +static void qt602240_irq_worker(struct work_struct *work)
>> +{
>> +	struct qt602240_data *data = container_of(work,
>> +			struct qt602240_data, ts_event_work);
>> +
>> +	qt602240_input_read(data);
>> +}
>> +
>> +static void qt602240_disable_worker(struct work_struct *work)
>> +{
>> +	struct qt602240_data *data = container_of(work,
>> +			struct qt602240_data, ts_disable_work);
>> +
>> +	/* Soft reset */
>> +	qt602240_write_object(data, QT602240_GEN_COMMAND,
>> +			QT602240_COMMAND_RESET, 1);
>> +
>> +	msleep(QT602240_RESET_TIME);
>> +
>> +	/* Touch enable */
>> +	qt602240_write_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_CTRL,
>> +			0x83);
>> +}
>> +
>> +static irqreturn_t qt602240_interrupt(int irq, void *dev_id)
>> +{
>> +	struct qt602240_data *data = dev_id;
>> +
>> +	if (!work_pending(&data->ts_event_work))
>> +		schedule_work(&data->ts_event_work);
>> +
> 
> Thios begs for use of threaded IRQs.
> 

OK.

>> +	return IRQ_HANDLED;
>> +}
>> +
>> +
>> +static int qt602240_initialize(struct qt602240_data *data)
>> +{
>> +	struct i2c_client *client = data->client;
>> +	struct qt602240_info *info;
>> +	int i;
>> +	int ret;
>> +	u16 reg;
>> +	u8 buf[QT602240_OBJECT_SIZE];
>> +	u8 reportid = 0;
>> +
>> +	info = data->info = kzalloc(sizeof(struct qt602240_info), GFP_KERNEL);
> 
> Why do you allocate it separately instead of embedding (entire
> structure) into qt602240_data?
> 

Right, it's better.

>> +
>> +	if (!info) {
>> +		dev_err(&data->client->dev, "Failed to allocate memory\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +
>> +		pos += frame_size;
>> +
>> +		dev_info(dev, "Updated %zd bytes / %zd bytes\n", pos, fw->size);
> 
> dev_dbg() maybe?
> 

OK.

>> +	}
>> +
>> +err_fw:
>> +	/* Change to slave address of application */
>> +	if (data->client->addr == QT602240_BOOT_LOW)
>> +		data->client->addr = QT602240_APP_LOW;
>> +	else
>> +		data->client->addr = QT602240_APP_HIGH;
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
>> +	if ((data->info->version < QT602240_VER_21) ||
>> +			(version < QT602240_VER_21)) {
>> +		dev_err(dev, "Firmware update supports from version 21\n");
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
>> +		dev_info(dev, "The firmware update successed\n");
> 
> dev_dbg() as well.
> 

OK.

>> +
>> +		/* Wait for reset */
>> +		msleep(QT602240_FWRESET_TIME);
>> +
>> +		kfree(data->object_table);
>> +		kfree(data->info);
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
>> +static int __devinit qt602240_probe(struct i2c_client *client,
>> +		const struct i2c_device_id *id)
>> +{
>> +	struct qt602240_data *data;
>> +	struct input_dev *input_dev = NULL;
> 
> No need to initialize to NULL.
> 

OK.

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
>> +	input_set_abs_params(input_dev, ABS_MT_TRACKING_ID, 0,
>> +			QT602240_MAX_ID, 0, 0);
>> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
>> +			QT602240_MAX_AREA, 0, 0);
>> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
>> +			QT602240_MAX_XC, 0, 0);
>> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
>> +			QT602240_MAX_YC, 0, 0);
>> +
>> +	input_set_drvdata(input_dev, data);
>> +
>> +	INIT_WORK(&data->ts_event_work, qt602240_irq_worker);
>> +	INIT_WORK(&data->ts_disable_work, qt602240_disable_worker);
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
>> +	ret = request_irq(client->irq, qt602240_interrupt, IRQF_TRIGGER_FALLING,
>> +			client->dev.driver->name, data);
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
>> +		goto err_free_irq;
> 
> After input_register_device() succeeded you need to call
> input_unregister_device().
> 

Ah, i missed.

>> +
>> +	return 0;
>> +
>> +err_free_irq:
>> +	free_irq(client->irq, data);
>> +err_free_object:
>> +	kfree(data->object_table);
>> +	kfree(data->info);
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
>> +	cancel_work_sync(&data->ts_event_work);
>> +	cancel_work_sync(&data->ts_disable_work);
>> +	input_unregister_device(data->input_dev);
>> +	kfree(data->object_table);
>> +	kfree(data->info);
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
>> +
>> +	/* Touch disable */
>> +	qt602240_write_object(data, QT602240_TOUCH_MULTI, QT602240_TOUCH_CTRL,
>> +			0);
>> +
>> +	qt602240_write_object(data, QT602240_GEN_POWER,
>> +			QT602240_POWER_IDLEACQINT, 0);
>> +	qt602240_write_object(data, QT602240_GEN_POWER,
>> +			QT602240_POWER_ACTVACQINT, 0);
>> +
>> +	return 0;
>> +}
>> +
>> +static int qt602240_resume(struct i2c_client *client)
>> +{
>> +	struct qt602240_data *data = i2c_get_clientdata(client);
>> +
>> +	schedule_work(&data->ts_disable_work);
> 
> Hmm, what happens if you go through suspend and resume process very
> quickly? Won't your suspend fight with pending resume work? Also, name
> of the work is pretty confusing.. Why is it ts_disable_work?
> 

When resume the chip needs soft reset and after reset needs long time
delay(65msec), so i used workqueue to reduce resume time. I'm not sure
it is no problem to use workqueue in PM function.
The ts_disable_work is wrong name derived from codes for other purpose
removed now. It should be changed.

> Also, what about open() and close() methods for the input device?
> 

OK, i will consider this methods.

> Andplease CC Henrik Rydberg <rydberg@euromail.se> so he can take a look
> at the detail of MT protocol.
> 
> Thanks!
> 

Thanks.
