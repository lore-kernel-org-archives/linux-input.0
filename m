From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add ST1232 touchscreen controller driver.
Date: Sun, 12 Dec 2010 21:32:52 -0800
Message-ID: <20101213053252.GD21401@core.coreip.homeip.net>
References: <A389F2A753A34FA184BF22E0277C0F7B@rso.adwin.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33693 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab0LMFdA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 00:33:00 -0500
Received: by pwj3 with SMTP id 3so1071079pwj.19
        for <linux-input@vger.kernel.org>; Sun, 12 Dec 2010 21:32:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <A389F2A753A34FA184BF22E0277C0F7B@rso.adwin.renesas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chinyeow.sim.xt@renesas.com
Cc: 'Henrik Rydberg' <rydberg@euromail.se>, linux-input@vger.kernel.org

Hi Tony,

On Mon, Dec 13, 2010 at 02:09:28PM +0900, chinyeow.sim.xt@renesas.com w=
rote:
> This patch set introduces for Sitronix ST1232 touchscreen controller
> driver. This is an integrated capacitive touchscreen with LCD module
> which can detect two fingers's touch X/Y coordinate.
>=20
> Signed-off-by: Tony SIM <chinyeow.sim.xt@renesas.com>
> ---
>  drivers/input/touchscreen/Kconfig  |   11 +
>  drivers/input/touchscreen/Makefile |    1 +
>  drivers/input/touchscreen/st1232.c |  377 ++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 389 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/st1232.c
>=20
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchs=
creen/Kconfig
> index 06ea8da..3ca7700 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -681,4 +681,15 @@ config TOUCHSCREEN_STMPE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stmpe-ts.
> =20
> +config TOUCHSCREEN_ST1232
> +	tristate "Sitronix ST1232 touchscreen controllers"
> +	depends on I2C
> +	help
> +	  Say Y here if you want to support Sitronix ST1232
> +	  touchscreen controller.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called st1232_ts.
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touch=
screen/Makefile
> index 7cc1b4f..718bcc8 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_TOUCHSCREEN_PCAP)		+=3D pcap_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+=3D penmount.o
>  obj-$(CONFIG_TOUCHSCREEN_QT602240)	+=3D qt602240_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+=3D s3c2410_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_ST1232)	+=3D st1232.o
>  obj-$(CONFIG_TOUCHSCREEN_STMPE)		+=3D stmpe-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_TNETV107X)	+=3D tnetv107x-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+=3D touchit213.o
> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touch=
screen/st1232.c
> new file mode 100644
> index 0000000..bfa24ee
> --- /dev/null
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -0,0 +1,377 @@
> +/* drivers/input/touchscreen/st1232.c

No filenames in sources please - easier to move/rename if needed.

> + *
> + * Copyright (C) 2010 Renesas Solutions Corp.
> + *	Tony SIM <chinyeow.sim.xt@renesas.com>
> + *
> + * Using code from:
> + *  - android.git.kernel.org: projects/kernel/common.git: synaptics_=
i2c_rmi.c
> + *	Copyright (C) 2007 Google, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
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
> +#define MAX_AREA	0x7ff
> +
> +struct st1232_ts_data {
> +	uint16_t addr;
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	int use_irq;

I really do not think we need to support the devices in polling mode:
the drain on the battery would be too much to use it in production.

> +	struct hrtimer timer;

I guess without polling timer is not needed either.

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

There is no EARLYSUSPEND infrastructuire in mainline, please drop.

> +
> +static void st1232_ts_work_func(struct work_struct *work)
> +{
> +	int ret;
> +	struct i2c_msg msg[2];
> +	uint8_t start_reg;
> +	uint8_t buf[8];
> +	struct st1232_ts_data *ts =3D
> +		container_of(work, struct st1232_ts_data, work);
> +	uint16_t x[MAX_FINGERS], y[MAX_FINGERS];
> +	uint8_t fingers_num, is_valid[MAX_FINGERS];
> +
> +	/* read touchscreen data from ST1232 */
> +	msg[0].addr =3D ts->client->addr;
> +	msg[0].flags =3D 0;
> +	msg[0].len =3D 1;
> +	msg[0].buf =3D &start_reg;
> +	start_reg =3D 0x10;
> +
> +	msg[1].addr =3D ts->client->addr;
> +	msg[1].flags =3D I2C_M_RD;
> +	msg[1].len =3D sizeof(buf);
> +	msg[1].buf =3D buf;
> +
> +	ret =3D i2c_transfer(ts->client->adapter, msg, 2);
> +	if (ret < 0)
> +		goto done;
> +
> +	/* get valid bit */
> +	is_valid[XY0] =3D buf[2] >> 7;
> +	is_valid[XY1] =3D buf[5] >> 7;
> +
> +	/* get xy coordinate */
> +	if (is_valid[XY0]) {
> +		x[XY0] =3D ((buf[2] & 0x0070) << 4) | buf[3];
> +		y[XY0] =3D ((buf[2] & 0x0007) << 8) | buf[4];
> +	}
> +
> +	if (is_valid[XY1]) {
> +		x[XY1] =3D ((buf[5] & 0x0070) << 4) | buf[6];
> +		y[XY1] =3D ((buf[5] & 0x0007) << 8) | buf[7];
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
> +	fingers_num =3D is_valid[XY0] + is_valid[XY1];
> +
> +	if (fingers_num > 0) {

MT protocol should be used by MT-capable devices regardless of number o=
f
fingers currently present on the surface.

Also consider using his new MT library to easy deriving ST events from
MT events (look in drivers/input/input-mt.c in my tree on kernel.org).

> +		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, MAX_AREA);

If the device does not report touch size you should not invent the data=
,
simply drop ABS_MT_TOUCH_MAJOR events.

> +		input_report_abs(ts->input_dev, ABS_MT_POSITION_X,
> +				is_valid[XY0] ? x[XY0] : x[XY1]);
> +		input_report_abs(ts->input_dev, ABS_MT_POSITION_Y,
> +				is_valid[XY0] ? y[XY0] : y[XY1]);
> +		input_mt_sync(ts->input_dev);
> +
> +		if (fingers_num =3D=3D MAX_FINGERS) {
> +			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> +					MAX_AREA);
> +			input_report_abs(ts->input_dev, ABS_MT_POSITION_X,
> +					x[XY1]);
> +			input_report_abs(ts->input_dev, ABS_MT_POSITION_Y,
> +					y[XY1]);
> +			input_mt_sync(ts->input_dev);
> +		}
> +	} else if ((ts->pre_fingers_num =3D=3D 1) && (fingers_num =3D=3D 0)=
) {
> +		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0);
> +		input_mt_sync(ts->input_dev);
> +	}
> +
> +	/* EV_SYN */
> +	input_sync(ts->input_dev);
> +
> +	ts->pre_fingers_num =3D fingers_num;
> +	ts->pre_is_valid[XY0] =3D is_valid[XY0];
> +	ts->pre_is_valid[XY1] =3D is_valid[XY1];
> +
> +done:
> +	if (ts->use_irq)
> +		enable_irq(ts->client->irq);
> +
> +	return;
> +}
> +
> +static enum hrtimer_restart st1232_ts_timer_func(struct hrtimer *tim=
er)
> +{
> +	struct st1232_ts_data *ts =3D
> +		container_of(timer, struct st1232_ts_data, timer);
> +
> +	pr_debug("st1232_ts_timer_func=A5n");
> +	queue_work(ts->workq, &ts->work);
> +	hrtimer_start(&ts->timer, ktime_set(0, 12500000), HRTIMER_MODE_REL)=
;
> +	return HRTIMER_NORESTART;
> +}
> +
> +static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
> +{
> +	struct st1232_ts_data *ts =3D dev_id;
> +
> +	pr_debug("st1232_ts_irq_handler=A5n");

I see yen symbol here.

> +	disable_irq_nosync(ts->client->irq);
> +	queue_work(ts->workq, &ts->work);

If you get rid of polling mode and switch to threaded IRQ you'll be abl=
e
to get rid of workqueue and the driver will be very simple.

> +	return IRQ_HANDLED;
> +}
> +
> +static int st1232_ts_probe(
> +	struct i2c_client *client, const struct i2c_device_id *id)

__devinit

> +{
> +	struct st1232_ts_data *ts;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(&client->dev, "need I2C_FUNC_I2C=A5n");


Hmm, yen symbol instead of period and back slash again...

> +		return -EIO;
> +	}
> +
> +	ts =3D kzalloc(sizeof(struct st1232_ts_data), GFP_KERNEL);
> +	if (!ts) {
> +		ret =3D -ENOMEM;
> +		goto err_alloc_data_failed;
> +	}
> +	INIT_WORK(&ts->work, st1232_ts_work_func);
> +	ts->client =3D client;
> +	i2c_set_clientdata(client, ts);
> +
> +	ts->input_dev =3D input_allocate_device();
> +	if (!ts->input_dev) {
> +		ret =3D -ENOMEM;
> +		dev_err(&client->dev, "Failed to allocate input device=A5n");
> +		goto err_input_dev_alloc_failed;
> +	}
> +	ts->input_dev->name =3D "st1232-touchscreen";
> +
> +	ts->workq =3D create_singlethread_workqueue("st1232_workq");
> +	if (!ts->workq)
> +		return -ENOMEM;
> +
> +	set_bit(EV_SYN, ts->input_dev->evbit);
> +	set_bit(EV_KEY, ts->input_dev->evbit);
> +	set_bit(BTN_TOUCH, ts->input_dev->keybit);
> +	set_bit(BTN_2, ts->input_dev->keybit);
> +	set_bit(EV_ABS, ts->input_dev->evbit);
> +
> +	input_set_capability(ts->input_dev, EV_KEY, BTN_TOUCH);
> +	input_set_capability(ts->input_dev, EV_KEY, BTN_2);
> +
> +	input_set_abs_params(ts->input_dev, ABS_X, MIN_X, MAX_X, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_Y, MIN_Y, MAX_Y, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_HAT0X, MIN_X, MAX_X, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_HAT0Y, MIN_Y, MAX_Y, 0, 0);

Hmm, It looks this driver tries to use BTN_2, ABS_HAT0X, BAS_HAT0Y for
reporting 2nd touch. This is not suited for mainline kernel, please
drop and use proper MT events.

> +
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
> +				MIN_X, MAX_X, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
> +				MIN_Y, MAX_Y, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> +				0, MAX_AREA, 0, 0);
> +
> +	ret =3D input_register_device(ts->input_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "Unable to register %s input device=A5n",
> +			ts->input_dev->name);
> +		goto err_input_register_device_failed;
> +	}
> +	if (client->irq) {
> +		ret =3D request_irq(client->irq, st1232_ts_irq_handler, 0,
> +					client->name, ts);
> +		if (ret)
> +			dev_err(&client->dev, "request_irq failed=A5n");
> +		else
> +			ts->use_irq =3D 1;
> +	}
> +
> +	if (!ts->use_irq) {
> +		hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +		ts->timer.function =3D st1232_ts_timer_func;
> +		hrtimer_start(&ts->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
> +	}
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +	ts->early_suspend.level =3D EARLY_SUSPEND_LEVEL_BLANK_SCREEN + 1;
> +	ts->early_suspend.suspend =3D st1232_ts_early_suspend;
> +	ts->early_suspend.resume =3D st1232_ts_late_resume;
> +	register_early_suspend(&ts->early_suspend);
> +#endif
> +
> +	dev_info(&client->dev, "Start touchscreen %s in %s mode=A5n",
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

__devexit

> +{
> +	struct st1232_ts_data *ts =3D i2c_get_clientdata(client);
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
> +static int st1232_ts_suspend(struct i2c_client *client, pm_message_t=
 mesg)
> +{
> +	int ret;
> +	struct st1232_ts_data *ts =3D i2c_get_clientdata(client);
> +
> +	if (ts->use_irq)
> +		disable_irq(client->irq);
> +	else
> +		hrtimer_cancel(&ts->timer);
> +
> +	ret =3D cancel_work_sync(&ts->work);
> +	if (ret && ts->use_irq)
> +		enable_irq(client->irq);
> +
> +	return 0;
> +}
> +
> +static int st1232_ts_resume(struct i2c_client *client)
> +{
> +	struct st1232_ts_data *ts =3D i2c_get_clientdata(client);
> +
> +	if (ts->use_irq)
> +		enable_irq(client->irq);
> +	else
> +		hrtimer_start(&ts->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
> +
> +	return 0;
> +}

Please convert these to dev_pm_ops.

> +
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +static void st1232_ts_early_suspend(struct early_suspend *h)
> +{
> +	struct st1232_ts_data *ts;
> +	ts =3D container_of(h, struct st1232_ts_data, early_suspend);
> +	st1232_ts_suspend(ts->client, PMSG_SUSPEND);
> +}
> +
> +static void st1232_ts_late_resume(struct early_suspend *h)
> +{
> +	struct st1232_ts_data *ts;
> +	ts =3D container_of(h, struct st1232_ts_data, early_suspend);
> +	st1232_ts_resume(ts->client);
> +}
> +#endif
> +
> +static const struct i2c_device_id st1232_ts_id[] =3D {
> +	{ ST1232_TS_NAME, 0 },
> +	{ }
> +};

Please add MODULE_DEVICE_TABLE(i2c, st1232_ts_id);

> +
> +static struct i2c_driver st1232_ts_driver =3D {
> +	.probe		=3D st1232_ts_probe,
> +	.remove		=3D st1232_ts_remove,
> +#ifndef CONFIG_HAS_EARLYSUSPEND
> +	.suspend	=3D st1232_ts_suspend,
> +	.resume		=3D st1232_ts_resume,
> +#endif
> +	.id_table	=3D st1232_ts_id,
> +	.driver =3D {
> +		.name	=3D ST1232_TS_NAME,
> +	},
> +};
> +
> +static int __devinit st1232_ts_init(void)
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
> +
> +MODULE_AUTHOR("Tony SIM <chinyeow.sim.xt@renesas.com>");
> +MODULE_DESCRIPTION("SITRONIX ST1232 Touchscreen Controller Driver");
> +MODULE_LICENSE("GPL");
> --=20
> 1.7.2.3
>=20

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
