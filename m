From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH] Input: add ST1232 touchscreen controller driver.
Date: Mon, 13 Dec 2010 12:43:22 +0530
Message-ID: <4D05C792.2040207@codeaurora.org>
References: <A389F2A753A34FA184BF22E0277C0F7B@rso.adwin.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Shift_JIS
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:11130 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab0LMHN3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 02:13:29 -0500
In-Reply-To: <A389F2A753A34FA184BF22E0277C0F7B@rso.adwin.renesas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chinyeow.sim.xt@renesas.com
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Henrik Rydberg' <rydberg@euromail.se>, linux-input@vger.kernel.org

Hi Sim,

On 12/13/2010 10:39 AM, chinyeow.sim.xt@renesas.com wrote:

> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
> new file mode 100644
> index 0000000..bfa24ee
> --- /dev/null
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -0,0 +1,377 @@
> +/* drivers/input/touchscreen/st1232.c
> + *
> + * Copyright (C) 2010 Renesas Solutions Corp.
> + *	Tony SIM <chinyeow.sim.xt@renesas.com>
> + *
> + * Using code from:
> + *  - android.git.kernel.org: projects/kernel/common.git: synaptics_i2c_rmi.c
> + *	Copyright (C) 2007 Google, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/earlysuspend.h>

Dmitry commented on the driver but I am going to review this driver and you might see duplicated comments.

Please remove "early suspend/late resume" infrastructure and you might want to do "runtime PM" if you 
really want to shut-off the resources on the run-time based on some in-activity or initiation of sleep.

> +#include <linux/hrtimer.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define ST1232_TS_NAME	"st1232-ts"
> +
> +#define XY0	0
> +#define XY1	1
> +#define MAX_FINGERS	2
> +
> +#define MIN_X	0
> +#define MIN_Y	0
> +#define MAX_X	800
> +#define MAX_Y	480

Is this going to be constant? So TS controller doesn't support resolutions bigger than this?

> +#define MAX_AREA	0x7ff
> +
> +struct st1232_ts_data {
> +	uint16_t addr;

do you need this ?

> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	int use_irq;
> +	struct hrtimer timer;
> +	struct work_struct work;
> +	struct workqueue_struct *workq;
> +	uint8_t pre_fingers_num;
> +	uint8_t pre_is_valid[MAX_FINGERS];
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +	struct early_suspend early_suspend;
> +#endif
> +};
> +
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +static void st1232_ts_early_suspend(struct early_suspend *h);
> +static void st1232_ts_late_resume(struct early_suspend *h);
> +#endif
> +
> +static void st1232_ts_work_func(struct work_struct *work)
> +{
> +	int ret;
> +	struct i2c_msg msg[2];
> +	uint8_t start_reg;
> +	uint8_t buf[8];
> +	struct st1232_ts_data *ts =
> +		container_of(work, struct st1232_ts_data, work);
> +	uint16_t x[MAX_FINGERS], y[MAX_FINGERS];
> +	uint8_t fingers_num, is_valid[MAX_FINGERS];
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
> +	}
> +
> +	if (is_valid[XY1]) {
> +		x[XY1] = ((buf[5] & 0x0070) << 4) | buf[6];
> +		y[XY1] = ((buf[5] & 0x0007) << 8) | buf[7];
> +	}
> +
> +	/* report single touch */
> +	if (ts->pre_is_valid[XY0] || is_valid[XY0]) {
> +		input_report_key(ts->input_dev, BTN_TOUCH, is_valid[XY0]);
> +		if (is_valid[XY0]) {
> +			input_report_abs(ts->input_dev, ABS_X, x[XY0]);
> +			input_report_abs(ts->input_dev, ABS_Y, y[XY0]);
> +		}
> +	}
> +
> +	if (ts->pre_is_valid[XY1] || is_valid[XY1]) {
> +		input_report_key(ts->input_dev, BTN_2, is_valid[XY1]);
> +		if (is_valid[XY1]) {
> +			input_report_abs(ts->input_dev, ABS_HAT0X, x[XY1]);
> +			input_report_abs(ts->input_dev, ABS_HAT0Y, y[XY1]);
> +		}
> +	}
> +
> +	/* multi touch protocol */
> +	fingers_num = is_valid[XY0] + is_valid[XY1];
> +
> +	if (fingers_num > 0) {
> +		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, MAX_AREA);
> +		input_report_abs(ts->input_dev, ABS_MT_POSITION_X,
> +				is_valid[XY0] ? x[XY0] : x[XY1]);
> +		input_report_abs(ts->input_dev, ABS_MT_POSITION_Y,
> +				is_valid[XY0] ? y[XY0] : y[XY1]);
> +		input_mt_sync(ts->input_dev);
> +
> +		if (fingers_num == MAX_FINGERS) {
> +			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> +					MAX_AREA);
> +			input_report_abs(ts->input_dev, ABS_MT_POSITION_X,
> +					x[XY1]);
> +			input_report_abs(ts->input_dev, ABS_MT_POSITION_Y,
> +					y[XY1]);
> +			input_mt_sync(ts->input_dev);
> +		}
> +	} else if ((ts->pre_fingers_num == 1) && (fingers_num == 0)) {
> +		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0);
> +		input_mt_sync(ts->input_dev);
> +	}

Use MT protocol as mentioned by Dmitry.

> +
> +	/* EV_SYN */
> +	input_sync(ts->input_dev);
> +
> +	ts->pre_fingers_num = fingers_num;
> +	ts->pre_is_valid[XY0] = is_valid[XY0];
> +	ts->pre_is_valid[XY1] = is_valid[XY1];
> +
> +done:
> +	if (ts->use_irq)
> +		enable_irq(ts->client->irq);
> +
> +	return;
> +}
> +
> +static enum hrtimer_restart st1232_ts_timer_func(struct hrtimer *timer)
> +{
> +	struct st1232_ts_data *ts =
> +		container_of(timer, struct st1232_ts_data, timer);
> +
> +	pr_debug("st1232_ts_timer_func\n");
> +	queue_work(ts->workq, &ts->work);
> +	hrtimer_start(&ts->timer, ktime_set(0, 12500000), HRTIMER_MODE_REL);
> +	return HRTIMER_NORESTART;
> +}
> +
> +static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
> +{
> +	struct st1232_ts_data *ts = dev_id;
> +
> +	pr_debug("st1232_ts_irq_handler\n");

Let's not put such debugs.

> +	disable_irq_nosync(ts->client->irq);
> +	queue_work(ts->workq, &ts->work);
> +	return IRQ_HANDLED;
> +}
> +
> +static int st1232_ts_probe(
> +	struct i2c_client *client, const struct i2c_device_id *id)
> +{

__devinit

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
> +		goto err_alloc_data_failed;
> +	}
> +	INIT_WORK(&ts->work, st1232_ts_work_func);
> +	ts->client = client;
> +	i2c_set_clientdata(client, ts);
> +
> +	ts->input_dev = input_allocate_device();
> +	if (!ts->input_dev) {
> +		ret = -ENOMEM;
> +		dev_err(&client->dev, "Failed to allocate input device\n");

Yen symbols needs to go away. 

> +		goto err_input_dev_alloc_failed;
> +	}
> +	ts->input_dev->name = "st1232-touchscreen";
> +
> +	ts->workq = create_singlethread_workqueue("st1232_workq");
> +	if (!ts->workq)
> +		return -ENOMEM;
> +
> +	set_bit(EV_SYN, ts->input_dev->evbit);
> +	set_bit(EV_KEY, ts->input_dev->evbit);
> +	set_bit(BTN_TOUCH, ts->input_dev->keybit);
> +	set_bit(BTN_2, ts->input_dev->keybit);
> +	set_bit(EV_ABS, ts->input_dev->evbit);

please use __set_bit

> +
> +	input_set_capability(ts->input_dev, EV_KEY, BTN_TOUCH);
> +	input_set_capability(ts->input_dev, EV_KEY, BTN_2);
> +
> +	input_set_abs_params(ts->input_dev, ABS_X, MIN_X, MAX_X, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_Y, MIN_Y, MAX_Y, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_HAT0X, MIN_X, MAX_X, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_HAT0Y, MIN_Y, MAX_Y, 0, 0);

This will go away once you convert to MT protocol.

> +
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
> +				MIN_X, MAX_X, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
> +				MIN_Y, MAX_Y, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> +				0, MAX_AREA, 0, 0);
> +
> +	ret = input_register_device(ts->input_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "Unable to register %s input device\n",
> +			ts->input_dev->name);
> +		goto err_input_register_device_failed;
> +	}
> +	if (client->irq) {
> +		ret = request_irq(client->irq, st1232_ts_irq_handler, 0,
> +					client->name, ts);

request_threaded_irq infrastructure usage please.

> +		if (ret)
> +			dev_err(&client->dev, "request_irq failed\n");
> +		else
> +			ts->use_irq = 1;
> +	}
> +
> +	if (!ts->use_irq) {
> +		hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +		ts->timer.function = st1232_ts_timer_func;
> +		hrtimer_start(&ts->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
> +	}

timer/polling infrastructure needs to go away.

> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +	ts->early_suspend.level = EARLY_SUSPEND_LEVEL_BLANK_SCREEN + 1;
> +	ts->early_suspend.suspend = st1232_ts_early_suspend;
> +	ts->early_suspend.resume = st1232_ts_late_resume;
> +	register_early_suspend(&ts->early_suspend);
> +#endif

ditto.

> +
> +	dev_info(&client->dev, "Start touchscreen %s in %s mode\n",
> +		ts->input_dev->name, ts->use_irq ? "interrupt" : "polling");
> +
> +	return 0;
> +
> +err_input_register_device_failed:
> +	input_free_device(ts->input_dev);
> +err_input_dev_alloc_failed:
> +	kfree(ts);
> +err_alloc_data_failed:
> +	return ret;
> +}
> +
> +static int st1232_ts_remove(struct i2c_client *client)
> +{

__devexit

> +	struct st1232_ts_data *ts = i2c_get_clientdata(client);
> +
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +	unregister_early_suspend(&ts->early_suspend);
> +#endif
> +
> +	if (ts->use_irq)
> +		free_irq(client->irq, ts);
> +	else
> +		hrtimer_cancel(&ts->timer);
> +
> +	if (ts->workq)
> +		destroy_workqueue(ts->workq);
> +
> +	input_unregister_device(ts->input_dev);
> +
> +	kfree(ts);
> +	return 0;
> +}
> +


> +
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +static void st1232_ts_early_suspend(struct early_suspend *h)
> +{
> +	struct st1232_ts_data *ts;
> +	ts = container_of(h, struct st1232_ts_data, early_suspend);
> +	st1232_ts_suspend(ts->client, PMSG_SUSPEND);
> +}
> +
> +static void st1232_ts_late_resume(struct early_suspend *h)
> +{
> +	struct st1232_ts_data *ts;
> +	ts = container_of(h, struct st1232_ts_data, early_suspend);
> +	st1232_ts_resume(ts->client);
> +}
> +#endif

This needs to be removed.

> +
> +static const struct i2c_device_id st1232_ts_id[] = {
> +	{ ST1232_TS_NAME, 0 },
> +	{ }
> +};

MODULE_DEVICE_TABLE

> +
> +static struct i2c_driver st1232_ts_driver = {
> +	.probe		= st1232_ts_probe,
> +	.remove		= st1232_ts_remove,

__devexit_p

> +#ifndef CONFIG_HAS_EARLYSUSPEND
> +	.suspend	= st1232_ts_suspend,
> +	.resume		= st1232_ts_resume,
> +#endif

Please remove and convert to dev_pm_ops.

> +	.id_table	= st1232_ts_id,
> +	.driver = {
> +		.name	= ST1232_TS_NAME,

.owner?

> +	},
> +};
> +
> +static int __devinit st1232_ts_init(void)
> +{

This needs to be __init.

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

module_init/exit goes with their respective functions.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
