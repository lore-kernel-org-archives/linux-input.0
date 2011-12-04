From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] Driver for AUO In-Cell touchscreens using pixcir ICs
Date: Sun, 04 Dec 2011 14:31:41 +0100
Message-ID: <1323005501.3023.32.camel@mars>
References: <201112031509.12408.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52051 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab1LDNbr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Dec 2011 08:31:47 -0500
Received: by wgbdr13 with SMTP id dr13so5221292wgb.1
        for <linux-input@vger.kernel.org>; Sun, 04 Dec 2011 05:31:45 -0800 (PST)
In-Reply-To: <201112031509.12408.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Heiko,

 you can find some annotations below.

Thanks,
 -- chf

On Sat, 2011-12-03 at 15:09 +0100, Heiko St=FCbner wrote:=20
> Some displays from AUO have a so called in-cell touchscreen, meaning =
it
> is built directly into the display unit.
>=20
> Touchdata is gathered through PIXCIR Tango-ICs and processed in an
> Atmel ATmega168P with custom firmware. Communication between the host
> system and ATmega is done via I2C.
>=20
> Devices using this touch solution include the Dell Streak5 and the fa=
mily
> of Qisda ebook readers.
>=20
> The driver reports single- and multi-touch events including touch are=
a
> values.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/input/touchscreen/Kconfig         |   14 +
>  drivers/input/touchscreen/Makefile        |    1 +
>  drivers/input/touchscreen/auo-pixcir-ts.c |  657 +++++++++++++++++++=
++++++++++
>  include/linux/input/auo-pixcir-ts.h       |   57 +++
>  4 files changed, 729 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/auo-pixcir-ts.c
>  create mode 100644 include/linux/input/auo-pixcir-ts.h
>=20
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchs=
creen/Kconfig
> index 2b456a9..7da474e 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -98,6 +98,20 @@ config TOUCHSCREEN_ATMEL_MXT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called atmel_mxt_ts.
> =20
> +config TOUCHSCREEN_AUO_PIXCIR
> +	tristate "AUO in-cell touchscreen using Pixcir ICs"
> +	depends on I2C
> +	depends on GPIOLIB
> +	default n
> +	help
> +	  Say Y here if you have a AUO display with in-cell touchscreen
> +	  using Pixcir ICs.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called auo-pixcir-ts.
> +
>  config TOUCHSCREEN_BITSY
>  	tristate "Compaq iPAQ H3600 (Bitsy) touchscreen"
>  	depends on SA1100_BITSY
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touch=
screen/Makefile
> index a09c546..f0b4d16 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_TOUCHSCREEN_AD7879_SPI)	+=3D ad7879-sp=
i.o
>  obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+=3D ads7846.o
>  obj-$(CONFIG_TOUCHSCREEN_ATMEL_MXT)	+=3D atmel_mxt_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ATMEL_TSADCC)	+=3D atmel_tsadcc.o
> +obj-$(CONFIG_TOUCHSCREEN_AUO_PIXCIR)	+=3D auo-pixcir-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_BITSY)		+=3D h3600_ts_input.o
>  obj-$(CONFIG_TOUCHSCREEN_BU21013)       +=3D bu21013_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_CY8CTMG110)	+=3D cy8ctmg110_ts.o
> diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/inpu=
t/touchscreen/auo-pixcir-ts.c
> new file mode 100644
> index 0000000..22ea042
> --- /dev/null
> +++ b/drivers/input/touchscreen/auo-pixcir-ts.c
> @@ -0,0 +1,657 @@
> +/* drivers/input/touchscreen/auo-pixcir-ts.c
> + *
> + * Copyright (c) 2011 Heiko Stuebner <heiko@sntech.de>
> + *
> + * loosely based on auo_touch.c from Dell Streak vendor-kernel
> + *
> + * Copyright (c) 2008 QUALCOMM Incorporated.
> + * Copyright (c) 2008 QUALCOMM USA, INC.
> + *
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
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +#include <linux/input.h>
> +#include <linux/platform_device.h>
> +#include <linux/jiffies.h>
> +#include <linux/io.h>
> +#include <linux/uaccess.h>
> +#include <linux/miscdevice.h>
> +#include <linux/i2c.h>
> +#include <linux/semaphore.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/input/auo-pixcir-ts.h>
> +
> +/*
> + * Coordinate calculation:
> + * X1 =3D X1_LSB + X1_MSB*256
> + * Y1 =3D Y1_LSB + Y1_MSB*256
> + * X2 =3D X2_LSB + X2_MSB*256
> + * Y2 =3D Y2_LSB + Y2_MSB*256
> + */
> +#define AUO_PIXCIR_REG_X1_LSB		0x00
> +#define AUO_PIXCIR_REG_X1_MSB		0x01
> +#define AUO_PIXCIR_REG_Y1_LSB		0x02
> +#define AUO_PIXCIR_REG_Y1_MSB		0x03
> +#define AUO_PIXCIR_REG_X2_LSB		0x04
> +#define AUO_PIXCIR_REG_X2_MSB		0x05
> +#define AUO_PIXCIR_REG_Y2_LSB		0x06
> +#define AUO_PIXCIR_REG_Y2_MSB		0x07
> +
> +#define AUO_PIXCIR_REG_STRENGTH		0x0d
> +#define AUO_PIXCIR_REG_STRENGTH_X1_LSB	0x0e
> +#define AUO_PIXCIR_REG_STRENGTH_X1_MSB	0x0f
> +
> +#define AUO_PIXCIR_REG_RAW_DATA_X	0x2b
> +#define AUO_PIXCIR_REG_RAW_DATA_Y	0x4f
> +
> +#define AUO_PIXCIR_REG_X_SENSITIVITY	0x6f
> +#define AUO_PIXCIR_REG_Y_SENSITIVITY	0x70
> +#define AUO_PIXCIR_REG_INT_SETTING	0x71
> +#define AUO_PIXCIR_REG_INT_WIDTH	0x72
> +#define AUO_PIXCIR_REG_POWER_MODE	0x73
> +
> +#define AUO_PIXCIR_REG_VERSION		0x77
> +#define AUO_PIXCIR_REG_CALIBRATE	0x78
> +
> +#define AUO_PIXCIR_REG_TOUCHAREA_X1	0x1e
> +#define AUO_PIXCIR_REG_TOUCHAREA_Y1	0x1f
> +#define AUO_PIXCIR_REG_TOUCHAREA_X2	0x20
> +#define AUO_PIXCIR_REG_TOUCHAREA_Y2	0x21
> +
> +#define AUO_PIXCIR_REG_EEPROM_CALIB_X	0x42
> +#define AUO_PIXCIR_REG_EEPROM_CALIB_Y	0xad
> +
> +#define AUO_PIXCIR_INT_TPNUM_MASK	0xe0
> +#define AUO_PIXCIR_INT_TPNUM_SHIFT	5
> +#define AUO_PIXCIR_INT_RELEASE		(1 << 4)
> +#define AUO_PIXCIR_INT_ENABLE		(1 << 3)
> +#define AUO_PIXCIR_INT_POL_HIGH		(1 << 2)
> +#define AUO_PIXCIR_INT_MODE_MASK	0x03
> +
> +/*
> + * Power modes:
> + * active:	scan speed 60Hz
> + * sleep:	scan speed 10Hz can be auto-activated, wakeup on 1st touch
> + * deep sleep:	scan speed 1Hz can only be entered or left manually.
> + */
> +#define AUO_PIXCIR_POWER_ACTIVE		0x00
> +#define AUO_PIXCIR_POWER_SLEEP		0x01
> +#define AUO_PIXCIR_POWER_DEEP_SLEEP	0x02
> +#define AUO_PIXCIR_POWER_MASK		0x03
> +
> +#define AUO_PIXCIR_POWER_ALLOW_SLEEP	(1 << 2)
> +#define AUO_PIXCIR_POWER_IDLE_TIME(ms)	((ms & 0xf) << 4)
> +
> +#define AUO_PIXCIR_CALIBRATE		0x03
> +
> +#define AUO_PIXCIR_EEPROM_CALIB_X_LEN	62
> +#define AUO_PIXCIR_EEPROM_CALIB_Y_LEN	36
> +
> +#define AUO_PIXCIR_RAW_DATA_X_LEN	18
> +#define AUO_PIXCIR_RAW_DATA_Y_LEN	11
> +
> +#define AUO_PIXCIR_STRENGTH_ENABLE	(1 << 0)
> +
> +/* Touchscreen absolute values */
> +#define AUO_PIXCIR_REPORT_POINTS	2
> +#define AUO_PIXCIR_MAX_AREA		0xff
> +#define AUO_PIXCIR_PENUP_TIMEOUT_MS	10
> +
> +struct auo_pixcir_ts {
> +	struct i2c_client	*client;
> +	struct input_dev	*input;
> +	char			phys[32];
> +
> +	/* special handling for touch_indicate interupt mode */
> +	bool			touch_ind_mode;
> +
> +	wait_queue_head_t	wait;
> +	bool			stopped;
> +	bool			is_open;
> +};
> +
> +struct auo_point_t {
> +	int	coord_x;
> +	int	coord_y;
> +	int	area_major;
> +	int	area_minor;
> +	int	orientation;
> +};
> +
> +static int auo_pixcir_collect_data(struct auo_pixcir_ts *ts,
> +				   struct auo_point_t *point)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	struct auo_pixcir_ts_platdata *pdata =3D client->dev.platform_data;
> +	uint8_t raw_coord[8];
> +	uint8_t raw_area[4];
> +	int i, ret;
> +
> +	/* touch coordinates */
> +	ret =3D i2c_smbus_read_i2c_block_data(client, AUO_PIXCIR_REG_X1_LSB=
,
> +					    8, raw_coord);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to read coordinate, %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* touch area */
> +	ret =3D i2c_smbus_read_i2c_block_data(client, AUO_PIXCIR_REG_TOUCHA=
REA_X1,
> +					    4, raw_area);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "could not read touch area, %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i =3D 0; i < AUO_PIXCIR_REPORT_POINTS; i++) {
> +		point[i].coord_x =3D raw_coord[4*i+1] << 8 | raw_coord[4*i];
> +		point[i].coord_y =3D raw_coord[4*i+3] << 8 | raw_coord[4*i+2];
> +
> +		if (point[i].coord_x > pdata->x_max ||
> +		    point[i].coord_y > pdata->y_max) {
> +			dev_warn(&client->dev, "coordinates (%d,%d) invalid\n",
> +				point[i].coord_x, point[i].coord_y);
> +			point[i].coord_x =3D point[i].coord_y =3D 0;
> +		}
> +
> +		/* determine touch major, minor and orientation */
> +		point[i].area_major =3D max(raw_area[2*i], raw_area[2*i+1]);
> +		point[i].area_minor =3D min(raw_area[2*i], raw_area[2*i+1]);
> +		point[i].orientation =3D (raw_area[2*i] > raw_area[2*i+1]);
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t auo_pixcir_interrupt(int irq, void *dev_id)
> +{
> +	struct auo_pixcir_ts *ts =3D dev_id;
> +	struct i2c_client *client =3D ts->client;
> +	struct auo_pixcir_ts_platdata *pdata =3D client->dev.platform_data;
> +	struct auo_point_t point[AUO_PIXCIR_REPORT_POINTS];
> +	int i;
> +	int ret;
> +	int fingers =3D 0;
> +	int abs =3D -1;
> +
> +	while (!ts->stopped) {
> +
> +		/* check for up event in touch touch_ind_mode */
> +		if (ts->touch_ind_mode) {
> +			if (gpio_get_value(pdata->gpio_int) =3D=3D 0) {
> +				input_mt_sync(ts->input);
> +				input_report_key(ts->input, BTN_TOUCH, 0);
> +				input_sync(ts->input);
> +				break;
> +			}
> +		}
> +
> +		ret =3D auo_pixcir_collect_data(ts, point);
> +		if (ret < 0) {
> +			/* we want to loop only in touch_ind_mode */
> +			if (!ts->touch_ind_mode)
> +				break;
> +
> +			wait_event_timeout(ts->wait, ts->stopped,
> +				msecs_to_jiffies(AUO_PIXCIR_PENUP_TIMEOUT_MS));
> +			continue;
> +		}
> +
> +		for (i =3D 0; i < AUO_PIXCIR_REPORT_POINTS; i++) {
> +			if (point[i].coord_x > 0 || point[i].coord_y > 0) {
> +				input_report_abs(ts->input, ABS_MT_POSITION_X,
> +						 point[i].coord_x);
> +				input_report_abs(ts->input, ABS_MT_POSITION_Y,
> +						 point[i].coord_y);
> +				input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR,
> +						 point[i].area_major);
> +				input_report_abs(ts->input, ABS_MT_TOUCH_MINOR,
> +						 point[i].area_minor);
> +				input_report_abs(ts->input, ABS_MT_ORIENTATION,
> +						 point[i].orientation);
> +				input_mt_sync(ts->input);
> +
> +				/* use first finger as source for singletouch */
> +				if (fingers =3D=3D 0)
> +					abs =3D i;
> +
> +				/* number of touch points could also be queried
> +				 * via i2c but would require an additional call
> +				 */
> +				fingers++;
> +			}
> +		}
> +
> +		input_report_key(ts->input, BTN_TOUCH, fingers > 0);
> +
> +		if (abs > -1) {
> +			input_report_abs(ts->input, ABS_X, point[abs].coord_x);
> +			input_report_abs(ts->input, ABS_Y, point[abs].coord_y);
> +		}
> +
> +		input_sync(ts->input);
> +
> +		/* we want to loop only in touch_ind_mode */
> +		if (!ts->touch_ind_mode)
> +			break;
> +
> +		wait_event_timeout(ts->wait, ts->stopped,
> +				 msecs_to_jiffies(AUO_PIXCIR_PENUP_TIMEOUT_MS));
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Set the power mode of the device.
> + * Valid modes are
> + * - AUO_PIXCIR_POWER_ACTIVE
> + * - AUO_PIXCIR_POWER_SLEEP - automatically left on first touch
> + * - AUO_PIXCIR_POWER_DEEP_SLEEP
> + */
> +static int auo_pixcir_power_mode(struct auo_pixcir_ts *ts, int mode)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(client, AUO_PIXCIR_REG_POWER_MODE)=
;
> +	if (ret < 0) {
> +		dev_err(&client->dev, "unable to read reg %Xh, %d\n",
> +			AUO_PIXCIR_REG_POWER_MODE, ret);
> +		return ret;
> +	}
> +
> +	ret &=3D (~AUO_PIXCIR_POWER_MASK);
> +	ret |=3D mode;
> +
> +	ret =3D i2c_smbus_write_byte_data(client, AUO_PIXCIR_REG_POWER_MODE=
, ret);
> +	if (ret) {
> +		dev_err(&client->dev, "unable to write reg %Xh, %d\n",
> +			AUO_PIXCIR_REG_POWER_MODE, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int auo_pixcir_int_config(struct auo_pixcir_ts *ts, int int_s=
etting)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	struct auo_pixcir_ts_platdata *pdata =3D client->dev.platform_data;
> +	uint8_t value;
> +
> +	value =3D i2c_smbus_read_byte_data(client, AUO_PIXCIR_REG_INT_SETTI=
NG);
> +	if (value < 0) {

value is an unsigned int and can't be less than zero. An int value woul=
d
be more appropriate.

> +		dev_err(&client->dev, "unable to read reg %Xh, %d\n",
> +			AUO_PIXCIR_REG_INT_SETTING, value);
> +		return value;
> +	}
> +
> +	value &=3D (~AUO_PIXCIR_INT_MODE_MASK);
> +	value |=3D int_setting;
> +	value |=3D AUO_PIXCIR_INT_POL_HIGH; /* always use high for interrup=
ts */
> +
> +	value =3D i2c_smbus_write_byte_data(client, AUO_PIXCIR_REG_INT_SETT=
ING,
> +					  value);
> +	if (value < 0) {

the same here

> +		dev_err(&client->dev, "unable to write reg %Xh, %d\n",
> +			AUO_PIXCIR_REG_INT_SETTING, value);
> +		return value;
> +	}
> +
> +	if (pdata->int_setting =3D=3D AUO_PIXCIR_INT_TOUCH_IND)
> +		ts->touch_ind_mode =3D 1;
> +	else
> +		ts->touch_ind_mode =3D 0;
> +
> +	return 0;
> +}
> +
> +/* controll the generation of interrupts on the device side */
> +static int auo_pixcir_int_enable(struct auo_pixcir_ts *ts, int enabl=
e)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(client, AUO_PIXCIR_REG_INT_SETTING=
);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "unable to read reg %Xh, %d\n",
> +			AUO_PIXCIR_REG_INT_SETTING, ret);
> +		disable_irq(client->irq);
> +		return ret;
> +	}
> +
> +	if (enable)
> +		ret |=3D AUO_PIXCIR_INT_ENABLE;
> +	else
> +		ret &=3D ~AUO_PIXCIR_INT_ENABLE;
> +
> +	ret =3D i2c_smbus_write_byte_data(client, AUO_PIXCIR_REG_INT_SETTIN=
G,
> +					ret);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "unable to write reg %Xh, %d\n",
> +			AUO_PIXCIR_REG_INT_SETTING, ret);
> +		disable_irq(client->irq);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int auo_pixcir_start(struct auo_pixcir_ts *ts)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	int ret;
> +
> +	ret =3D auo_pixcir_power_mode(ts, AUO_PIXCIR_POWER_ACTIVE);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "could not set power mode, %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ts->stopped =3D false;
> +	mb();
> +	enable_irq(client->irq);
> +
> +	ret =3D auo_pixcir_int_enable(ts, 1);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "could not enable interrupt, %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int auo_pixcir_stop(struct auo_pixcir_ts *ts)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	int ret;
> +
> +	ret =3D auo_pixcir_int_enable(ts, 0);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "could not disable interrupt, %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/* disable receiving of interrupts */
> +	disable_irq(client->irq);
> +	ts->stopped =3D true;
> +	mb();
> +	wake_up(&ts->wait);
> +
> +	return auo_pixcir_power_mode(ts, AUO_PIXCIR_POWER_DEEP_SLEEP);
> +}
> +
> +static int auo_pixcir_input_open(struct input_dev *dev)
> +{
> +	struct auo_pixcir_ts *ts =3D input_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D auo_pixcir_start(ts);
> +	if (ret)
> +		return ret;
> +
> +	ts->is_open =3D true;
> +
> +	return 0;
> +}
> +
> +static void auo_pixcir_input_close(struct input_dev *dev)
> +{
> +	struct auo_pixcir_ts *ts =3D input_get_drvdata(dev);
> +
> +	ts->is_open =3D false;
> +
> +	auo_pixcir_stop(ts);
> +
> +	return;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int auo_pixcir_suspend(struct device *dev)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct auo_pixcir_ts *ts =3D (struct auo_pixcir_ts *)
> +						i2c_get_clientdata(client);
> +
> +	/* if device isn't open it's stopped already */
> +	if (ts->is_open) {
> +		if (device_may_wakeup(&client->dev)) {
> +			enable_irq_wake(client->irq);
> +			return auo_pixcir_power_mode(ts,
> +						     AUO_PIXCIR_POWER_SLEEP);
> +		} else {
> +			auo_pixcir_stop(ts);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int auo_pixcir_resume(struct device *dev)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct auo_pixcir_ts *ts =3D (struct auo_pixcir_ts *)
> +						i2c_get_clientdata(client);
> +
> +	/* if device isn't open it was stopped and should stay that way */
> +	if (ts->is_open) {
> +		if (device_may_wakeup(&client->dev)) {
> +			disable_irq_wake(client->irq);
> +			/* automatic wakeup on first-touch */
> +		} else if (ts->is_open) {
> +			return auo_pixcir_start(ts);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +SIMPLE_DEV_PM_OPS(auo_pixcir_pm_ops, auo_pixcir_suspend, auo_pixcir_=
resume);
> +#endif
> +
> +static int __devinit auo_pixcir_probe(struct i2c_client *client,
> +				      const struct i2c_device_id *id)
> +{
> +	struct auo_pixcir_ts *ts;
> +	struct auo_pixcir_ts_platdata *pdata =3D client->dev.platform_data;
> +	struct input_dev *input_dev;
> +	int ret;
> +
> +	if (!pdata)
> +		return -EINVAL;
> +
> +	ts =3D kzalloc(sizeof(struct auo_pixcir_ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	ret =3D gpio_request(pdata->gpio_int, "auo_pixcir_ts_int");
> +	if (ret) {
> +		dev_err(&client->dev, "request of gpio %d failed, %d\n",
> +			pdata->gpio_int, ret);
> +		goto err_gpio_int;
> +	}
> +
> +	ret =3D gpio_request(pdata->gpio_rst, "auo_pixcir_ts_rst");
> +	if (ret) {
> +		dev_err(&client->dev, "request of gpio %d failed, %d\n",
> +			pdata->gpio_int, ret);
> +		goto err_gpio_rst;
> +	}
> +
> +	if (pdata->init_hw)
> +		pdata->init_hw();
> +
> +	ts->client =3D client;
> +	ts->touch_ind_mode =3D 0;
> +	init_waitqueue_head(&ts->wait);
> +
> +	snprintf(ts->phys, sizeof(ts->phys),
> +		 "%s/input0", dev_name(&client->dev));
> +
> +	input_dev =3D input_allocate_device();
> +	if (!input_dev) {
> +		dev_err(&client->dev, "could not allocate input device\n");
> +		goto err_input_alloc;
> +	}
> +
> +	ts->input =3D input_dev;
> +
> +	input_dev->name =3D "auo_pixcir_ts";
> +	input_dev->phys =3D ts->phys;
> +	input_dev->id.bustype =3D BUS_I2C;
> +	input_dev->dev.parent =3D &client->dev;
> +
> +	input_dev->open =3D auo_pixcir_input_open;
> +	input_dev->close =3D auo_pixcir_input_close;
> +
> +	__set_bit(EV_ABS, input_dev->evbit);
> +	__set_bit(EV_KEY, input_dev->evbit);
> +
> +	__set_bit(BTN_TOUCH, input_dev->keybit);
> +
> +	/* For single touch */
> +	input_set_abs_params(input_dev, ABS_X, 0, pdata->x_max, 0, 0);
> +	input_set_abs_params(input_dev, ABS_Y, 0, pdata->y_max, 0, 0);
> +
> +	/* For multi touch */
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
> +			     pdata->x_max, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
> +			     pdata->y_max, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
> +			     AUO_PIXCIR_MAX_AREA, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR, 0,
> +			     AUO_PIXCIR_MAX_AREA, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_ORIENTATION, 0, 1, 0, 0);
> +
> +	ret =3D i2c_smbus_read_byte_data(client, AUO_PIXCIR_REG_VERSION);
> +	if (ret < 0)
> +		goto err_fw_vers;
> +	dev_info(&client->dev, "firmware version 0x%X\n", ret);
> +
> +	ret =3D auo_pixcir_int_config(ts, pdata->int_setting);
> +	if (ret)
> +		goto err_fw_vers;
> +
> +	/* disable irqs on the device side before irq-request */
> +	auo_pixcir_int_enable(ts, 0);
> +	ts->stopped =3D true;
> +	ts->is_open =3D false;
> +
> +	ret =3D request_threaded_irq(client->irq, NULL, auo_pixcir_interrup=
t,
> +				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +				   input_dev->name, ts);
> +	if (ret) {
> +		dev_err(&client->dev, "irq %d requested failed\n", client->irq);
> +		goto err_fw_vers;
> +	}
> +
> +	/* stop device and put it into deep sleep until it is opened */
> +	ret =3D auo_pixcir_stop(ts);
> +	if (ret < 0)
> +		goto err_input_register;
> +
> +	ret =3D input_register_device(input_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "could not register input device\n");
> +		goto err_input_register;
> +	}
> +
> +	input_set_drvdata(ts->input, ts);
> +
> +	i2c_set_clientdata(client, ts);
> +
> +	return 0;
> +
> +err_input_register:
> +	free_irq(client->irq, ts);
> +err_fw_vers:
> +	input_free_device(input_dev);
> +err_input_alloc:
> +	if (pdata->exit_hw)
> +		pdata->exit_hw();
> +	gpio_free(pdata->gpio_rst);
> +err_gpio_rst:
> +	gpio_free(pdata->gpio_int);
> +err_gpio_int:
> +	kfree(ts);
> +
> +	return ret;
> +}
> +
> +static int __devexit auo_pixcir_remove(struct i2c_client *client)
> +{
> +	struct auo_pixcir_ts *ts =3D (struct auo_pixcir_ts *)
> +						i2c_get_clientdata(client);
> +	struct auo_pixcir_ts_platdata *pdata =3D client->dev.platform_data;
> +
> +	auo_pixcir_stop(ts);
> +
> +	free_irq(client->irq, ts);
> +
> +	input_unregister_device(ts->input);
> +	input_free_device(ts->input);

to quote input.c:

/**
 * input_free_device - free memory occupied by input_dev structure
 * @dev: input device to free
 *
 * This function should only be used if input_register_device()
 * was not called yet or if it failed. Once device was registered
 * use input_unregister_device() and memory will be freed once last
 * reference to the device is dropped.
 *
 * Device should be allocated by input_allocate_device().
 *
 * NOTE: If there are references to the input device then memory
 * will not be freed until last reference is dropped.
 */

the same applies to the error path in auo_pixcir_probe()

> +
> +	if (pdata->exit_hw)
> +		pdata->exit_hw();
> +
> +	gpio_free(pdata->gpio_int);
> +	gpio_free(pdata->gpio_rst);
> +
> +	kfree(ts);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id auo_pixcir_idtable[] =3D {
> +	{ "auo_pixcir_ts", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, auo_pixcir_idtable);
> +
> +static struct i2c_driver auo_pixcir_driver =3D {
> +	.driver =3D {
> +		.owner	=3D THIS_MODULE,
> +		.name	=3D "auo_pixcir_ts",
> +#ifdef CONFIG_PM
> +		.pm	=3D &auo_pixcir_pm_ops,
> +#endif
> +	},
> +	.probe		=3D auo_pixcir_probe,
> +	.remove		=3D __devexit_p(auo_pixcir_remove),
> +	.id_table	=3D auo_pixcir_idtable,
> +};
> +
> +static int __init auo_pixcir_init(void)
> +{
> +	return i2c_add_driver(&auo_pixcir_driver);
> +}
> +module_init(auo_pixcir_init);
> +
> +static void __exit auo_pixcir_exit(void)
> +{
> +	i2c_del_driver(&auo_pixcir_driver);
> +}
> +module_exit(auo_pixcir_exit);
> +
> +MODULE_DESCRIPTION("AUO-PIXCIR touchscreen driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
> diff --git a/include/linux/input/auo-pixcir-ts.h b/include/linux/inpu=
t/auo-pixcir-ts.h
> new file mode 100644
> index 0000000..d4221be
> --- /dev/null
> +++ b/include/linux/input/auo-pixcir-ts.h
> @@ -0,0 +1,57 @@
> +/* drivers/input/touchscreen/auo-pixcir-ts.h
> + *
> + * Copyright (c) 2011 Heiko Stuebner <heiko@sntech.de>
> + *
> + * based on auo_touch.h from Dell Streak kernel
> + *
> + * Copyright (c) 2008 QUALCOMM Incorporated.
> + * Copyright (c) 2008 QUALCOMM USA, INC.
> + *
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
> +#ifndef __AUO_PIXCIR_TS_H__
> +#define __AUO_PIXCIR_TS_H__
> +
> +/*
> + * Interrupt modes:
> + * periodical:		interrupt is asserted periodicaly
> + * compare coordinates:	interrupt is asserted when coordinates chang=
e
> + * indicate touch:	interrupt is asserted during touch
> + */
> +#define AUO_PIXCIR_INT_PERIODICAL	0x00
> +#define AUO_PIXCIR_INT_COMP_COORD	0x01
> +#define AUO_PIXCIR_INT_TOUCH_IND	0x02
> +
> +/*
> + * @gpio_int		interrupt gpio
> + * @gpio_rst		reset gpio, used in init_hw and exit_hw
> + * @int_setting		one of AUO_PIXCIR_INT_*
> + * @init_hw		hardwarespecific init
> + * @exit_hw		hardwarespecific shutdown
> + * @x_max		x-resolution
> + * @y_max		y-resolution
> + */
> +struct auo_pixcir_ts_platdata {
> +	int gpio_int;
> +	int gpio_rst;
> +
> +	int int_setting;
> +
> +	void (*init_hw)(void);
> +	void (*exit_hw)(void);
> +
> +	unsigned int x_max;
> +	unsigned int y_max;
> +};
> +
> +#endif



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
