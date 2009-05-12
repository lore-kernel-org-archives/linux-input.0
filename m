From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add touchscreen driver for MELFAS MCS-5000
	controller
Date: Mon, 11 May 2009 19:09:25 -0700
Message-ID: <20090512020921.GA1965@dtor-d630.eng.vmware.com>
References: <4A0819EE.2050209@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:8394 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756082AbZELCJi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 May 2009 22:09:38 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2369696rvb.1
        for <linux-input@vger.kernel.org>; Mon, 11 May 2009 19:09:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A0819EE.2050209@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com

Hi,

On Mon, May 11, 2009 at 09:28:30PM +0900, Joonyoung Shim wrote:
> The MELPAS MCS-5000 is the touchscreen controller. The overview of this
> controller can see at the following website:
> 
> http://www.melfas.com/product/product01.asp?k_r=eng_
> 
> This patch supports only the i2c interface.
> 

Thank you for the patch. Some comments below.

> +
> +/* Touchscreen absolute values */
> +static int abs_x[3] = {0, 1024, 0};
> +module_param_array(abs_x, int, NULL, 0);
> +MODULE_PARM_DESC(abs_x, "Touchscreen absolute X min, max, fuzz");
> +
> +static int abs_y[3] = {0, 1024, 0};
> +module_param_array(abs_y, int, NULL, 0);
> +MODULE_PARM_DESC(abs_y, "Touchscreen absolute Y min, max, fuzz");
> +

Do we need to have these as module parameters give the fact that we can
set them dynamically with EVIOCSABS? I'd =say they should go.

> +static int abs_p[3] = {0, 256, 0};
> +module_param_array(abs_p, int, NULL, 0);
> +MODULE_PARM_DESC(abs_p, "Touchscreen absolute Pressure min, max, fuzz");
> +
> +/* Each client has this additional data */
> +struct mcs5000_ts_data {
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	struct work_struct ts_event_work;
> +	struct mcs5000_ts_platform_data *platform_data;
> +
> +	unsigned int irq;
> +};
> +
> +static struct i2c_driver mcs5000_ts_driver;
> +
> +static void mcs5000_ts_input_read(struct mcs5000_ts_data *data)
> +{
> +	struct i2c_client *client = data->client;
> +	u8 buffer[READ_BLOCK_SIZE];
> +	int err;
> +	int x;
> +	int y;
> +
> +	err = i2c_smbus_read_i2c_block_data(client, MCS5000_TS_INPUT_INFO,
> +			READ_BLOCK_SIZE, buffer);
> +	if (err < 0) {
> +		dev_err(&client->dev, "%s, err[%d]\n", __func__, err);
> +		return;
> +	}
> +
> +	switch (buffer[READ_INPUT_INFO]) {
> +	case INPUT_TYPE_NONTOUCH:
> +		input_report_abs(data->input_dev, ABS_PRESSURE, 0);
> +		input_report_key(data->input_dev, BTN_TOUCH, 0);
> +		input_sync(data->input_dev);
> +		break;
> +	case INPUT_TYPE_SINGLE:
> +		x = (buffer[READ_X_POS_UPPER] << 8) | buffer[READ_X_POS_LOWER];
> +		y = (buffer[READ_Y_POS_UPPER] << 8) | buffer[READ_Y_POS_LOWER];
> +
> +		input_report_key(data->input_dev, BTN_TOUCH, 1);
> +		input_report_abs(data->input_dev, ABS_X, x);
> +		input_report_abs(data->input_dev, ABS_Y, y);
> +		input_report_abs(data->input_dev, ABS_PRESSURE,
> +				DEFAULT_PRESSURE);

If the hardware does not support pressure reading don't fake it.
BTN_TOUCH should be enough to signal touch.

> +		input_sync(data->input_dev);
> +		break;
> +	case INPUT_TYPE_DUAL:
> +		/* TODO */
> +		break;
> +	case INPUT_TYPE_PALM:
> +		/* TODO */
> +		break;
> +	case INPUT_TYPE_PROXIMITY:
> +		/* TODO */
> +		break;
> +	default:
> +		dev_err(&client->dev, "Unknown ts input type %d\n",
> +				buffer[READ_INPUT_INFO]);
> +		break;
> +	}
> +}
> +
> +static void mcs5000_ts_irq_worker(struct work_struct *work)
> +{
> +	struct mcs5000_ts_data *data = container_of(work,
> +			struct mcs5000_ts_data, ts_event_work);
> +
> +	mcs5000_ts_input_read(data);
> +
> +	enable_irq(data->irq);
> +}
> +
> +static irqreturn_t mcs5000_ts_interrupt(int irq, void *dev_id)
> +{
> +	struct mcs5000_ts_data *data = dev_id;
> +
> +	if (!work_pending(&data->ts_event_work)) {
> +		disable_irq_nosync(data->irq);
> +		schedule_work(&data->ts_event_work);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mcs5000_ts_input_init(struct mcs5000_ts_data *data)
> +{
> +	struct input_dev *input_dev;
> +	int ret = 0;
> +
> +	INIT_WORK(&data->ts_event_work, mcs5000_ts_irq_worker);
> +
> +	data->input_dev = input_allocate_device();
> +	if (data->input_dev == NULL) {
> +		ret = -ENOMEM;
> +		goto err_input;
> +	}
> +
> +	input_dev = data->input_dev;
> +	input_dev->name = "MELPAS MCS-5000 Touchscreen";

input_dev->id.bustype = BUS_I2C;
input_dev->dev.parent = <i2c device>;


> +	set_bit(EV_ABS, input_dev->evbit);
> +	set_bit(ABS_X, input_dev->absbit);
> +	set_bit(ABS_Y, input_dev->absbit);
> +	set_bit(ABS_PRESSURE, input_dev->absbit);
> +	input_set_abs_params(input_dev, ABS_X, abs_x[0], abs_x[1], abs_x[2], 0);
> +	input_set_abs_params(input_dev, ABS_Y, abs_y[0], abs_y[1], abs_y[2], 0);
> +	input_set_abs_params(input_dev, ABS_PRESSURE, abs_p[0], abs_p[1],
> +			abs_p[2], 0);

This line should go.

> +	set_bit(EV_KEY, input_dev->evbit);
> +	set_bit(BTN_TOUCH, input_dev->keybit);
> +
> +	ret = input_register_device(data->input_dev);
> +	if (ret < 0)
> +		goto err_register;
> +
> +	if (request_irq(data->irq, mcs5000_ts_interrupt,
> +			IRQF_TRIGGER_LOW, "mcs5000_ts_input", data)) {
> +		dev_err(&data->client->dev, "Failed to register interrupt\n");
> +		ret = -EINVAL;

Why EINVAL and not EBUSY? Or better yet, why don't you propagate what
reqiest_irq returned?

> +		goto err_irq;
> +	}
> +
> +	input_set_drvdata(input_dev, data);
> +
> +	return 0;
> +err_irq:
> +	input_unregister_device(data->input_dev);
> +err_register:
> +	input_free_device(data->input_dev);

Do not call input_free_device() after input_unregister_device(), it will
cause double-free. EIther rearrange initialization order or do
data->input_dev = NULL; right after calling input_unregister_device().

> +err_input:
> +	return ret;
> +}
> +
> +static void mcs5000_ts_phys_init(struct mcs5000_ts_data *data)
> +{
> +	struct i2c_client *client = data->client;
> +	struct mcs5000_ts_platform_data *platform_data = data->platform_data;
> +
> +	/* Touch reset & sleep mode */
> +	i2c_smbus_write_byte_data(client, MCS5000_TS_OP_MODE,
> +			RESET_EXT_SOFT | OP_MODE_SLEEP);
> +
> +	/* Touch size */
> +	i2c_smbus_write_byte_data(client, MCS5000_TS_X_SIZE_UPPER,
> +			platform_data->x_size >> 8);
> +	i2c_smbus_write_byte_data(client, MCS5000_TS_X_SIZE_LOWER,
> +			platform_data->x_size & 0xff);
> +	i2c_smbus_write_byte_data(client, MCS5000_TS_Y_SIZE_UPPER,
> +			platform_data->y_size >> 8);
> +	i2c_smbus_write_byte_data(client, MCS5000_TS_Y_SIZE_LOWER,
> +			platform_data->y_size & 0xff);
> +
> +	/* Touch active mode & 80 report rate */
> +	i2c_smbus_write_byte_data(data->client, MCS5000_TS_OP_MODE,
> +			OP_MODE_ACTIVE | REPORT_RATE_80);
> +}
> +
> +static int mcs5000_ts_probe(struct i2c_client *client,
> +		const struct i2c_device_id *idp)

This should be marked __devinit.

> +{
> +	struct mcs5000_ts_data *data;
> +	int ret;
> +
> +	data = kzalloc(sizeof(struct mcs5000_ts_data), GFP_KERNEL);
> +	if (!data)
> +		dev_err(&client->dev, "Failed to allocate driver data\n");
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	data->client = client;
> +	data->irq = client->irq;
> +	data->platform_data = client->dev.platform_data;
> +
> +	i2c_set_clientdata(client, data);
> +
> +	if (data->platform_data->set_pin)
> +		data->platform_data->set_pin();
> +
> +	ret = mcs5000_ts_input_init(data);
> +	if (ret)
> +		goto exit_free;
> +
> +	mcs5000_ts_phys_init(data);
> +
> +	return 0;
> +
> +exit_free:
> +	kfree(data);
> +	i2c_set_clientdata(client, NULL);
> +exit:
> +	return ret;
> +}
> +
> +static int mcs5000_ts_remove(struct i2c_client *client)

This should be marked __devexit.

> +{
> +	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
> +
> +	cancel_work_sync(&data->ts_event_work);

There is a race here, IRQ handler may resubmit work after
cancel_work_sync() returns. You need to  make sure that
IRQ handler does not resubmit work while device is being shut down.

> +	free_irq(data->irq, data);
> +	input_unregister_device(data->input_dev);
> +	input_free_device(data->input_dev);

Just input_unregister_device() is enough.

> +	kfree(data);
> +
> +	i2c_set_clientdata(client, NULL);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int mcs5000_ts_suspend(struct i2c_client *client, pm_message_t mesg)
> +{
> +	/* Touch sleep mode */
> +	i2c_smbus_write_byte_data(client, MCS5000_TS_OP_MODE, OP_MODE_SLEEP);
> +
> +	return 0;
> +}
> +
> +static int mcs5000_ts_resume(struct i2c_client *client)
> +{
> +	struct mcs5000_ts_data *data;
> +
> +	data = i2c_get_clientdata(client);
> +	mcs5000_ts_phys_init(data);
> +
> +	return 0;
> +}
> +#else
> +#define mcs5000_ts_suspend	NULL
> +#define mcs5000_ts_resume	NULL
> +#endif
> +
> +static const struct i2c_device_id mcs5000_ts_id[] = {
> +	{ "mcs5000_ts", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mcs5000_ts_id);
> +
> +static struct i2c_driver mcs5000_ts_driver = {
> +	.driver = {
> +		.name = "mcs5000_ts",
> +	},
> +	.probe		= mcs5000_ts_probe,
> +	.remove		= mcs5000_ts_remove,

__devexit_p()

#ifdef CONFIG_PM
> +	.suspend	= mcs5000_ts_suspend,
> +	.resume		= mcs5000_ts_resume,
#endif

> +	.id_table	= mcs5000_ts_id,
> +};
> +

Thanks.

-- 
Dmitry
