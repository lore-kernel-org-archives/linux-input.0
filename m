From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH v2] Input: add ST1232 touchscreen controller driver.
Date: Tue, 14 Dec 2010 12:22:00 +0530
Message-ID: <4D071410.1050804@codeaurora.org>
References: <1292301289-12931-1-git-send-email-chinyeow.sim.xt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:10557 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab0LNGwC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Dec 2010 01:52:02 -0500
In-Reply-To: <1292301289-12931-1-git-send-email-chinyeow.sim.xt@renesas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chinyeow.sim.xt@renesas.com
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, linux-input@vger.kernel.org


Hi Tony,

On 12/14/2010 10:04 AM, chinyeow.sim.xt@renesas.com wrote:
> From: Tony SIM <chinyeow.sim.xt@renesas.com>
> 

code looks good now. few comments below. Let's wait for Dmitry and if possible
Henrik to review MT code.

> +
> +static void st1232_ts_work_func(struct work_struct *work)
> +{
> +	int i, ret;
> +	struct i2c_msg msg[2];
> +	uint8_t start_reg;
> +	uint8_t buf[10];
> +	struct st1232_ts_data *ts =
> +		container_of(work, struct st1232_ts_data, work.work);
> +	uint16_t x[MAX_FINGERS], y[MAX_FINGERS];
> +	uint8_t t[MAX_FINGERS];
> +	uint8_t is_valid[MAX_FINGERS];
> +
> +	/* read touchscreen data from ST1232 */
> +	msg[0].addr = ts->client->addr;
> +	msg[0].flags = 0;
> +	msg[0].len = 1;
> +	msg[0].buf = &start_reg;
> +	start_reg = 0x10;
> +
> +	msg[1].addr = ts->client->addr;
> +	msg[1].flags = I2C_M_RD;
> +	msg[1].len = sizeof(buf);
> +	msg[1].buf = buf;
> +
> +	ret = i2c_transfer(ts->client->adapter, msg, 2);
> +	if (ret < 0)
> +		goto done;
> +
> +	/* get valid bit */
> +	is_valid[XY0] = buf[2] >> 7;
> +	is_valid[XY1] = buf[5] >> 7;
> +
> +	/* get xy coordinate */
> +	if (is_valid[XY0]) {
> +		x[XY0] = ((buf[2] & 0x0070) << 4) | buf[3];
> +		y[XY0] = ((buf[2] & 0x0007) << 8) | buf[4];
> +		t[XY0] = buf[8];
> +	}
> +
> +	if (is_valid[XY1]) {
> +		x[XY1] = ((buf[5] & 0x0070) << 4) | buf[6];
> +		y[XY1] = ((buf[5] & 0x0007) << 8) | buf[7];
> +		t[XY1] = buf[9];
> +	}
> +
> +	/* multi touch protocol */
> +	for (i = 0; i < MAX_FINGERS; i++) {
> +		if (!is_valid[i]) {
> +			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0);
> +			continue;
> +		}
> +
> +		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, t[i]);
> +		input_report_abs(ts->input_dev, ABS_MT_POSITION_X, x[i]);
> +		input_report_abs(ts->input_dev, ABS_MT_POSITION_Y, y[i]);
> +		input_mt_sync(ts->input_dev);
> +		}


Indentation problem.

> +
> +	/* EV_SYN */
> +	input_sync(ts->input_dev);
> +
> +done:
> +	enable_irq(ts->client->irq);
> +
> +	return;
> +}
> +
> +static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
> +{
> +	struct st1232_ts_data *ts = dev_id;
> +
> +	disable_irq_nosync(irq);
> +	schedule_delayed_work(&ts->work, msecs_to_jiffies(2));

We don't need workqueue and disable_irq_nosync if you use the request_threaded_irq
with IRQF_ONESHOT flag.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __devinit st1232_ts_probe(struct i2c_client *client,
> +					const struct i2c_device_id *id)
> +{
> +	struct st1232_ts_data *ts;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(&client->dev, "need I2C_FUNC_I2C\n");
> +		return -EIO;
> +	}
> +
> +	ts = kzalloc(sizeof(struct st1232_ts_data), GFP_KERNEL);
> +	if (!ts) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	INIT_DELAYED_WORK(&ts->work, st1232_ts_work_func);
> +	ts->client = client;
> +	i2c_set_clientdata(client, ts);
> +
> +	ts->input_dev = input_allocate_device();
> +	if (!ts->input_dev) {
> +		ret = -ENOMEM;
> +		dev_err(&client->dev, "Failed to allocate input device\n");
> +		goto err_free_mem;
> +	}
> +	ts->input_dev->name = "st1232-touchscreen";
> +
> +	__set_bit(EV_SYN, ts->input_dev->evbit);
> +	__set_bit(EV_KEY, ts->input_dev->evbit);
> +	__set_bit(EV_ABS, ts->input_dev->evbit);
> +
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> +				0, MAX_AREA, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
> +				MIN_X, MAX_X, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
> +				MIN_Y, MAX_Y, 0, 0);
> +
> +	ret = input_register_device(ts->input_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "Unable to register %s input device\n",
> +			ts->input_dev->name);
> +		goto err_free_input_device;
> +	}
> +
> +	ret = request_threaded_irq(client->irq, st1232_ts_irq_handler, NULL,
> +			IRQF_TRIGGER_NONE, client->name, ts);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to register interrupt\n");
> +		goto err_free_input_device;
> +	}

You may want to add device_init_wakeup.

> +
> +	return 0;
> +
> +err_free_input_device:
> +	input_free_device(ts->input_dev);
> +err_free_mem:
> +	kfree(ts);
> +err:
> +	return ret;
> +}
> +
> +static int __devexit st1232_ts_remove(struct i2c_client *client)
> +{
> +	struct st1232_ts_data *ts = i2c_get_clientdata(client);
> +
> +	free_irq(client->irq, ts);
> +	input_unregister_device(ts->input_dev);
> +	kfree(ts);
> +
> +	return 0;
> +}
> +

> +
> +static int __init st1232_ts_init(void)
> +{
> +	return i2c_add_driver(&st1232_ts_driver);
> +}
> +
> +static void __exit st1232_ts_exit(void)
> +{
> +	i2c_del_driver(&st1232_ts_driver);
> +}
> +
> +module_init(st1232_ts_init);
> +module_exit(st1232_ts_exit);

nitpick:

If you are going to create new version then please move module_init/exit with
their respective functions. Thanks.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
