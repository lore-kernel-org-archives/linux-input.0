From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: add driver for pixcir i2c touchscreens
Date: Mon, 21 Feb 2011 21:40:57 -0800
Message-ID: <20110222054057.GB11681@core.coreip.homeip.net>
References: <1eeef53.91a4.12e4b7257f9.Coremail.jcbian@pixcir.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43627 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab1BVFlD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Feb 2011 00:41:03 -0500
Received: by iyb26 with SMTP id 26so1456130iyb.19
        for <linux-input@vger.kernel.org>; Mon, 21 Feb 2011 21:41:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1eeef53.91a4.12e4b7257f9.Coremail.jcbian@pixcir.com.cn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?5Y2e5bu65pil?= <jcbian@pixcir.com.cn>
Cc: linux-input@vger.kernel.org, =?utf-8?B?5a2f5b6X5YWo?= <dqmeng@pixcir.com.cn>, =?utf-8?B?6ZmI5q2j6b6Z?= <zlchen@pixcir.com.cn>

Hi,

On Tue, Feb 22, 2011 at 11:38:28AM +0800, =E5=8D=9E=E5=BB=BA=E6=98=A5 w=
rote:
> This patch adds a driver for PIXCIR's I2C connected touchscreens.
> Modify the text format as v2.
>=20
> Signed-off-by: Bee <jcbian@pixcir.com.cn>

"Bee" and "Reed" sound like handles, not real names, which we expect in
"Signed-off-by" strings.

Also, in addition to all comments made by Mark:

> ---
>  drivers/input/touchscreen/Kconfig         |    9 +
>  drivers/input/touchscreen/Makefile        |    1 +
>  drivers/input/touchscreen/pixcir_i2c_ts.c |  293 +++++++++++++++++++=
++++++++++
>  3 files changed, 303 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/pixcir_i2c_ts.c
>=20
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchs=
creen/Kconfig
> index 61834ae..f11c1ab 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -693,4 +693,13 @@ config TOUCHSCREEN_TPS6507X
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called tps6507x_ts.
> =20
> +config TOUCHSCREEN_PIXCIR
> +	tristate "PIXCIR touchscreen panel support"
> +	depends on I2C
> +	help
> +	  Say Y here if you have a PIXCIR based touchscreen.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called pixcir_i2c_ts.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touch=
screen/Makefile
> index 718bcc8..4513668 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -57,3 +57,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+=3D mai=
nstone-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+=3D zylonite-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_W90X900)	+=3D w90p910_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+=3D tps6507x-ts.o
> +obj-$(CONFIG_TOUCHSCREEN_PIXCIR)	+=3D pixcir_i2c_ts.o

Please keep Kconfig and Makefile sorted alphabetically (it usually help=
s
with merging as it is likely to avoid conflicts).

> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/inpu=
t/touchscreen/pixcir_i2c_ts.c
> new file mode 100644
> index 0000000..e3fbeb0
> --- /dev/null
> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
> @@ -0,0 +1,293 @@
> +/* drivers/input/touchscreen/pixcir_i2c_ts.c

No need to put file name in the comments, it simply makes it harder to
rename if such need arises.

> + *
> + * Copyright (C) 2010-2011 Pixcir, Inc.
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
> + * You should have received a copy of the GNU General Public
> + * License along with this library; if not, write to the Free Softwa=
re
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1=
307  USA
> + */
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +#include <linux/input.h>
> +#include <linux/i2c.h>
> +#include <linux/gpio.h>
> +
> +#define DRIVER_VERSION	"v1.0"
> +#define DRIVER_AUTHOR	"Bee<jcbian@pixcir.com.cn>,Reed<dqmeng@pixcir.=
com.cn>"
> +#define DRIVER_DESC		"Pixcir I2C Touchscreen Driver"
> +#define DRIVER_LICENSE	"GPL"
> +
> +/* todo:check specs for resolution of touch screen */
> +#define	TOUCHSCREEN_MINX	0
> +#define	TOUCHSCREEN_MAXX	400
> +#define	TOUCHSCREEN_MINY	0
> +#define	TOUCHSCREEN_MAXY	600
> +
> +#define	DEBUG	0
> +
> +static struct workqueue_struct *pixcir_wq;
> +
> +struct pixcir_i2c_ts_data {
> +	struct i2c_client *client;
> +	struct input_dev *input;
> +	struct delayed_work work;
> +	int irq;
> +};
> +
> +static void pixcir_ts_poscheck(struct work_struct *work)
> +{
> +	struct pixcir_i2c_ts_data *tsdata =3D container_of(work,
> +						  struct pixcir_i2c_ts_data,
> +						  work.work);
> +
> +	unsigned char touching, oldtouching;
> +	int posx1, posy1, posx2, posy2;
> +	u_int8_t Rdbuf[10], Wrbuf[1];
> +	int ret;
> +	int z =3D 50;
> +	int w =3D 15;
> +
> +	memset(Wrbuf, 0, sizeof(Wrbuf));
> +	memset(Rdbuf, 0, sizeof(Rdbuf));
> +
> +	Wrbuf[0] =3D 0;
> +	ret =3D i2c_master_send(tsdata->client, Wrbuf, 1);
> +	if (ret !=3D 1) {
> +		dev_err(&tsdata->client->dev, "Unable to write to i2c touchscreen!=
\n");
> +		goto out;
> +	}
> +
> +	ret =3D i2c_master_recv(tsdata->client, Rdbuf, sizeof(Rdbuf));
> +	if (ret !=3D sizeof(Rdbuf)) {
> +		dev_err(&tsdata->client->dev, "Unable to read i2c page!\n");
> +		goto out;
> +	}
> +
> +	touching =3D Rdbuf[0];
> +	oldtouching =3D Rdbuf[1];
> +	posx1 =3D ((Rdbuf[3] << 8) | Rdbuf[2]);
> +	posy1 =3D ((Rdbuf[5] << 8) | Rdbuf[4]);
> +	posx2 =3D ((Rdbuf[7] << 8) | Rdbuf[6]);
> +	posy2 =3D ((Rdbuf[9] << 8) | Rdbuf[8]);
> +
> +	input_report_key(tsdata->input, BTN_TOUCH, (touching !=3D 0 ? 1 : 0=
));

Just say

	input_report_key(tsdata->input, BTN_TOUCH, touching);

input_report_key() normalizes to boolean internally.

> +
> +	if (touching =3D=3D 1) {
> +		input_report_abs(tsdata->input, ABS_X, posx1);
> +		input_report_abs(tsdata->input, ABS_Y, posy1);
> +	}

Just send the data always.

> +
> +	if (!(touching)) {
> +		z =3D 0;
> +		w =3D 0;
> +	}
> +	if (touching =3D=3D 2) {
> +		input_report_abs(tsdata->input, ABS_MT_TOUCH_MAJOR, z);
> +		input_report_abs(tsdata->input, ABS_MT_WIDTH_MAJOR, w);

The device does not seem to report ABS_MT_TOUCH_MAJOR/ABS_MT_WIDTH_MAJO=
R
so do not invent the values, don't send anything.

> +		input_report_abs(tsdata->input, ABS_MT_POSITION_X, posx1);
> +		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, posy1);
> +		input_mt_sync(tsdata->input);
> +
> +		input_report_abs(tsdata->input, ABS_MT_TOUCH_MAJOR, z);
> +		input_report_abs(tsdata->input, ABS_MT_WIDTH_MAJOR, w);
> +		input_report_abs(tsdata->input, ABS_MT_POSITION_X, posx2);
> +		input_report_abs(tsdata->input, ABS_MT_POSITION_Y, posy2);

So the hardware does not do any contact tracking? Henrik, any advise ho=
w
to better handle this device?

> +		input_mt_sync(tsdata->input);
> +	}
> +	input_sync(tsdata->input);
> +
> +out:
> +	enable_irq(tsdata->irq);
> +}
> +
> +static irqreturn_t pixcir_ts_isr(int irq, void *dev_id)
> +{
> +	struct pixcir_i2c_ts_data *tsdata =3D dev_id;
> +	disable_irq_nosync(irq);
> +
> +	queue_work(pixcir_wq, &tsdata->work.work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pixcir_ts_open(struct input_dev *dev)
> +{
> +	return 0;
> +}
> +
> +static void pixcir_ts_close(struct input_dev *dev)
> +{
> +
> +}
> +
> +static int pixcir_i2c_ts_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct pixcir_i2c_ts_data *tsdata;
> +	struct input_dev *input;
> +	int error;
> +
> +	#ifdef DEBUG
> +		printk(KERN_EMERG "pixcir_i2c_ts probe!\n");

pr_debug() or dev_dbg().

> +	#endif
> +
> +	tsdata =3D kzalloc(sizeof(*tsdata), GFP_KERNEL);
> +	if (!tsdata) {
> +		dev_err(&client->dev, "Failed to allocate driver data!\n");
> +		error =3D -ENOMEM;
> +		dev_set_drvdata(&client->dev, NULL);
> +		return error;
> +	}
> +
> +	dev_set_drvdata(&client->dev, tsdata);

I2c_set_clientdata()

> +
> +	input =3D input_allocate_device();
> +	if (!input) {
> +		dev_err(&client->dev, "Failed to allocate input device!\n");
> +		error =3D -ENOMEM;
> +		input_free_device(input);
> +		kfree(tsdata);
> +	}
> +
> +	set_bit(EV_SYN, input->evbit);

Set by input core, no need to bother with it in driver code.

> +	set_bit(EV_KEY, input->evbit);
> +	set_bit(EV_ABS, input->evbit);
> +	set_bit(BTN_TOUCH, input->keybit);


Use __set_bit(), no need to lock the bus.

> +	input_set_abs_params(input, ABS_X,
> +			TOUCHSCREEN_MINX, TOUCHSCREEN_MAXX, 0, 0);
> +	input_set_abs_params(input, ABS_Y,
> +			TOUCHSCREEN_MINY, TOUCHSCREEN_MAXY, 0, 0);
> +	input_set_abs_params(input, ABS_MT_POSITION_X,
> +			TOUCHSCREEN_MINX, TOUCHSCREEN_MAXX, 0, 0);
> +	input_set_abs_params(input, ABS_MT_POSITION_Y,
> +			TOUCHSCREEN_MINY, TOUCHSCREEN_MAXY, 0, 0);
> +	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +	input_set_abs_params(input, ABS_MT_WIDTH_MAJOR, 0, 25, 0, 0);
> +
> +	input->name =3D client->name;
> +	input->id.bustype =3D BUS_I2C;
> +	input->dev.parent =3D &client->dev;
> +
> +	input->open =3D pixcir_ts_open;
> +	input->close =3D pixcir_ts_close;
> +
> +	input_set_drvdata(input, tsdata);
> +
> +	tsdata->client =3D client;
> +	tsdata->input =3D input;
> +
> +	INIT_WORK(&tsdata->work.work, pixcir_ts_poscheck);
> +
> +	tsdata->irq =3D client->irq;
> +
> +	if (input_register_device(input)) {
> +		input_free_device(input);
> +		kfree(tsdata);

Return the error reported by input_register_device()?

> +	}
> +
> +	if (request_irq(tsdata->irq, pixcir_ts_isr,
> +			IRQF_TRIGGER_LOW, client->name, tsdata)) {
> +		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
> +		input_unregister_device(input);
> +		input =3D NULL;
> +	}
> +
> +	device_init_wakeup(&client->dev, 1);
> +
> +	dev_err(&tsdata->client->dev, "insmod successfully!\n");
> +
> +	return 0;
> +}
> +
> +static int pixcir_i2c_ts_remove(struct i2c_client *client)
> +{
> +	struct pixcir_i2c_ts_data *tsdata =3D dev_get_drvdata(&client->dev)=
;

i2c_get_clientdata(). Also empty line between variable definitions and
code.

> +	free_irq(tsdata->irq, tsdata);
> +	input_unregister_device(tsdata->input);
> +	kfree(tsdata);
> +	dev_set_drvdata(&client->dev, NULL);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int pixcir_i2c_ts_suspend(struct i2c_client *client, pm_messa=
ge_t mesg)
> +{
> +	struct pixcir_i2c_ts_data *tsdata =3D dev_get_drvdata(&client->dev)=
;
> +
> +	if (device_may_wakeup(&client->dev))
> +		enable_irq_wake(tsdata->irq);
> +
> +	return 0;
> +}
> +
> +static int pixcir_i2c_ts_resume(struct i2c_client *client)
> +{
> +	struct pixcir_i2c_ts_data *tsdata =3D dev_get_drvdata(&client->dev)=
;
> +
> +	if (device_may_wakeup(&client->dev))
> +		disable_irq_wake(tsdata->irq);
> +
> +	return 0;
> +}
> +#else
> +#define	pixcir_i2c_ts_suspend	NULL
> +#define	pixcir_i2c_ts_resume	NULL
> +#endif
> +
> +static const struct i2c_device_id pixcir_i2c_ts_id[] =3D {
> +	{ "pixcir_ts", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, pixcir_i2c_ts_id);
> +
> +static struct i2c_driver pixcir_i2c_ts_driver =3D {
> +	.driver =3D {
> +		.owner	=3D THIS_MODULE,
> +		.name	=3D "pixcir_ts",
> +	},
> +	.probe		=3D pixcir_i2c_ts_probe,
> +	.remove		=3D pixcir_i2c_ts_remove,

__devexit_p().

> +	.suspend	=3D pixcir_i2c_ts_suspend,
> +	.resume		=3D pixcir_i2c_ts_resume,

dev_pm_ops.

> +	.id_table	=3D pixcir_i2c_ts_id,
> +};
> +
> +static int __init pixcir_i2c_ts_init(void)
> +{
> +	#ifdef DEBUG
> +		printk(KERN_EMERG "pixcir_i2c_init\n");
> +	#endif
> +
> +	pixcir_wq =3D create_singlethread_workqueue("pixcir_wq");

Not needed if you use threaded IRQ.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
